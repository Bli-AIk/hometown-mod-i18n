return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    appear = function(cutscene)        
    local peonies = {}
    for _, peonie in ipairs(Game.stage:getObjects(ChaserEnemy)) do 
        if peonie.actor and peonie.actor.id == "peonie" then 
           table.insert(peonies, peonie)
        end
    end 
    local sfx 
    local enemy = peonies[1]
    if enemy then 
    enemy.actor.visible = true 
    enemy.visible = true
    enemy.alpha = 0
    sfx = Assets.playSound("grab")
    enemy:fadeTo(1, sfx:getDuration())
    cutscene:wait(sfx:getDuration())
    Assets.playSound("wing")
    enemy:shake(2)
    cutscene:wait(0.3)
    cutscene:startEncounter("peonie", nil, {{"peonie", enemy}})
    enemy:remove()
    end 
    end, 

    puzzle = function(cutscene)
    cutscene:wait(cutscene:playSound("won"))
    local ralsei = cutscene:getCharacter("ralsei")
    local kris = cutscene:getCharacter("kris")
    cutscene:wait(cutscene:walkTo(ralsei, ralsei.x, kris.y, 0.4, "left"))
    cutscene:text("* H-[wait:2]huh??[wait:8][face:pleased]\n* It isn't solved yet,[wait:2] Kris.", "surprise_confused", "ralsei")
    cutscene:wait(1)
    cutscene:text("* Umm...[wait:5] Kris,[wait:2] do you\nneed my help?", "stressed", "ralsei")
    local choice = cutscene:choicer({"Yes", "Go away\nI can do\nit myself"})
    if choice == 1 then 
        cutscene:text("* Alright, well...", "blush_surprise", "ralsei")
        cutscene:text("* I think I need to press this button!", "small_smile_side", "ralsei")
    else 
        cutscene:text("* I'll just go over here then...", "pensive", "ralsei") 
    end 
    cutscene:detachFollowers()
    local facing = "right"
    if choice == 1 then facing = "left" end 
    cutscene:wait(cutscene:walkTo(ralsei, 782, 545, 0.8, facing))
    for _, box in ipairs(Game.stage:getObjects(TileButton)) do 
        box:setPressed(true)
    end 
        cutscene:wait(cutscene:playSound("won"))
        if choice == 1 then 
        cutscene:text("* There we go!", "blush_pleased_open", "ralsei")
        else 
        ralsei:alert()
        ralsei:setFacing("left")
        cutscene:wait(0.5)
        cutscene:text("* Seems I did it for you,[wait:2] Kris.", "stressed", "ralsei")
        cutscene:wait(0.5)
        end 
        cutscene:text("* Can i help?[wait:8][next]")
        ralsei:alert()
        ralsei:setFacing("up")
        cutscene:wait(0.5)
        cutscene:text("* Who said that?[wait:5]\n* Is anyone there?", "shock_smile", "ralsei")
        cutscene:text("* I did!")
        local ghost = cutscene:spawnNPC("sirengeist", 573, 271)
        cutscene:panTo(ghost.x, ghost.y, 0.4, "in-circ")
        cutscene:wait(0.1)
        Assets.playSound("whip_crack_only")
        kris:setFacing("up")
        cutscene:wait(0.5)
        cutscene:setTextboxTop(false)
        cutscene:text("* Sorry little ghost,[wait:5] but we already solved it!", "pensive", "ralsei")
        cutscene:setTextboxTop(true)
        cutscene:text("* Hey!! I no little!")
        cutscene:text("* You'll pay for that!")
        cutscene:startEncounter("sirengeist2", nil, {{"sirengeist", ghost}})
        cutscene:wait(0.5)
        cutscene:text("* Auhhh...[wait:5] that was fun!")
        cutscene:text("* Take this,[wait:5] take this!")
        ghost:setSprite("throw")
        local sfx = Assets.playSound("grab")
        local gx, gy = ghost:getRelativePos(ghost.width/2, ghost.height, Game.world)
        local sprite = Sprite("bullets/cross", gx, gy - 80)
        sprite:setScale(3)
        sprite.alpha = 0
        Game.world:addChild(sprite)
        sprite.layer = 9999
        sprite:fadeTo(1, sfx:getDuration())
        cutscene:wait(1)
        sprite.graphics.spin = 0.2 
        sfx = Assets.playSound("sparkle_gem")
        local kx, ky = kris:getRelativePos(kris.width/2, kris.height/2, Game.world)
        cutscene:wait(cutscene:slideTo(sprite, kx + 20, ky, sfx:getDuration()))
        sprite:remove()
        ghost:resetSprite()
        local success, text = Game.inventory:tryGiveItem("cross_bow")
        Assets.playSound("item")
        cutscene:setTextboxTop(false)
        cutscene:text("* You got the [color:yellow]CrossBow[color:reset]!")
        cutscene:text(text)
        ghost:fadeOutAndRemove(0.5)
        cutscene:wait(0.5)
        cutscene:interpolateFollowers()
        cutscene:attachFollowers()
        cutscene:attachCamera(0.5)
        cutscene:wait(0.5)
        cutscene:text("* Okay.", "neutral", "ralsei")
    end 
}
