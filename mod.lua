local function applyOptionalLibrarySelection(info)
    local selection = info.optionalLibraries
    if selection == nil then
        return
    end
    if type(selection) ~= "table" then
        error("mod.json optionalLibraries must be an object")
    end

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
