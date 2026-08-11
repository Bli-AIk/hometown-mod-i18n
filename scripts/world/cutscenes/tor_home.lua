return {
    ---@param cutscene WorldCutscene
    chairiel = function(cutscene, event, player)
        cutscene:text("{hometown.text.it_s_chairiel_wait_5_the_beloved_living_room_cha_10f09120f8}")
    end,

    fridge = function(cutscene, event, player)
        cutscene:text("{hometown.text.there_s_a_photo_on_the_fridge_wait_5_it_s_of_you_e9c82f9a35}")
    end,

    oven = function(cutscene, event, player)
        cutscene:text("{hometown.text.mom_didn_t_cook_anything_today_2aef85cf68}")
    end,

    template = function(cutscene, event)
    end,
}
