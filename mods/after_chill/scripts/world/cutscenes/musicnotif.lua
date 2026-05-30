return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    recep = function(cutscene, event)
        Game.world:spawnObject(musiclogo("field", 180, 120, 160, 120, 140, 120), 9999)




















    end





}