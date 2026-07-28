return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    recep = function(cutscene, event)
        Game.world:spawnObject(musiclogo("hallway", 180, 120, 160, 120, 140, 120), 9999)
        Game.world.music:setVolume(0)
        Game.world.music:fade(1, 0.5)
    end, 
    
    forest = function(cutscene, event)
        Game.world:spawnObject(musiclogo("bloomforest", 180, 120, 160, 120, 140, 120), 9999)
        Game.world.music:setVolume(0)
        Game.world.music:fade(1, 0.5)
        cutscene:wait(2)
        cutscene:text("[noskip]* (You swear you can hear a voice saying \"Winter blooms in your heart\".)")
        cutscene:wait(0.5)
        cutscene:text("[noskip]* (But,[wait:5] it was just your imagination...)")
    end, 





}