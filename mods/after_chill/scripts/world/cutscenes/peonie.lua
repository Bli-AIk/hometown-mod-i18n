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
    sfx = Assets.playSound("grab", 0.4)
    enemy:fadeTo(1, sfx:getDuration())
    cutscene:wait(sfx:getDuration())
    Assets.playSound("wing")
    enemy:shake(2)
    cutscene:wait(0.3)
    cutscene:startEncounter("peonie", nil, {{"peonie", enemy}})
    enemy:remove()
    end 
end

}
