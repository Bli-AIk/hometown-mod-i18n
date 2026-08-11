return {
    music_player = function(cutscene, me, chara, facing)
        cutscene:text("{hometown.music_player.music_player_listen_contents}")
        local choice = cutscene:choicer({"Listen", "Do Not"})
        if choice == 1 then
            cutscene:playSound("splat")
            cutscene:text("{hometown.music_player.text}")
            cutscene:text("{hometown.music_player.full_cartoon_splat_noises}")
        else
            cutscene:text("{hometown.music_player.listen}")
        end
    end
}