function Mod:init()
    MUSIC_VOLUMES = {
        ["battle"] = 0.7, 
        ["bloom_f"] = 0.4,
        ["fate"]    = 3, 
    }
    Game:registerEvent("squeak", function(data)
        return Squeak(data.x, data.y, {data.width, data.height, data.polygon})
    end)
    Game:registerEvent("wind_tunnel", function(data)
        return WindTunnel(data.x, data.y, {data.width, data.height, data.polygon}, data)
    end)
    Game:registerEvent("heartscreen", function(data)
        return HeartScreen(data)
    end)
    Game:registerEvent("heartbutton", function(data)
        return HeartButton(data)
    end)
    Game:registerEvent("tornado_spawner", function(data)
        return TornadoSpawner(data.x, data.y, {data.width, data.height, data.polygon}, data)
    end)
    Game:registerEvent("warning_spawner", function(data)
        return WarningSpawner(data.x, data.y, data)
    end)
     Game:registerEvent("dynapoint", function(data)
        return DynamicSavepoint(data.x, data.y, data)
    end)
    Game:registerEvent("shadow", function(data)
        return PerspectiveShadow(data)
    end)
    Game:registerEvent("frozenenemy", function(data)
    return FrozenEnemy(data.properties["actor"], data.x, data.y, {
        facing = data.properties.facing,
        solid = data.properties.solid,
        encounter = data.properties.encounter
    })
    end)
    print("Loaded " .. self.info.name .. "!")
end

function Mod.scr_wave(arg0, arg1, speed_seconds, phase)
    local a4 = (arg1 - arg0) * 0.5;
    return arg0 + a4 + (math.sin((((Kristal.getTime()) + (speed_seconds * phase)) / speed_seconds) * (2 * math.pi)) * a4);
end


Mod.wave_shader = love.graphics.newShader([[
    extern number wave_sine;
    extern number wave_mag;
    extern number wave_height;
    extern vec2 texsize;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
    {
        number i = texture_coords.y * texsize.y;
        vec2 coords = vec2(max(0.0, min(1.0, texture_coords.x + (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + 0.0)));
        return Texel(texture, coords) * color;
    }
]])

function Mod:postInit(is_new_file)
    if is_new_file then
        Game:setFlag("footstep", false)
        Game:setFlag("enemies_killed", 0)
        Game:setFlag("geno", false)
    end 
end 

function Mod:onFootstep(chara, num)
    if Game:getFlag("footstep") then 
        Assets.playSound("step"..num, 0.8)
    end 
end 

