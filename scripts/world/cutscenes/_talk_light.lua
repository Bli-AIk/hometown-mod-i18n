return function(cutscene)
    local susie = cutscene:getCharacter("susie")
    local noelle = cutscene:getCharacter("noelle")
    local ceroba = cutscene:getCharacter("ceroba")
    if Game.world.map.id == "light/hometown/town_school" then
        if ceroba then
            cutscene:text("{hometown.text.why_is_there_only_one_parking_place_2207f45d97}", "unsure", ceroba)
            cutscene:text("{hometown.text.do_you_have_only_one_car_in_town_c8682ed134}", "unsure_alt", ceroba)
            if noelle then
                cutscene:text("{hometown.text.oh_wait_10_it_s_actually_because_5959730f34}", "smile", noelle)
                cutscene:text("* ...", "confused", noelle)
                cutscene:text("* ...", "frown", noelle)
                cutscene:text("* ...", "confused_surprise_b", noelle)
                cutscene:text("{hometown.text.actually_wait_5_i_don_t_know_0a4fde828e}", "what_smile", noelle)
            end
        else
            cutscene:text("{hometown.text.your_voice_echoes_aimlessly_a657a3d66c}")
        end
    elseif Game.world.map.id == "light/hometown/school/school_lobby" then
        if ceroba then
            cutscene:text("{hometown.text.so_wait_5_this_is_your_school_wait_5_huh_188570b1c9}", "alt", ceroba)
            cutscene:text("{hometown.text.hopefully_we_won_t_get_in_trouble_here_for_tresp_73ac906342}", "nervous_smile", ceroba)
            cutscene:text("{hometown.text.especially_me_wait_5_since_wait_5_you_know_515d2da3ac}", "confounded", ceroba)
            cutscene:text("{hometown.text.i_m_not_a_child_nor_a_teacher_to_be_walking_arou_f3e3d34367}", "nervous_smile", ceroba)
        else
            cutscene:text("{hometown.text.your_voice_echoes_aimlessly_a657a3d66c}")
        end
    elseif Game.world.map.id == "light/hometown/school/kris_class" then
        if ceroba then
            cutscene:text("{hometown.text.a_generic_classroom_f0d28b893d}", "alt", ceroba)
            cutscene:text("{hometown.text.personally_i_wouldn_t_say_there_s_anything_to_ta_1c54b47dab}", "neutral", ceroba)
        else
            cutscene:text("{hometown.text.your_voice_echoes_aimlessly_a657a3d66c}")
        end
    elseif Game.world.map.id == "light/hometown/school/toriel_class" then
        if ceroba then
            if not Game.world.map.ceroba_talk then
                cutscene:text("{hometown.text.this_must_be_a_class_for_low_graders_wait_5_righ_dd4295f734}", "neutral", ceroba)
                cutscene:text("* ...", "alt", ceroba)
                cutscene:text("{hometown.text.wait_wait_5_ms_toriel_3a1351de48}", "surprised", ceroba)
                cutscene:text("{hometown.text.the_toriel_wait_10_toriel_dreemurr_0be2eb0e71}", "nervous", ceroba)
                cutscene:text("{hometown.text.no_wait_5_this_is_probably_just_a_coincidence_43b6b1e80c}", "dissapproving", ceroba)
                Game.world.map.ceroba_talk = 1
            else
                cutscene:text("* ...", "alt", ceroba)
                cutscene:text("{hometown.text.kanako_would_love_it_here_7fb8d10236}", "dissapproving", ceroba)
            end
        else
            cutscene:text("{hometown.text.your_voice_echoes_aimlessly_a657a3d66c}")
        end
    elseif Game.world.map.id == "light/hometown/school/school_door" then
        if ceroba then
            cutscene:text("{hometown.text.just_another_school_corridor_31efbbeab9}", "alt", ceroba)
            cutscene:text("{hometown.text.nothing_i_haven_t_seen_d78892c193}", "closed_eyes", ceroba)
        else
            cutscene:text("{hometown.text.your_voice_echoes_aimlessly_a657a3d66c}")
        end
    elseif Game.world.map.id == "light/hometown/school/unused_class" then
        if ceroba then
            cutscene:text("{hometown.text.this_classroom_is_wait_10_face_unsure_alt_quite__dd445f95b6}", "unsure", ceroba)
            cutscene:text("{hometown.text.it_must_be_unused_then_176238bce6}", "closed_eyes", ceroba)
        else
            cutscene:text("{hometown.text.your_voice_echoes_aimlessly_a657a3d66c}")
        end
    else
        cutscene:text("{hometown.text.your_voice_echoes_aimlessly_a657a3d66c}")
    end
end