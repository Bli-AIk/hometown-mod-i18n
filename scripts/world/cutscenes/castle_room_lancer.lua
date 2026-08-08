return {
    music_player = function(cutscene, me, chara, facing)
        cutscene:text("* (It's a music player.)[wait:5]\n* (Listen to the contents?)")
        local choice = cutscene:choicer({"Listen", "Do Not"})
        if choice == 1 then
            cutscene:playSound("splat")
            cutscene:text("* (...)")
            cutscene:text("* (It's full of cartoon splat noises.)")
        else
            cutscene:text("* (You did not listen.)")
        end
    end
}