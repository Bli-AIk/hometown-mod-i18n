function Mod:init()
    Game:registerEvent("squeak", function(data)
        return Squeak(data.x, data.y, {data.width, data.height, data.polygon})
    end)
    Game:registerEvent("wind_tunnel", function(data)
        return WindTunnel(data.x, data.y, {data.width, data.height, data.polygon}, data)
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

