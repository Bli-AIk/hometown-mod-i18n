---@param cutscene WorldCutscene
return function(cutscene)
    cutscene:enableMovement()
    local part_maker = Game.world.timer:every(1/30, function()
        local x, y = Game.world.player:getRelativePos(Game.world.player.width/2, Game.world.player.height)
        Game.world:spawnObject(FMBall(x, y), Game.world.player.layer + 2)
    end)
    cutscene:wait((90+90+10)/30)
    Game.world:spawnObject(FMCeilingFog(), Game.world.player.layer + 3)
    --[[Game.world.timer:script(function(wait)
        local f = 0
        while f < 30 do
            Object.startCache()
            for _,other in ipairs(Game.stage:getObjects(FMBall)) do
                if other:collidesWith(Game.world.player) then
                    assert(other.type ~= FMBall.TYPES.back)
                    local scale = 2
                    other.physics.speed_x = other.physics.speed_x + (-4 + Utils.random(8)) * scale
                    other.physics.speed_y = other.physics.speed_y - (Utils.random(3)) * scale
                    other.back.physics.speed_x = other.physics.speed_x
                    other.back.physics.speed_y = other.physics.speed_y
                end
            end
            Object.endCache()
            f = f + 1
            wait()
        end
    end)]]
end