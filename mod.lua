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
        print("EL_T1=" .. tostring(Game:hasStr("* (It's a door.)") and Game:loc("* (It's a door.)") or "NO"))
        print("EL_T2=" .. tostring(Game:hasStr("* (Documents...)") and Game:loc("* (Documents...)") or "NO"))
        print("EL_T4=" .. tostring(Game:hasStr("* The name's Seam.\n[wait:5]* Pronounced \"Shawm.\"") and Game:loc("* The name's Seam.\n[wait:5]* Pronounced \"Shawm.\"") or "NO"))
        print("EL_T3=" .. tostring(Game:hasStr("untranslated_stuff_xyz") and Game:loc("untranslated_stuff_xyz") or "FALLBACK_OK"))
        print("KRISTAL_MOD_SMOKE=PASS")
        love.event.quit()
    end
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
