local OPTIONAL_LIBRARY_ENV = "HOMETOWN_MOD_I18N_OPTIONAL_LIBS"

-- Every name the override accepts, for the error message when one is unknown.
local function library_names(info)
    local names = {}
    for id in pairs(info.libs) do
        names[#names + 1] = id
    end
    table.sort(names)
    for index, id in ipairs(names) do
        local alias = info.libs[id].alias
        if alias then
            names[index] = id .. " (" .. alias .. ")"
        end
    end
    return table.concat(names, ", ")
end

-- Names resolve against every library the engine scanned, not just the ones
-- optionalLibraries lists, so any library can be toggled for a launch.
local function resolve_library(info, name)
    if info.libs[name] then
        return name
    end
    for id, lib in pairs(info.libs) do
        if lib.alias == name then
            return id
        end
    end
    return nil
end

-- Launch-time override, e.g. HOMETOWN_MOD_I18N_OPTIONAL_LIBS="mgr,umr" or "mgr,-umr".
-- Bare names and "+name" force a library on, "-name" forces it off. Nothing is
-- persisted: optionalLibraries in mod.json stays the source of truth.
local function applyOptionalLibraryOverride(info, selection)
    local spec = os.getenv(OPTIONAL_LIBRARY_ENV)
    if spec == nil or spec:match("^%s*$") then
        return
    end

    -- Dependencies are pulled in only for libraries this override turned on, so
    -- a library that mod.json leaves off for its own reasons still stays off.
    local queue = {}
    local queued = {}
    local function force_on(id)
        selection[id] = true
        if not queued[id] then
            queued[id] = true
            queue[#queue + 1] = id
        end
    end

    -- Conflicts only consider libraries this override turned off, so a "false"
    -- inherited from mod.json never blocks enabling something that needs it.
    local forced_off = {}

    for entry in spec:gmatch("[^,]+") do
        entry = entry:match("^%s*(.-)%s*$")
        if entry ~= "" then
            local on = entry:sub(1, 1) ~= "-"
            local id = resolve_library(info, on and entry:gsub("^%+", "") or entry:sub(2))
            if not id then
                error(OPTIONAL_LIBRARY_ENV .. " names an unknown library: " .. entry ..
                    "\nvalid names: " .. library_names(info))
            end
            if on then
                force_on(id)
            else
                selection[id] = false
                forced_off[id] = true
            end
        end
    end

    local index = 1
    while index <= #queue do
        local id = queue[index]
        index = index + 1
        for _, dependency in ipairs((info.libs[id] or {}).dependencies or {}) do
            if forced_off[dependency] then
                error(id .. " requires disabled library: " .. dependency)
            end
            force_on(dependency)
        end
    end

    if #queue == 0 and not next(forced_off) then
        return
    end
    local applied = {}
    for _, id in ipairs(queue) do
        applied[#applied + 1] = id .. "=on"
    end
    for id in pairs(forced_off) do
        applied[#applied + 1] = id .. "=off"
    end
    table.sort(applied)
    print("[hometown-mod-i18n] " .. OPTIONAL_LIBRARY_ENV .. '="' .. spec .. '" -> ' ..
        table.concat(applied, ", "))
end

local function applyOptionalLibrarySelection(info)
    local selection = info.optionalLibraries or {}
    if selection == nil then
        return
    end
    if type(selection) ~= "table" then
        error("mod.json optionalLibraries must be an object")
    end

    applyOptionalLibraryOverride(info, selection)

    local disabled = {}
    for id, enabled in pairs(selection) do
        if type(id) ~= "string" or id == "" or type(enabled) ~= "boolean" then
            error("mod.json optionalLibraries must map library IDs to booleans")
        end
        if enabled then
            if not info.libs[id] then
                error("enabled optional library is missing: " .. id)
            end
        else
            disabled[id] = true
        end
    end

    -- A retained library cannot run without one of its required dependencies.
    -- optionalDependencies only affect ordering and do not participate here.
    local changed = true
    while changed do
        changed = false
        for id, lib in pairs(info.libs) do
            if not disabled[id] then
                for _, dependency in ipairs(lib.dependencies or {}) do
                    if disabled[dependency] then
                        disabled[id] = true
                        changed = true
                        break
                    end
                end
            end
        end
    end

    for id in pairs(disabled) do
        info.libs[id] = nil
    end

    local lib_order = {}
    for _, id in ipairs(info.lib_order or {}) do
        if info.libs[id] then
            lib_order[#lib_order + 1] = id
        end
    end
    info.lib_order = lib_order
end

applyOptionalLibrarySelection(Mod.info)

function Mod:init()
    self:setMusicVolumes()
end


function Mod:postInit(newfile)
    print("Loaded "..self.info.name.."!")

    -- Sans dialogue font: rasterize at 14px (DeltaruneChinese char_size 14, keeps the
    -- pixelated DR look via mono hinting) and draw at 2x scale instead of re-rasterizing
    -- at 28px. [font:sans] has no size argument, so font_size is nil here.
    HookSystem.hook(Assets, "getFontScale", function(orig, path, size)
        if path == "sans" and size == nil then
            return 2
        end
        return orig(path, size)
    end)

    if os.getenv("KRISTAL_MOD_SMOKE") == "1" then
        print("EL_LANG=" .. tostring(Game.lang))
        print("EL_T1=" .. tostring(Game:hasStr("hometown.smoke.door") and Game:loc("hometown.smoke.door") or "NO"))
        print("EL_T2=" .. tostring(Game:hasStr("hometown.smoke.documents") and Game:loc("hometown.smoke.documents") or "NO"))
        print("EL_T4=" .. tostring(Game:hasStr("hometown.smoke.names_seam_pronounced_shawm") and Game:loc("hometown.smoke.names_seam_pronounced_shawm") or "NO"))
        print("EL_T3=" .. tostring(Game:hasStr("untranslated_stuff_xyz") and Game:loc("untranslated_stuff_xyz") or "FALLBACK_OK"))
        Game.stage:setWeather("rain", false, false)
        assert(Game.stage:hasWeather("rain"), "weather smoke: rain was not applied")
        Game.stage:resetWeather()
        assert(not Game.stage:hasWeather("rain"), "weather smoke: rain was not cleared")
        print("EL_WEATHER=PASS")
        print("KRISTAL_MOD_SMOKE=PASS")
        love.event.quit()
    end

    -- 临时 hook
    -- Keep the Hometown north gate open for testing. The initial map is not
    -- town_north, so its noellegate event may not exist yet.
    Game:setFlag("noelle_gate_open", true)
    if Game.world and Game.world.map and Game.world.map.id == "light/hometown/town_north" then
        local gate = Game.world.map:getEvent("noellegate")
        if gate then
            gate:open()
        end
    end

    Game:setFlag("hometown_time", "sunrise")

end


function Mod:setMusicVolumes()
    MUSIC_VOLUMES["deltarune/noelle_house_wip"] = 0.9
    MUSIC_VOLUMES["deltarune/noelle_distant"] = 0.8
end

function Mod:onMapMusic(map, music)
	if music == "hometown" then
		if Game:getFlag("hometown_time", "day") == "day" then
			return "deltarune/town_day"
		elseif Game:getFlag("hometown_time", "day") == "sunset" then
			return "deltarune/town"
		elseif Game:getFlag("hometown_time", "day") == "night" then
			return "forecasted_hometown_night"
		elseif Game:getFlag("hometown_time", "day") == "sunrise" then
			return "deltarune/mus_birdnoise"
		end
	end
	if music == "church" then
		if Game:getFlag("hometown_time", "day") == "night" then
			return "deltarune/church_lw_night"
		else
			return "deltarune/church_lw"
		end
	end
	if music == "deltarune/mus_school" then
		if Game:getFlag("hometown_time", "day") == "sunset" then
			return "deltarune/mus_birdnoise"
		elseif Game:getFlag("hometown_time", "day") == "night" then
			return "deltarune/night_ambience"
		else
			return "deltarune/mus_school"
		end
	end
	if music == "deltarune/mus_birdnoise" and Game:getFlag("hometown_time", "day") == "night" then
		return "deltarune/night_ambience"
	end
end

function Mod:onMapBorder(map, border)
	if border == "leaves" and Game:getFlag("hometown_time", "day") == "night" then
		return "leaves_night"
	end
end

function Mod:loadObject(world, name, data)
    if data.gid then
		local tobj = world.map:createTileObject(data)
		tobj.day_mode = data.properties["day"] or nil
		tobj.night_mode = data.properties["night"] or nil
		tobj.sunset_mode = data.properties["sunset"] or nil
		tobj.sunrise_mode = data.properties["sunrise"] or nil
		tobj.rain_mode = data.properties["rain"] or nil
		return tobj
    end
end
