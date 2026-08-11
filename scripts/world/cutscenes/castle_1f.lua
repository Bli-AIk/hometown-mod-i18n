return {
    cauldron = function(cutscene, me, chara, facing)
        local susie = cutscene:getCharacter("susie")
        local ralsei = cutscene:getCharacter("ralsei")

        if susie and ralsei then
            cutscene:text("{hometown.cauldron.how_bout_strawberry_cake_room}", "surprise_smile", "susie")
            cutscene:text("{hometown.cauldron.slice_cake_fridge_susie}", "pleased", "ralsei")
            cutscene:text("{hometown.cauldron.cauldron_fresh}", "blush", "susie")
        end
    end,
}