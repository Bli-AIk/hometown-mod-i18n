return
---@param cutscene WorldCutscene
function(cutscene)
    local noelle = cutscene:getCharacter("noelle")
    Game:setFlag("balls", true)
    cutscene:detachCamera()
   --- noelle:setPosition(990, 345)
    noelle.layer = noelle.layer + 25
    ---cutscene:panTo(950, 0, 0)

    cutscene:setAnimation(noelle, "make_fountain/grab_knife")
    cutscene:wait(70/30)
    local noelle_x, noelle_y = noelle:getRelativePos(0, 0)
    local knife_shine = Sprite("effects/make_fountain/knife_shine", noelle_x + 2, noelle_y + 66)
    knife_shine:setScale(2)
    knife_shine:setOriginExact(4, 4)
    knife_shine:setAnimation({"effects/make_fountain/knife_shine", 1/3.75, false, callback=function(sprite)
        sprite:remove()
    end})
    knife_shine:setLayer(noelle.layer - 1)
    Game.world:addChild(knife_shine)
    cutscene:wait(2)

    local blaze_vfx = true
    local blaze_vfx_off_for_one_frame_for_some_reason = false
    local blaze_vfx_timer = 0
    cutscene:setAnimation(noelle, "make_fountain/target")
    Game.world.timer:every(1/30, function()
        if blaze_vfx_off_for_one_frame_for_some_reason then
            blaze_vfx_off_for_one_frame_for_some_reason = false
        else
            cutscene:playSound("fountain_target")
            blaze_vfx_timer = blaze_vfx_timer + 1
            local blaze_shine = Sprite("effects/make_fountain/blaze_shine", noelle_x - 40 + blaze_vfx_timer * 6, noelle_y + 10 + Utils.random(20))
            blaze_shine:setScale(2)
            blaze_shine:setOriginExact(4, 4)
            blaze_shine:setAnimation({"effects/make_fountain/blaze_shine", 1/15, false, callback=function(sprite)
                sprite:remove()
            end})
            blaze_shine:setLayer(noelle.layer - 1)
            Game.world:addChild(blaze_shine)
        end
        return blaze_vfx
    end)
    cutscene:wait(1/3)
    blaze_vfx_off_for_one_frame_for_some_reason = true
    cutscene:wait(1/30)
    cutscene:wait(1/3)
    blaze_vfx = false

   
    local pillar = FMPillar(noelle.x, noelle.y, noelle)
    
    
    
    
  
    cutscene:setAnimation(noelle, "make_fountain/make")
cutscene:wait(0.5)
cutscene:shakeCamera(10,10,4)
Assets.playSound("hurt")
cutscene:wait(0.5)
cutscene:shakeCamera(10,10,4)
Assets.playSound("hurt")
cutscene:wait(1)


 do
        local fmake = Assets.playSound("fountain_make", 1, DT/BASE_DT)
        cutscene:during(function ()
            if not fmake:isPlaying() then return false end
            fmake:setPitch(DT/BASE_DT)
        end)
    end
Game.world:spawnObject(pillar, noelle.layer - 0.5)
cutscene:shakeCamera(10,10,4)
Assets.playSound("hurt")
--local white_house = Sprite("world/maps/tilesets/room1/spr_cutscene_32_room_black_white", 1, 1)
  --white_house:setColor(0.9,0.9,0.9)
    --white_house:setLayer(noelle.layer - 1)
    --white_house.alpha = 0
    --white_house:fadeTo(1, 0.3)
    --Game.world:addChild(white_house)


    local center_x = noelle.x 
    local center_y = noelle.y 
    cutscene:wait(0.2)
    cutscene:setAnimation(noelle, "make_fountain/make_loop")

    cutscene:wait(6)
    --white_house:fadeOutAndRemove(.4)
    cutscene:setSprite(noelle, "make_fountain/make_stop")
    noelle:removeFX("fm_invert")
    local deep_noise = Assets.playSound("deep_noise",1,2)
    deep_noise:setLooping(true)
    local part_maker = Game.world.map.timer:every(1/30, function()
        local x, y = center_x, center_y
            Game.world:spawnObject(FMBall(x, y), Game.world.player.layer - 2)
    end)
    local ceiling_fog = FMCeilingFog()
    Game.world:spawnObject(ceiling_fog, Game.world.player.layer + 3)
    cutscene:wait(3)
    

    --noelle.layer = noelle.layer - 25
    local ball_col_check = true
    cutscene:during(function()
        if not ball_col_check then return false end

        Object.startCache()
        for _,other in ipairs(Game.stage:getObjects(FMBall)) do
            ---@cast other FMBall
            if other:collidesWith(noelle) then
                assert(other.type ~= FMBall.TYPES.back)
                local scale = 2
                other.physics.speed_x = other.physics.speed_x + (-4 + Utils.random(8)) * scale
                other.physics.speed_y = other.physics.speed_y - (Utils.random(3)) * scale * 4
                other.back.physics.speed_x = other.physics.speed_x
                other.back.physics.speed_y = other.physics.speed_y
            end
        end
        Object.endCache()
    end)
    cutscene:setSprite(noelle, "make_fountain/jump_off")
    -- TODO: Actually make this accurate
    noelle.timescale = 1.5
    noelle.physics.speed_y = -16/3
    noelle.physics.speed_x = -2
    noelle.physics.gravity = 1/2
    cutscene:wait(function() return noelle.y >= 300 end)
    noelle.timescale = 1
    noelle.y = 300
    ball_col_check = false
    cutscene:setSprite(noelle, "make_fountain/jump_off_landed")
    noelle.physics.speed_y = 0
    noelle.physics.speed_x = 0
    noelle.physics.gravity = 0
    cutscene:wait(2)
    
    
  
    noelle.sprite:stop()
    cutscene:wait(0.5)
 

    cutscene:wait(function ()
        return ceiling_fog.cur_height > (280)
    end)
    Game.world.timer:doWhile(function ()
        return deep_noise:getVolume() >= 0
    end, function ()
        deep_noise:setVolume(deep_noise:getVolume() - (DT/4))
    end, function ()
        deep_noise:stop()
        deep_noise:release()
        deep_noise = nil
    end)
    cutscene:wait(function ()
        return ceiling_fog.cur_height > (340)
    end)
    cutscene:text("[style:GONER]Uhh yeah, you're done")
end