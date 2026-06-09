return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    kris = function(cutscene)
        local function pierce(x, y, ice)
            Game.world:addChild(ice)
            ice.x = x 
            ice.y = y
            ice:setScale(2)
            ice.scale_y = 0
            ice.layer = 9999
            Game.world.timer:tween(0.2, ice, {scale_y = -2}, "in-expo")
        end 
        local kx, ky = cutscene:getMarker("kris")
        local kris = cutscene:getCharacter("kris")
        cutscene:wait(cutscene:walkTo(kris, kx, ky, 2))
        cutscene:wait(cutscene:playSound("short_alert"))
        local spx, spy = kris:getRelativePos(kris.width/2, kris.height/2, Game.world)
        local sprite = Sprite("effects/icicle", spx, spy + 40)
        local dummy = Sprite("effects/icicle")
        local snd = Assets.playSound("rise")
        Game.world:addChild(sprite)
        sprite:setScale(2)
        sprite.scale_y = 0
        sprite.layer = 999
        Game.world.timer:tween(0.2, sprite, {scale_y = -2}, "in-expo")
        cutscene:wait(0.2)
        kris:shake()
        Assets.playSound("damage")
        kris:setSprite("fell")
        Game.world.timer:tween(0.2, sprite, {scale_y = 0}, "out-expo")
        cutscene:wait(0.2)
        cutscene:wait(cutscene:playSound("short_alert"))
        Assets.playSound("rise")
        pierce(kris.x - 70, spy + 38, Sprite("effects/icicle"))
        pierce(kris.x + 70, spy + 38, Sprite("effects/icicle"))
        local middle, _ = kris:getRelativePos(kris.width/2, kris.height, Game.world)
        pierce(middle, spy - 2, Sprite("effects/icicle"))
        pierce(middle, spy + 70, Sprite("effects/icicle"))
        Game.world.music:play("gallery")
        Game.world.music:setVolume(0)
        Game.world.music:fade(0.5, 0.2)
        local noelle = Game.world:spawnNPC("noelle", 2277, 273)
        noelle:setSprite("end")
        cutscene:wait(0.2)
        cutscene:panTo(kris.x + 200, Game.world.camera.y, 1.4, "out-cubic")
        cutscene:wait(1)
        Assets.playSound("wing")
        noelle:shake(2)
        noelle:resetSprite()
        noelle:setSprite("walk_happy")
        noelle:setFacing("left")
        cutscene:wait(0.4)
        cutscene:text("* There you are,[wait:5] Kris.", "down_smile", "noelle")
    end 
}
