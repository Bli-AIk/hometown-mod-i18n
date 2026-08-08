return {
    ---@param cutscene WorldCutscene
    chairiel = function(cutscene, event, player)
        cutscene:text("* (It's Chairiel!)[wait:5]\n* (The beloved living room chair!)")
    end,

    fridge = function(cutscene, event, player)
        cutscene:text("* There's a photo on the fridge.[wait:5] It's of you,[wait:5] your mother, and your brother.")
    end,

    oven = function(cutscene, event, player)
        cutscene:text("* (Mom didn't cook anything today.)")
    end,

    template = function(cutscene, event)
    end,
}
