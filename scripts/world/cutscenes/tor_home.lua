return {
    ---@param cutscene WorldCutscene
    chairiel = function(cutscene, event, player)
        cutscene:text("{hometown.chairiel.chairiel_beloved_living_room_chair}")
    end,

    fridge = function(cutscene, event, player)
        cutscene:text("{hometown.fridge.photo_fridge_mother_brother}")
    end,

    oven = function(cutscene, event, player)
        cutscene:text("{hometown.oven.mom_didnt_cook_anything_today}")
    end,

    template = function(cutscene, event)
    end,
}
