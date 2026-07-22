local all_leaves = {}
local pit_void = nil
local function flash(per, color)
    local fx = ColorMaskFX(color or COLORS.white)
    fx.amount = 0 
    per:addFX(fx, "fx")
    Game.world.timer:tween(0.5, fx, {amount = 1}, "linear", function()
    Game.world.timer:tween(0.5, fx, {amount = 0}, "linear", function() per:removeFX("fx") end)
    end)
end 

return {
    ---@param cutscene WorldCutscene
    leaf_spawn = function(cutscene)
        all_leaves = {}

        local cx, cy = SCREEN_WIDTH/2, SCREEN_HEIGHT/2
        local ring_spacing = 12
        local max_rings = 10
        local leaf_size = 18    
        pit_void = Object()
        pit_void:setPosition(cx, cy)
        pit_void.layer = Game.world.player.layer - 0.01
        
        pit_void.draw = function(self)
            Object.draw(self) 
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.circle("fill", 0, 0, max_rings * ring_spacing)
        end
        Game.world:addChild(pit_void)

        for ring = 1, max_rings do
            local radius = ring * ring_spacing
            local circumference = 2 * math.pi * radius
            local count = math.max(8, math.floor(circumference / leaf_size))

            for i = 1, count do
                local angle_offset = (love.math.random() * 2 - 1) * (0.8 * (2 * math.pi / count))
                local angle = ((i - 1) * (2 * math.pi / count)) + angle_offset
                
                local radius_offset = (love.math.random() * 2 - 1) * (ring_spacing * 0.95)
                local final_radius = radius + radius_offset

                local spawn_x = cx + math.cos(angle) * final_radius
                local spawn_y = cy + math.sin(angle) * final_radius

                local sprite = Sprite("effects/leaf")
                sprite:setOrigin(0.5, 0.5)
                sprite:setPosition(spawn_x, spawn_y)
                sprite.rotation = love.math.random() * math.pi * 2       
                Game.world:addChild(sprite)
                sprite:setScale(2)
                local base_layer  = 9999 + spawn_y + (love.math.random() * 10 - 5)
                local layer_floor = WORLD_LAYERS["bottom"]
                local layer_roof  = Game.world.player.layer
                sprite.layer = MathUtils.clamp(base_layer, layer_floor, layer_roof)
                table.insert(all_leaves, {
                    sprite = sprite,
                    x = spawn_x,
                    y = spawn_y,
                    break_delay = (ring * 0.08) + (love.math.random() * 0.4)
                })
            end
        end
    end, 

    ---@param cutscene WorldCutscene
    fall = function(cutscene)
        cutscene:text("* Kris,[wait:2] I think we should walk around these leaves...", "surprise_smile", "ralsei")
        cutscene:wait(cutscene:walkTo("kris", 314, 237, 1))
        cutscene:text("* Okay.", "dismissive", "ralsei")
        cutscene:wait(0.5)
        for _, leaf in ipairs(all_leaves) do
            cutscene.world.timer:after(leaf.break_delay, function()
                local launch_angle = love.math.random() * math.pi * 2
                local launch_force = love.math.random(20, 50)
                
                local peak_x = leaf.x + math.cos(launch_angle) * launch_force
                local peak_y = leaf.y - love.math.random(15, 35)

                cutscene.world.timer:tween(0.2, leaf.sprite, {
                    x = peak_x,
                    y = peak_y,
                    rotation = leaf.sprite.rotation + (love.math.random() * 2 - 1)
                }, "out-cubic", function()
                    cutscene.world.timer:tween(0.5, leaf.sprite, {
                        y = peak_y + 400,
                        alpha = 0
                    }, "in-cubic", function()
                        leaf.sprite:remove()
                    end)
                end)
            end)
        end
        local kris = cutscene:getCharacter("kris")
        local ralsei = cutscene:getCharacter("ralsei")
        cutscene:detachCamera()
        cutscene:wait(0.8)
        ralsei:setSprite("fall")
        kris:setFacing("down")
        Assets.playSound("paper_fall")
        cutscene:detachFollowers()
        ralsei.physics.speed_y = -26
        ralsei.physics.gravity = 3.4 
        kris.physics.speed_y = -26
        kris.physics.gravity = 3.4 
        Game.fader:fadeOut(nil, {speed = 1})
        cutscene:wait(0.5)
        kris.visible = false 
        ralsei.visible = false
        cutscene:wait(1) 
        Assets.playSound("fall")
        Game.fader.alpha = 0
        local rect = Rectangle(0, 0, 9999, 9999)
        rect:setColor(COLORS.black)
        Game.world:addChild(rect)
        rect.layer = ralsei.layer - 0.00001
        kris:setAnimation({"fall", 1/8, true})
        local mask_fx = ColorMaskFX(COLORS.black, 1)
        kris:resetPhysics()
        ralsei:resetPhysics()
        ralsei:setPosition(264, 180)
        kris:setPosition(365, 258)
        ralsei.visible = true 
        kris.visible = true 
        ralsei:addFX(mask_fx, "r_mask")
        kris:addFX(mask_fx, "k_mask")
        ralsei:addFX(OutlineFX(Game:getPartyMember("ralsei").color))
        kris:addFX(OutlineFX(Game:getPartyMember("kris").color))
        kris:setPosition(kris.x, -50)
        ralsei:setPosition(ralsei.x, -50)
        ralsei.physics.speed_y = 6
        ralsei.physics.gravity = 0.2
        kris.physics.speed_y = 6 
        kris.physics.gravity = 0.12
        cutscene:wait(4.5)
        cutscene:loadMap("forest_debug", "shouldbe")
        kris = cutscene:getCharacter("kris")
        ralsei = cutscene:getCharacter("ralsei")
        ralsei:addFX(mask_fx, "r_mask")
        kris:addFX(mask_fx, "k_mask")
        ralsei:addFX(OutlineFX(Game:getPartyMember("ralsei").color))
        kris:addFX(OutlineFX(Game:getPartyMember("kris").color))
        cutscene:detachFollowers()
        Game.world:addChild(rect)
        ralsei:setSprite("splat")
        ralsei:setPosition(228, 206)
        kris:setPosition(kris.x, -50)
        Game.world.music:play("deltarune/church_lw_night")
        kris:setAnimation({"fall", 1/8, true})
        kris:slideTo(kris.x, 272, 1)
        cutscene:wait(1)
        Assets.playSound("dtrans_flip")
        kris:setSprite("landed_1")
        cutscene:wait(1.5)
        for i = 1, 3 do 
            Assets.playSound("wing")
            ralsei:shake(2)
            cutscene:wait(0.4)
        end 
        ralsei:setSprite("landed_1")
        cutscene:wait(0.2)
        ralsei:setAnimation({"landed", 1/4, false})
        cutscene:wait(0.5)
        cutscene:setSpeaker("ralsei")
        cutscene:wait(0.2)
        cutscene:text("* Kris!!")
        cutscene:wait(0.2)
        ralsei:walkTo(282, 272, 0.4, "right")
        cutscene:wait(0.4)
        cutscene:wait(cutscene:setAnimation(ralsei, "hug"))
        Assets.playSound("spell_cure_slight_smaller")
        local self = kris 
        Game.world.timer:every(1 / 30, function()
            for i = 1, 2 do
                local x = self.x + ((love.math.random() * self.width) - (self.width / 2)) * 2
                local y = self.y - (love.math.random() * self.height) * 2
                local sparkle = HealSparkle(x, y)
                if r and g and b then
                    sparkle:setColor(r, g, b)
                end
                Game.stage:addChild(sparkle)
            end
        end, 4)
        kris:setAnimation({"landed", 1/4, false})
        ralsei:resetSprite()
        ralsei:walkTo(ralsei.x - 30, ralsei.y, 0.2, "right", true)
        cutscene:wait(0.8)
        kris:resetSprite()
        kris:setFacing("left")
        cutscene:text("* Oh,[wait:2] Kris,[wait:2] thank god you're okay!", "blush")
        ralsei:setFacing("left")
        ralsei:walkTo(ralsei.x - 30, ralsei.y, 0.4)
        cutscene:wait(0.5)
        cutscene:text("* Where are we...?", "frown")
        ralsei:setFacing("right")
        cutscene:wait(0.5)
        cutscene:text("* ...[wait:5]let's try to find a way out.", "disappointed_side")
        cutscene:text("* Kris,[wait:5] let's go...", "unsure")
        cutscene:interpolateFollowers()
        cutscene:attachFollowers()
    end, 

    kris1 = function(cutscene)
        local kris = cutscene:getCharacter("kris")
        kris:shake()
        flash(kris, COLORS.red)
        Assets.playSound("bump")
        Assets.playSound("impact")
        kris:setSprite("landed_1")
        cutscene:wait(1)
        cutscene:text("* Kris!", "shock", "ralsei")
        local ralsei = cutscene:getCharacter("ralsei")
        cutscene:wait(cutscene:walkTo(ralsei, kris.x - 30, ralsei.y)) 
        cutscene:wait(cutscene:setAnimation(ralsei, "hug"))
        Assets.playSound("spell_cure_slight_smaller")
        Game.world.timer:every(1 / 30, function()
            for i = 1, 2 do
                local x = kris.x + ((love.math.random() * kris.width) - (kris.width / 2)) * 2
                local y = kris.y - (love.math.random() * kris.height) * 2
                local sparkle = HealSparkle(x, y)
                if r and g and b then
                    sparkle:setColor(r, g, b)
                end
                kris.parent:addChild(sparkle)
                sparkle.layer = 9999 
            end
        end, 4)
        ralsei:resetSprite()
        ralsei:walkTo(ralsei.x - 30, kris.y - 6, 0.2, "right", true)
        cutscene:wait(0.2)
        kris:setAnimation({"landed", 1/4, false})
        kris:resetSprite()
        cutscene:interpolateFollowers()
        cutscene:attachFollowers()
        kris:setFacing("right")
    end, 

    kris2 = function(cutscene)
        local kris = cutscene:getCharacter("kris")
        kris:shake()
        flash(kris, COLORS.red)
        Assets.playSound("break1")
        kris:setSprite("ouch")
        cutscene:wait(1)
        local ralsei = cutscene:getCharacter("ralsei")
        cutscene:wait(cutscene:walkTo(ralsei, kris.x - 30, ralsei.y)) 
        cutscene:wait(cutscene:setAnimation(ralsei, "hug"))
        Assets.playSound("spell_cure_slight_smaller")
        Game.world.timer:every(1 / 30, function()
            for i = 1, 2 do
                local x = kris.x + ((love.math.random() * kris.width) - (kris.width / 2)) * 2
                local y = kris.y - (love.math.random() * kris.height) * 2
                local sparkle = HealSparkle(x, y)
                if r and g and b then
                    sparkle:setColor(r, g, b)
                end
                kris.parent:addChild(sparkle)
                sparkle.layer = 9999
            end
        end, 4)
        ralsei:resetSprite()
        ralsei:walkTo(ralsei.x - 30, kris.y - 6, 0.2, "right", true)
        cutscene:wait(0.2)
        cutscene:wait(cutscene:setAnimation(kris, {"landed", 1/4, false}))
        kris:resetSprite()
        cutscene:interpolateFollowers()
        cutscene:attachFollowers()
        cutscene:text("* Please,[wait:5] be careful,[wait:2] Kris.", "pleased", "ralsei")
    end, 

    kris3 = function(cutscene)
        local kris = cutscene:getCharacter("kris")
        local ralsei = cutscene:getCharacter("ralsei")
        kris:shake(6)
        flash(kris, COLORS.red)
        Assets.playSound("break2")
        Assets.playSound("impact")
        kris:setSprite("fell")
        ralsei:setSprite("what_right")
        cutscene:wait(cutscene:walkTo(ralsei, ralsei.x - 70, ralsei.y, 0.2)) 
        cutscene:wait(0.5)
        cutscene:text("* KRIS!?", "terrified_up", "ralsei")
        ralsei:resetSprite()
        ralsei:walkTo(kris.x - 90, ralsei.y, 0.7)
        cutscene:wait(0.7)
        cutscene:wait(cutscene:setAnimation(ralsei, "battle/spell"))
        Assets.playSound("spell_cure_slight_smaller")
        Game.world.timer:every(1 / 30, function()
            for i = 1, 2 do
                local x = kris.x + ((love.math.random() * kris.width) - (kris.width / 2)) * 2
                local y = kris.y - (love.math.random() * kris.height) * 2
                local sparkle = HealSparkle(x, y)
                if r and g and b then
                    sparkle:setColor(r, g, b)
                end
                kris.parent:addChild(sparkle)
                sparkle.layer = 9999
            end
        end, 4)
        ralsei:resetSprite()
        cutscene:wait(0.5)
        cutscene:text("* Kris![wait:5] Kris,[wait:5] please!", "terrified_up", "ralsei")
        cutscene:wait(cutscene:setAnimation(ralsei, "battle/spell"))
        Assets.playSound("spell_cure_slight_smaller")
        Game.world.timer:every(1 / 30, function()
            for i = 1, 2 do
                local x = kris.x + ((love.math.random() * kris.width) - (kris.width / 2)) * 2
                local y = kris.y - (love.math.random() * kris.height) * 2
                local sparkle = HealSparkle(x, y)
                if r and g and b then
                    sparkle:setColor(r, g, b)
                end
                kris.parent:addChild(sparkle)
                sparkle.layer = 9999
            end
        end, 4)
        ralsei:resetSprite()
        cutscene:wait(0.3)
        cutscene:text("* Please,[wait:5] wake up!", "down", "ralsei")
        cutscene:wait(0.5)
        cutscene:panTo(Game.world.camera.x + 150, Game.world.camera.y, 2, "out-sine")
        cutscene:wait(2)
        local text = DialogueText("[speed:0.7][noskip][voice:none]It's just you.[wait:10]", 208, 36)
        Game.stage:addChild(text)
        cutscene:wait(function() return not text:isTyping() end)
        text:fadeOutAndRemove(1)
        cutscene:wait(1)
        local text = DialogueText("[speed:0.7][noskip][voice:none]It'll always just be you.[wait:10]", 151, 36)
        Game.stage:addChild(text)
        cutscene:wait(function() return not text:isTyping() end)
        text:fadeOutAndRemove(1)
        cutscene:wait(1)
        cutscene:setSpeaker("shadow")
        cutscene:setTextboxTop(true)
        cutscene:text("* Blindly comforting them as always,[wait:5] Ralsei...")
        cutscene:setTextboxTop(false)
        cutscene:text("* Who said that?", "disappointed_side", "ralsei")
        Game.world.music:fade(0, 2)
        cutscene:wait(2)
        cutscene:setTextboxTop(true)
        cutscene:text("[shake:1]* The part of Kris you pretend doesn't exist.")
        cutscene:detachCamera()
        cutscene:detachFollowers()
        cutscene:panTo(Game.world.camera.x + 250, Game.world.camera.y, 2.5)
        ralsei:walkTo(ralsei.x + 250, ralsei.y, 2.5)
        cutscene:wait(2.5)
        cutscene:setTextboxTop(false)
        cutscene:text("* ...", "determined_up", "ralsei")
        cutscene:text("* I don't care what you think...[wait:5]", "angry", "ralsei")
        cutscene:text("* And I won't let you hurt my friend!", "no_glasses_closed", "ralsei")
        Assets.playSound("weaponpull_fast")
        ralsei:setAnimation("battle/attack_ready")
        cutscene:wait(0.5)
        cutscene:text("* So bring it on.", "determined", "ralsei")
        cutscene:setTextboxTop(true)
        cutscene:text("* Always so desperately naive,[wait:5] aren't you?")
        local shadow = Game.world:spawnNPC("shadow", kris.x + 150, kris.y - 15)  
        shadow:setAnimation("ball")
        shadow:setScale(1)
        kris:shake()
        Assets.playSound("grab")
        Assets.playSound("jump")
        local start_x = shadow.x
        local start_y = shadow.y
        local target_x = ralsei.x + 400 
        local target_y = 314
        local arc_height = 80  
        local duration = 0.8 
        local elapsed_time = 0
Game.world.timer:during(duration, function()
    elapsed_time = elapsed_time + DT
    local progress = math.min(1.0, elapsed_time / duration)
    shadow.x = Utils.lerp(start_x, target_x, progress)
    local base_y = Utils.lerp(start_y, target_y, progress)
    local height_offset = 4 * arc_height * progress * (1 - progress)
    
    shadow.y = base_y - height_offset
end, function()
    shadow:setSprite("landed")
    shadow:addFX(ColorMaskFX(COLORS.black))
    local hehe = shadow:addFX(OutlineFX(), "outline")
    hehe.thickness = 2 
    shadow.sprite.scale_y = 0
    shadow.sprite.scale_x = 2
end)
cutscene:wait(duration)
local snd = Assets.playSound("appear")
Game.world.timer:tween(snd:getDuration(), shadow.sprite, {scale_y = -1}) 
Game.world.timer:during(snd:getDuration(), function()
shadow:setPosition(target_x, target_y)
end)
        cutscene:wait(1)
        shadow.y = 314
        Assets.playSound("wing")
        shadow:shake(2)
        shadow:setSprite("left")
        shadow.sprite.scale_y = 2
        shadow.sprite:setOrigin(0, 1)
        cutscene:wait(0.5)
        ralsei:resetSprite()
        ralsei:setFacing("left")
        cutscene:text("*[speed:1.2] What,[wait:2] where did you\ncome from-[wait:3][next]", "surprise_confused", "ralsei")
        cutscene:text("* You're always hanging onto the scrapings on the surface.")
        ralsei:setFacing("right")
        cutscene:wait(0.5)
        cutscene:text("* I'll leave Kris alone...[wait:5]")
        cutscene:wait(0.5)
        cutscene:text("[speed:0.7][noskip][shake:1]* But you can't cure a soul that wants to fade.")
        cutscene:setTextboxTop(false)
        cutscene:text("* Fade..?", "surprise_confused", "ralsei")
        cutscene:text("* N-[wait:2]no,[wait:3] that...[wait:5] that's not how it works...", "concern_smile", "ralsei")
        cutscene:wait(0.5)
        cutscene:text("* The prophecy says...[wait:5] we're supposed to save the world.","disappointed_side", "ralsei")
        cutscene:text("* It says we're supposed to be heroes...[wait:5]\n* Together...", "disappointed", "ralsei")
        cutscene:setTextboxTop(true)
        cutscene:wait(0.5)
        cutscene:text("* Your silly books don't dictate what breaks inside their head, little prince.")
        cutscene:text("* Now...[wait:3] show me what a hero does in the face of danger.")
        Game:removePartyMember("kris")
        cutscene:startEncounter("shadow", nil, {{"shadow", shadow}}, {
        on_start = function()
        Game.stage:setWeather("thunder")
        shadow:remove()
        end
        })    
    end,

}
