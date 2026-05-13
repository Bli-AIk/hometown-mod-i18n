return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    wall = function(cutscene, event)
            Game:removePartyMember("ralsei")
            cutscene:loadMap("room2")
            local noelle = cutscene:spawnNPC("noelle", 225, -30)
            noelle:setAnimation("fall")
            noelle:slideTo(239, 266, 1.5, "in-cubic")
            cutscene:wait(1.5)
            Assets.playSound("impact")
            noelle:setSprite("collapsed")
            noelle.sprite.scale_x = -1 
            noelle.x = noelle.x + 50 
            Game:addPartyMember("kris")
                        for _, child in ipairs(Game.world.children) do 
                if child:includes(ChaserEnemy) then 
                    child:remove()
                end 
            end 
    end
}
