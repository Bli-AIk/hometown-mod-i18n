return {
    bed = function(cutscene, me, chara, facing)
        if cutscene:getCharacter("susie") then
            cutscene:text("{hometown.text.cool_wait_5_spike_bed_0761e4d0be}", "smile", "susie")
            cutscene:text("{hometown.text.now_i_can_stab_myself_during_the_night_04aa7b5ab8}", "smirk", "susie")
            cutscene:text("{hometown.text.finally_some_convenience_4c89f0a280}", "smile", "susie")
        end
    end,
    fridge = function(cutscene, me, chara, facing)
        if cutscene:getCharacter("susie") then
            if me.interact_count > 1 then
                cutscene:text("{hometown.text.hey_kris_wait_5_stop_eye_bogarting_my_snacks_1b245848e9}", "teeth", "susie")
            else
                cutscene:text("{hometown.text.damn_wait_5_there_s_everything_in_here_f3cea83ed0}", "surprise_smile", "susie")
                cutscene:text("{hometown.text.pinecones_wait_5_chalk_wait_5_moss_wait_5_jars_o_db15d1f96d}", "surprise_smile", "susie")
                cutscene:text("{hometown.text.pieces_of_ice_wait_5_black_crumbs_from_the_toast_5a18e7267e}", "surprise_smile", "susie")
                cutscene:text("{hometown.text.wait_5_oh_wait_5_and_like_actual_food_wait_5_too_282c2debc8}", "smile", "susie")
            end
        end
    end,
    manual_stand = function(cutscene, me, chara, facing)
        if cutscene:getCharacter("susie") and cutscene:getCharacter("ralsei") then
            cutscene:text("{hometown.text.susie_wait_5_you_didn_t_get_to_read_the_manual_a8b77470ce}", "neutral", "ralsei")
            cutscene:text("{hometown.text.so_i_put_it_over_here_for_you_8d7c627929}", "blush_smile", "ralsei")
            cutscene:text("{hometown.text.cool_wait_5_i_ll_read_it_before_bed_943512e1db}", "small_smile", "susie")
            cutscene:text("{hometown.text.that_ll_put_me_to_sleep_e6bfddc21f}", "smile", "susie")
        else
            cutscene:text("{hometown.text.it_s_a_stand_for_susie_s_manual_4b8f434401}")
        end
    end,
    clothes_drawer = function(cutscene, me, chara, facing)
        cutscene:text("{hometown.text.it_s_a_clothes_drawer_full_of_spikey_and_dangero_96551f198d}")
        cutscene:text("{hometown.text.all_the_clothes_are_ripping_each_other_up_into_s_8ecc2b248f}")
        if cutscene:getCharacter("susie") then
            cutscene:text("{hometown.text.hell_yeah_wait_5_jealous_wait_5_kris_914e1dc726}", "smile", "susie")
        end
    end
}