return {
    cauldron = function(cutscene, me, chara, facing)
        local susie = cutscene:getCharacter("susie")
        local ralsei = cutscene:getCharacter("ralsei")

        if susie and ralsei then
            cutscene:text("{hometown.text.how_bout_a_strawberry_cake_as_a_room_warming_gif_147a99d5f1}", "surprise_smile", "susie")
            cutscene:text("{hometown.text.there_s_a_slice_of_cake_in_your_fridge_wait_5_su_de1df74de1}", "pleased", "ralsei")
            cutscene:text("{hometown.text.but_it_s_not_cauldron_fresh_c06890632b}", "blush", "susie")
        end
    end,
}