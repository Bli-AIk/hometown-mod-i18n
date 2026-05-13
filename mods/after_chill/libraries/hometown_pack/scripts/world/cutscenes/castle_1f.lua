return {
    cauldron = function(cutscene, me, chara, facing)
        local susie = cutscene:getCharacter("susie")
        local ralsei = cutscene:getCharacter("ralsei")

        if susie and ralsei then
            cutscene:text("* How 'bout a strawberry cake as a room-warming gift?", "surprise_smile", "susie")
            cutscene:text("* There's a slice of cake in your fridge,[wait:5] Susie!", "pleased", "ralsei")
            cutscene:text("* But it's not cauldron-fresh!", "blush", "susie")
        end
    end,
}