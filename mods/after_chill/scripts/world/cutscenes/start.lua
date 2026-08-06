return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    piano = function(cutscene)
        local nurse = Sprite("npcs/nurse", 316, 123) 
        Game.world:addChild(nurse)
        nurse:setLayer(9999)
        nurse:setScale(2)
        cutscene:detachFollowers()
        local kris = cutscene:getCharacter("kris")
        local noelle = cutscene:getCharacter("noelle") 
        kris:setFacing("up")
        noelle:setFacing("up")
        noelle:setPosition(480, 253)
        cutscene:wait(0.3)
        -- local sfx = Assets.playSound("kris_legend")
        -- cutscene:wait(16.3)
        cutscene:wait(cutscene:playSound("pianonoise"))
        cutscene:wait(0.2)
        cutscene:text("* W[wait:2]-wow,[wait:2] Kris, you've always been good at playing the piano.", "blush_surprise_smile", "noelle")
        cutscene:text("* Ever since we were\nkids.", "blush_smile_closed", "noelle")
        cutscene:wait(0.5)
        cutscene:text("* Those were good times.", "question", "noelle")
        cutscene:wait(0.3)
        noelle:setFacing("left")
        cutscene:wait(0.2)
        cutscene:text("* I really wonder how Berdly's doing.", "sad_smile", "noelle")
        cutscene:text("* He probably fainted from all the studying he was doing!", "blush_finger", "noelle")
        cutscene:wait(0.5)
        local sprites = {}
        cutscene:text("* Faha.", "smile_side", "noelle")
        Game.fader:fadeOut(nil, {color = COLORS.white, speed = 0.5})
        local noelle_spr = Sprite("party/noelle/dark/battle/defeat_1")
        table.insert(sprites, noelle_spr)
        local berdly_spr = Sprite("enemies/berdly")
        table.insert(sprites, berdly_spr)
        local kris_spr = Sprite("party/kris/dark/battle/defend_6")
        table.insert(sprites, kris_spr)
        Game.stage:addChild(berdly_spr)
        Game.stage:addChild(noelle_spr)
        Game.stage:addChild(kris_spr)
        kris_spr:setPosition(100, 120)
        berdly_spr:setPosition(450, 75)
        noelle_spr:setPosition(290, 190)
        local fx  
        for _, sprite in ipairs(sprites) do 
        sprite.alpha = 0
        sprite:setScale(2)
        sprite.layer = 9999
        fx = sprite:addFX(ColorMaskFX(COLORS.black, 1))
        end 
        for _, sprite in ipairs(sprites) do 
            Game.stage.timer:tween(0.5, sprite, {alpha = 1})
        end 
        cutscene:wait(0.5)
        for _, sprite in ipairs(sprites) do 
            sprite:fadeOutAndRemove(0.5)
        end 
        noelle:setSprite("head_lowered_look_left")
        Game.fader:fadeIn(nil, {speed = 0.5})
        Assets.playSound("ominous", 1, 0.7)
        cutscene:wait(2)
        cutscene:text("* (N-[wait:2]no.. Susie said...)", nil, "noelle")
        cutscene:text("* (She said...[wait:5] that it was just a dream..)", nil, "noelle")
        cutscene:text("* (It felt...[wait:5] so real...)", nil, "noelle")
        cutscene:wait(0.5)
        noelle:resetSprite()
        noelle:setFacing("up")
        cutscene:text("[speed:0.7]* I[wait:2]-I'm going to go check up on my father.", "confused_surprise_b", "noelle")
        noelle:setSprite("walk_sad")
        cutscene:wait(cutscene:walkTo(noelle, noelle.x, 296))
        cutscene:wait(cutscene:walkTo(noelle, 178, noelle.y, 2.5))
        cutscene:wait(cutscene:walkTo(noelle, noelle.x, 210))
        Assets.playSound("dooropen")
        noelle:fadeOutAndRemove(0.2)
        Assets.playSound("doorclose")
        Game:removePartyMember("kris")
        Game:removePartyMember("noelle")
        cutscene:wait(0.2)
        cutscene:wait(cutscene:mapTransition("light/hometown/interior/hospital_rudy"))
        local kris = cutscene:getCharacter("kris")
        kris.sprite.visible = false
        local noelle = cutscene:spawnNPC("noelle_lw", 325, 471)
        cutscene:wait(cutscene:walkTo(noelle, 240, 277, 1.5, "right", false))
        Game:addPartyMember("kris")
        cutscene:text("* Hey, sweetheart.[wait:5] Didn't expect to see you here today!", "happy", "rudy")
        cutscene:text("* It's always a pleasure to see you.", "happier", "rudy")
        cutscene:text("* Where's Krismas?", "wink", "rudy")
        cutscene:text("* O-oh, they're out playing piano in the hall.", "smile_alt", "noelle")
        cutscene:text("* So that's the pleasant,[wait:2] muffled music I hear.", "smile", "rudy")
        cutscene:text("* Faha.", "blush_smile_closed", "noelle")
        local rudy = cutscene:getCharacter("rudy")
        rudy:setAnimation("cough")
        cutscene:wait(cutscene:playSound("rudycough"))
        rudy:resetSprite()
        cutscene:text("* Dad,[wait:2] are you okay?", "dejected", "noelle")
        rudy:setSprite("look_smile")
        cutscene:text("* Oh Noelle,[wait:2] don't worry about me,[wait:2] nothing a Holiday can't handle!", "serious", "rudy")
        rudy:setAnimation("cough")
        cutscene:wait(cutscene:playSound("rudycough"))
        rudy:resetSprite()
        cutscene:wait(0.5)
        cutscene:text("* I'll go get some water.", "surprise_frown", "noelle")
        cutscene:text("* Thanks,[wait:2] sweetie.", "happier", "rudy")
        cutscene:wait(cutscene:walkTo(noelle, 325, 471, 1.5))
        Assets.playSound("dooropen")
        noelle:fadeOutAndRemove(0.2)
        Assets.playSound("doorclose")
        cutscene:wait(0.5)
        local monitor = HeartMonitor(100, 217, 450, 2000, 0, 0, 0, 0, 0, 10)
        monitor.layer = rudy.layer - 0.01
        Assets.playSound("break1")
        Game.world:addChild(monitor)
        cutscene:wait(1)
        Game.fader:fadeOut(nil, {color = COLORS.white, speed = 0.5})
        local rdy = Sprite("world/npcs/rudy/dead", rudy.x, rudy.y)
        rdy:setOrigin(0.5, 1)
        rdy:setScale(2)
        Game.stage:addChild(rdy)
        rdy.layer = 9999
        rdy.alpha = 0 
        local fx = rdy:addFX(ColorMaskFX(COLORS.black))
        Game.stage.timer:tween(0.5, rdy, {alpha = 1})
        cutscene:wait(1.5)
        local monitor = HeartMonitor(100, 217, 420, 600, 100, {-50, -90}, 30, 2, 45, 8)
        monitor.layer = 1000
        Assets.playSound("break1")
        Game.stage:addChild(monitor)
        cutscene:wait(2)
        local monitor = HeartMonitor(100, 217, 420, 600, 270, {-90, -120}, 30, 2, 45, 8)
        monitor.layer = 1000
        Game.stage:addChild(monitor)
        cutscene:wait(0.3)
        Assets.playSound("break1")
        cutscene:wait(1.7)
        local monitor = HeartMonitor(100, 217, 420, 200, 0, 0, 0, 0, 0, 2)
        monitor.layer = 1000
        local snd = Assets.playSound("flatline", 0.4, 0.7)
        Game.stage:addChild(monitor)
        local vol = 0.4
        Game.world.timer:doWhile(function() return vol > 0 end, function()
        vol = vol - (0.1 * DTMULT)
        snd:setVolume(vol)
        end, function() snd:stop() end)
        cutscene:wait(cutscene:playSound("break2"))
        cutscene:wait(0.7)
        Game.fader:fadeIn(nil, {speed = 0.5})
        rdy:removeFX()
        rdy:remove()
        rudy:setSprite("dead")
        cutscene:wait(5.5)
        local noelle = cutscene:spawnNPC("noelle_lw", 326, 481)
        noelle:setFacing("up")
        Assets.playSound("dooropen")
        noelle.alpha = 0 
        noelle:fadeTo(1, 0.1)
        Assets.playSound("doorclose")
        cutscene:wait(0.1)
        cutscene:text("[noskip]* One of the nurses will be he-", "blush_smile", "noelle", {auto = true})
        noelle:setSprite("shocked_behind")
        cutscene:text("* [noskip][sound:ahh]DAD!?", "shock", "noelle")
        local fade_overlay = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        fade_overlay.color = COLORS.black
        fade_overlay.layer = 100 
        fade_overlay.alpha = 0
        Game.world:addChild(fade_overlay)
        local snd = Assets.playSound("wind", 0.5, 1.5)
        Game.world.timer:tween(4.0, fade_overlay, { alpha = 0.7 }, "in-out-quad")
        cutscene:wait(2)
        Game.world.music:play("noelle_fountain", 0)
        Game.world.music:fade(0.5, 2)
        cutscene:wait(2)
        cutscene:wait(2)
        cutscene:text("* Y[wait:2]-you're just resting,[wait:5] right?", "terrified", "noelle")
        cutscene:wait(0.2)
        noelle:resetSprite()
        cutscene:wait(cutscene:walkTo(noelle, 245, 265, 1.2, "right", false))
        noelle:setSprite("walk_sad/right_1")
        cutscene:text("* D-dad![wait:5] P[wait:2]-please, wake up!", "afraid_b", "noelle")
        noelle:setSprite("walk_sad")
        noelle:walkTo(275, 263, 0.2)
        cutscene:wait(0.2)
        noelle.layer = rudy.layer + 1
        noelle:setAnimation("shake")
        for i = 1, 9 do 
            if i == 8 then 
            noelle:resetSprite()
            noelle:setSprite("walk_sad/right_1")
            break 
            end
            rudy:shake(2)
            cutscene:wait(2/6)
        end 
        noelle:walkTo(245, 265, 0.2, "right", true)
        Game.world.music:fade(0.7, 1)
        cutscene:wait(0.2)
        local sx, sy = Game.stage:screenToLocalPos(noelle.x, noelle.y)
        local thing = Game.stage:addChild(Spotlight(sx, sy + 5, {
        width = 60,
        beam_height = 300,
        base_color = {1, 1, 1, 0.7},
        top_color = {1, 1, 1, 0},
        bottom_color = {1, 1, 1, 0.6} 
        }))
        cutscene:wait(cutscene:playSound("locker", 0.7, 1))
        cutscene:wait(0.8)
        cutscene:text("* Please. Y[wait:2]-you can't be gone now...", "terrified_side", "noelle")
        cutscene:wait(1)
        noelle:setFacing("up")
        cutscene:text("* N-no,[wait:5] there has to be some way...[wait:10]I-I can't afford to lose you too.", "surprise_smile", "noelle")
        noelle:setSprite("head_lowered")
        cutscene:wait(0.5)
        cutscene:setSpeaker("noelle")
        cutscene:text("* (That dream...[wait:10] what if it was real?)")
        cutscene:wait(0.5)
        cutscene:text("* (...it can't be,[wait:5]\nBerdly wouldn't be...)")
        noelle:resetSprite()
        noelle:setSprite("walk_sad")
        noelle:setFacing("left")
        cutscene:wait(0.5)
        cutscene:text("* (I..[wait:3] I have to,[wait:5] for dad.)")
        cutscene:text("* (After all,[wait:7] I did have some\nsort of magic.)")
        cutscene:wait(1)
        cutscene:text("* (So,[wait:5] if Queen was really right...)")
        cutscene:wait(1)
        cutscene:text("* (Then if I concentrate my will into a blade...)")
        cutscene:text("* (Blade...[wait:5] blade.\n* Something sharp could do,[wait:5] right?)")
        noelle:setSprite("reach")
        cutscene:wait(0.2)
        noelle:setAnimation("rummage")
        cutscene:wait(0.4)
        noelle:setSprite("pencil")
        cutscene:wait(0.1)
        noelle:setSprite("hold")
        cutscene:text("* (And stab the ground with all your will and determination.)")
        noelle:setSprite("determined_side")
        Game.world.music:fade(0, 1)
        thing:remove()
        cutscene:wait(cutscene:playSound("locker", 0.7, 1))
        cutscene:text("* This is for you,[wait:5] dad.", "upset_down", "noelle")
        Assets.playSound("jump")
    --    noelle:setAnimation("make_fountain/target")
        noelle:setAnimation("ball")
        noelle:slideTo(230, 135, 0.2)
        cutscene:wait(0.2)
        local start_x = noelle.x
        local start_y = noelle.y
        local target_x = 202
        local target_y = 121
        local arc_height = 40 
        local duration = 0.8  -- Total air-time
        local elapsed_time = 0
        
        Game.world.timer:during(duration, function()
            elapsed_time = elapsed_time + DT
            local progress = Utils.ease(0, 1, math.min(1.0, elapsed_time / duration), "out-expo")
            
            noelle.x = Utils.lerp(start_x, target_x, progress)
            local base_y = Utils.lerp(start_y, target_y, progress)
            local height_offset = 4 * arc_height * progress * (1 - progress)
            noelle.y = base_y - height_offset
        end, function()
            noelle:setPosition(target_x, target_y)
        end)
        cutscene:wait(duration)
        noelle:setSprite("make_fountain/target_3")
        noelle:setPosition(202, 169)
        cutscene:wait(0.1)
        local n_x, n_y = noelle:getRelativePos(0, 0, Game.world)
        n_y = n_y + 20
        local total_stars = 14 
        local spacing = 12           
        local wave_height = 6     
        local delay_per_star = 0.05
        local life_time = 0.5        
        local wave_cycles = 2        
        local horizontal_shift = 8
        for i = 1, total_stars do
            local offset_index = i - (total_stars + 1) / 2
            local target_x = n_x + (offset_index * spacing) + horizontal_shift
            local progress = (i - 1) / (total_stars - 1)
            local wave_offset = -math.cos(progress * wave_cycles * 2 * math.pi) * wave_height
            local target_y = n_y + (noelle.height / 2) + wave_offset
            local sprite = Sprite("effects/make_fountain/blaze_shine", target_x, target_y)
            sprite:setOrigin(0.5, 0.5) 
            sprite.layer = noelle.layer - 0.1
            Game.world:addChild(sprite)
            sprite:play(0.5, true) 
            Assets.playSound("fountain_target")
            Game.world.timer:after(life_time, function()
            if sprite.stage then sprite:fadeOutAndRemove(0.15) end 
            end)
            cutscene:wait(delay_per_star)
        end
        cutscene:wait(cutscene:slideTo(noelle, 184, 269, 0.5, "in-expo"))
        noelle:setSprite("make_fountain/make_1")
        Game.world:shake(10, 10)
        noelle:setAnimation("make_fountain/make_loop")
        Assets.playSound("fountain_make")
        local pillar = FMPillar(183, 269, noelle)
        pillar.layer = noelle.layer - 0.01
        Game.world:addChild(pillar)
        cutscene:wait(7)
        noelle:resetSprite() 
        Assets.playSound("bump", 0.6)
        noelle:shake(2)
        noelle:setPosition(170, 264)
        noelle:setSprite("make_fountain/jump_off_landed")  
        local ball_instances = {}
        local particle_timer = Game.world.timer:every(0.04, function()
            local p = FMBall(183 + love.math.random(-10, 10), 270)
            p.layer = noelle.layer + 5 
            table.insert(ball_instances, p)
            Game.world:addChild(p)
        end)
        cutscene:wait(1)
        local fog = FMCeilingFog()
        fog.layer = 9500
        Game.world:addChild(fog)
        cutscene:wait(12)
        Game.world.timer:cancel(particle_timer)
        TableUtils.filterInPlace(ball_instances, function(ball)
        if ball.stage then 
        ball:remove() 
        return false 
        end
        return true
        end)
        cutscene:wait(6)
        cutscene:after(function()
            Game.world:removeFX("desat")
            Game.world:startCutscene("noelle.fall")
        end)
    end
}
