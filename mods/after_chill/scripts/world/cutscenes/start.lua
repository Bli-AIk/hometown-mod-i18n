return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    piano = function(cutscene)
        -- text
        cutscene:detachFollowers()
        local kris = cutscene:getCharacter("kris")
        local noelle = cutscene:getCharacter("noelle") 
        kris:setFacing("up")
        noelle:setFacing("up")
        noelle:setPosition(480, 253)
        cutscene:wait(0.3)
        -- local sfx = Assets.playSound("kris_legend")
        -- cutscene:wait(16.3s)
        cutscene:wait(cutscene:playSound("pianonoise"))
        cutscene:wait(0.2)
        cutscene:text("* W[wait:2]-wow,[wait:2] Kris, you've always been good at playing the piano.", "blush_surprise_smile", "noelle")
        cutscene:text("* Ever since we were kids.", "blush_smile_closed", "noelle")
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
        cutscene:wait(0.2)
        local monitor = HeartMonitor(100, 217, 450, 2000, 0, 0, 0, 0, 0, 10)
        monitor.layer = rudy.layer - 0.01
        Assets.playSound("break1")
        Game.world:addChild(monitor)
        cutscene:wait(1)
        Game.fader:fadeOut(nil, {color = COLORS.white, speed = 0.5})
        cutscene:wait(0.5)
        rudy:setPosition(322, 288)
        local rdy = Sprite("world/npcs/rudy/dead", 300, 168)
        rdy:setScale(2)
        Game.stage:addChild(rdy)
        rdy.layer = 9999
        rdy.alpha = 0 
        local fx = rdy:addFX(ColorMaskFX(COLORS.black, 1))
        fx.amount = 0 
        Game.stage.timer:tween(0.5, rdy, {alpha = 1})
        Game.stage.timer:tween(0.5, fx, {amount = 1})
        cutscene:wait(1)
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
        cutscene:wait(0.3)
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
        local desat_shader = love.graphics.newShader[[
    extern float amount;
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        vec4 pixel = Texel(texture, texture_coords) * color;
        float luma = dot(pixel.rgb, vec3(0.299, 0.587, 0.114));
        vec3 gray = vec3(luma);
        vec3 slate_blue = vec3(luma * 0.4, luma * 0.45, luma * 0.6);
        vec3 target_color = mix(slate_blue, gray, luma);
        pixel.rgb = mix(pixel.rgb, target_color, amount);
        return pixel;
    }
]]

Game.world.desat_amount = 0
local old_world_draw = Game.world.draw
Game.world.draw = function(self)
    love.graphics.setShader(desat_shader)
    desat_shader:send("amount", self.desat_amount)
    old_world_draw(self) 
    love.graphics.setShader() 
end
        local snd = Assets.playSound("wind", 0.5, 1.5)
        Game.world.timer:tween(4, Game.world, {desat_amount = 1}, "in-out-quad")
        cutscene:wait(2)
        Game.world.music:play("noelle_fountain")
        Game.world.music:setVolume(0)
        Game.world.music:fade(0.5, 2)
        cutscene:wait(2)
        cutscene:text("* Y-you're just resting,[wait:5] right?", "terrified", "noelle")
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
            rudy:shake(love.math.random(-2, 2))
            cutscene:wait(2/6)
        end 
        noelle:walkTo(245, 265, 0.2, "right", true)
        cutscene:wait(0.8)
        cutscene:text("* Please. Y[wait:2]-you can't be gone now...", "terrified_side", "noelle")
        Game.world.music:fade(0.7, 1)
        cutscene:wait(1)
        noelle:setFacing("up")
        cutscene:text("* N-no, there has to be some way...[wait:10]I-I can't afford to lose you too.", "surprise_smile", "noelle")
        noelle:setSprite("head_lowered")
        cutscene:wait(0.5)
        cutscene:setSpeaker("noelle")
        cutscene:text("* (In that dream...[wait:10] \n* I had healing magic.)")
        cutscene:wait(1)
        cutscene:text("* (What if,[wait:5] Queen was right?)")
        cutscene:wait(1)
        cutscene:text("* (Concentrate my will into a blade...)")
        cutscene:text("* (Blade... blade.\n* Something sharp could do,[wait:5] right?)")
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
        cutscene:wait(0.1)
        noelle:setSprite("determined")
        cutscene:text("* This is for you,[wait:5] dad.", "upset_down", "noelle")
        noelle:setAnimation("ball")
        Assets.playSound("jump")
        cutscene:wait(cutscene:slideTo(noelle, 230, 135, 0.2))
        noelle:setSprite("make_fountain/target_1")
        noelle:slideTo(171, 180, 0.2, "out-sine") -- might try out-expo?
        cutscene:wait(0.3)
        local n_x, n_y = noelle:getRelativePos(0, 0, Game.world)
        n_y = n_y - 7
        local total_stars = 19    
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
                if sprite and sprite.stage then
                    sprite:fadeOutAndRemove(0.15)
                end
            end)
            cutscene:wait(delay_per_star)
        end
        cutscene:wait(cutscene:slideTo(noelle, 159, 269, 0.5, "in-expo"))
        noelle:setSprite("make_fountain/make_1")
        Game.world:shake(10, 10)
        noelle:setAnimation("make_fountain/make_loop")
        Assets.playSound("fountain_make")
        local pillar = FMPillar(161, 269, noelle)
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
            local p = FMBall(159 + love.math.random(-10, 10), 264)
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
        for _, b in ipairs(ball_instances) do
            if b.stage then 
                b:remove() 
            end
        end
        cutscene:wait(1)
    end
}
