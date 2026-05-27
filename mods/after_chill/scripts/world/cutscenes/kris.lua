return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    shadow = function(cutscene)
        cutscene:loadMap("room4") -- placeholder code 
        local kris = cutscene:getCharacter("kris")
        kris:setPosition(536, 280) 
        cutscene:wait(0.3)-- also change code 
        Assets.playSound("damage")
        kris:shake()
        local fx = kris:addFX(ColorMaskFX(COLORS.red, 1))
        kris:setSprite("sit")
        kris.layer = 0.459
        Game.world.timer:tween(0.3, fx, {amount = 0})
        cutscene:wait(0.7)
        cutscene:panTo(Game.world.camera.x + 200, Game.world.camera.y, 2, "out-sine")
        cutscene:wait(1)
        local noelle = cutscene:spawnNPC("noelle", 926, 286)
        local k = cutscene:spawnNPC("kris", 859, 286)
        k:setFacing("left")
        noelle.alpha = 0 
        local kfx = k:addFX(ColorMaskFX(COLORS.black, 1))
        local nfx = noelle:addFX(ColorMaskFX(COLORS.black, 1))
        k.alpha = 0
        noelle:setSprite("walk_sad")
        noelle:setFacing("left")
        Game.world.music:play("wind")
        Game.world.timer:tween(1, noelle, {alpha = 1})
        Game.world.timer:tween(1, k, {alpha = 1})
        Game.world.timer:tween(1, kris, {alpha = 0})
        local effect = OverworldSnowEffect()
        Game.world:addChild(effect)
        effect.layer = noelle.layer - 0.01 
        cutscene:wait(1)
        k:walkTo(559, k.y, 6)
        noelle:walkTo(623, noelle.y, 6)
        cutscene:wait(0.5)
        cutscene:text("*[noskip] Kris..[wait:2] where are we going...?[wait:5]", "afraid", "noelle", {auto = true}) 
        cutscene:wait(1)
        kris.alpha = 1
        kris.layer = effect.layer - 0.001
        cutscene:text("*[noskip] To...[wait:2] get stronger?[wait:5]", "sad_side", "noelle", {auto = true})
        cutscene:wait(0.5)
        effect:remove()
        Game.world.music:pause()
        noelle:fadeOutAndRemove(1)
        k:fadeOutAndRemove(1)
        cutscene:wait(0.3)
        cutscene:wait(1)
        cutscene:setSpeaker("shadow")
        cutscene:text("* Don't you remember all this?")
        Assets.playSound("bump")
        kris:shake()
        cutscene:wait(0.5)
        cutscene:text("* Over here,[wait:5] Kris.")
        local shadow = Game.world:spawnNPC("shadow", 546, 262)  
        shadow:setAnimation("ball")
        shadow:setScale(1)
        kris:shake()
        Assets.playSound("grab")
        Assets.playSound("jump")
        local start_x = shadow.x
        local start_y = shadow.y
        local target_x = 863
        local target_y = 300
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
    shadow:addFX(OutlineFX())
    shadow.sprite.scale_y = 0
    shadow.sprite.scale_x = 2
end)
cutscene:wait(duration)
local snd = Assets.playSound("appear")
Game.world.timer:tween(snd:getDuration(), shadow.sprite, {scale_y = -1}) 
Game.world.timer:during(snd:getDuration(), function()
shadow:setPosition(893, 323)
end)
Game.world.music:play("gallery")
Game.world.music:setVolume(0)
Game.world.music:fade(0.7, 1)
cutscene:wait(1.3)
Assets.playSound("wing")
shadow:shake()
shadow.sprite.scale_y = 2
shadow.y = 248
shadow:setSprite("left")
local function bumpshake()
kris:shake()
Assets.playSound("bump")
Game.stage:shake()
end 
cutscene:wait(0.5)
cutscene:text("* Heh.[wait:5] Look at you.[wait:5] So helpless.")
bumpshake()
cutscene:wait(0.5)
cutscene:text("* That [color:red][shake:1]SOUL[color:reset][shake:0] of yours...")
bumpshake()
cutscene:wait(0.5)
cutscene:text("* Controlling you like a puppet...")
bumpshake()
cutscene:wait(0.5)
cutscene:text("*[noskip] Your actions don't matter,[wait:5] do they?[next]")
bumpshake()
cutscene:wait(0.5)
cutscene:text("* Berdly, Spamton, [shake:1]Noel[shake:0]-[next]")
local fx = kris:addFX(ColorMaskFX(COLORS.red, 1))
Assets.playSound("weaponpull_fast")
kris:setAnimation("battle/attack_ready")
Game.world.timer:tween(0.5, fx, {amount = 0})
cutscene:wait(1.8)
cutscene:text("* You're so desperate to break free,[wait:5] huh?")
cutscene:text("* Kris...[wait:5]")
Game.world.music:fade(0, 1)
cutscene:text("*[noskip][speed:0.5] You can't get rid of them.")
Game.world.music:play("shadow", 0) 
Game.world.music:fade(0.5, 1)
local storm_overlay = ThunderTint()
Game.stage:addChild(storm_overlay)
storm_overlay.alpha = 0 
Game.world.timer:tween(0.5, storm_overlay, {alpha = 1})
cutscene:wait(0.5)
cutscene:text("* Heh.[wait:5]\n* But you can try getting rid\nof me.")
Game:setFlag("music", Game.world.music:tell())
cutscene:startEncounter("shadow", nil, {{"shadow", shadow}}, {
    on_start = function()
        Game.stage:setWeather("thunder")
        storm_overlay:remove()
        shadow:remove()
    end
})
cutscene:attachCamera()
Game.stage:resetWeather()
Game.world.music:pause()
kris:resetSprite()
kris:setFacing("right")
    end 
}
