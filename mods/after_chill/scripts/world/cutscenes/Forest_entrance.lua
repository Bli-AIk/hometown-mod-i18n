return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    WithRalsei = function(cutscene, event)
        --setup stuff.
        cutscene:detachFollowers()
        local kris = cutscene:getCharacter("kris")
        local ralsei = cutscene:getCharacter("ralsei")

        local starbg = Game.world.map:getTileLayer("stars") 
        local cloudbg = Game.world.map:getTileLayer("Cloud")
        local slopeCloud = Game.world.map:getTileLayer("Slope clouds")
        local slopestar = Game.world.map:getTileLayer("Slope stars")
        local slopestarshine = Game.world.map:getTileLayer("Slope shine")
        
        slopeCloud.visible = true
        cloudbg.visible = true
        kris:addFX(ColorMaskFX({0,0,0},0.5))
        ralsei:addFX(ColorMaskFX({0,0,0},0.5))

        kris:moveTo(68,-40, 0.1)
        ralsei:moveTo(68,-80, 0.1)
        cutscene:shakeCharacter("kris", 0.5, 0, 0, 0.08)
        cutscene:shakeCharacter("ralsei", -0.5, 0, 0, 0.1)
        cutscene:fadeOut(0)
        cutscene:wait(1)
        cutscene:fadeIn(0.25)
       
        --Grabs and sets up characters
        
        kris:setAnimation("slide")
        ralsei:setAnimation("slide")
        cutscene:wait(1)
        cutscene:slideTo("kris", 90, 310, 4, "out-back")
        cutscene:slideTo("ralsei", 85, 206, 4, "out-back")
        
        kris:addFX(ColorMaskFX({0,0,0.1},0.35))
        ralsei:addFX(ColorMaskFX({0,0,0.1},0.35))

        cutscene:setSpeaker(ralsei)
        cutscene:text("* Wow Kris,[wait:5] this is quite the long slide huh!", "pleased")

        slopeCloud.visible = false
        cloudbg.visible = false
            

    --reset cutscene stuff and set flag.
        cutscene:attachCamera()
        cutscene:alignFollowers()
        --cutscene:attachFollowers()
        Game:setFlag("Forestfall", true)
        
    end,
}
