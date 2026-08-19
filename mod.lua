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
