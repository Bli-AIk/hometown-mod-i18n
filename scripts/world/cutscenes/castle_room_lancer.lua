return {
    music_player = function(cutscene, me, chara, facing)
        cutscene:text("{hometown.text.it_s_a_music_player_wait_5_listen_to_the_content_2f67f2d009}")
        local choice = cutscene:choicer({"Listen", "Do Not"})
        if choice == 1 then
            cutscene:playSound("splat")
            cutscene:text("{hometown.text.text_9727d4d874}")
            cutscene:text("{hometown.text.it_s_full_of_cartoon_splat_noises_969cb90f77}")
        else
            cutscene:text("{hometown.text.you_did_not_listen_877885e0df}")
        end
    end
}