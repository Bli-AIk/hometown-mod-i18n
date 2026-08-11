return {
    ---@param cutscene WorldCutscene
    organ = function(cutscene, event, player)
        cutscene:text("{hometown.text.a_giant_organ_90cd594e04}")
    end,

    door = function(cutscene, event, player)
        cutscene:text("{hometown.text.it_s_a_door_a_large_person_could_fit_inside_db8a346666}")
        local choice = cutscene:choicer({"{hometown.text.turn_the_doorknob_8fe4439e7e}", "Do not"})
        if choice == 1 then
            cutscene:text("{hometown.text.you_turned_the_doorknob_13848e425a}")
            cutscene:text("{hometown.text.text_9727d4d874}")
            if Game.party[1].id == "kris" then
                cutscene:text("{hometown.text.wait_5_you_didn_t_do_anything_else_4b5128f493}")
            else
                cutscene:text("{hometown.text.wait_5_it_s_not_opening_must_be_locked_15d08e0368}")
            end
        end
    end,

    candles = function(cutscene, event, player)
        cutscene:text("{hometown.text.it_s_an_altar_full_of_hope_candles_wait_5_each_o_d5d491643b}")
    end,

    fire_extinguisher = function(cutscene, event, player)
        if cutscene:getCharacter("susie_lw") then
            cutscene:text("{hometown.text.it_s_a_fire_extinguisher_wait_10_for_some_reason_abecd94789}")
            cutscene:text("{hometown.text.wait_5_susie_will_say_something_stupid_about_it__007fe5662f}", nil, nil, {reactions={{"{hometown.text.they_should_make_one_of_these_that_shoots_whip_c_4d68a3ba6b}", "mid", "bottom", "smile", "susie"}}})
        else
            cutscene:text("{hometown.text.it_s_a_fire_extinguisher_b129291165}")
        end
    end,

    holy_water = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_a_bowl_of_blessed_water_with_a_motion_senso_ad1563ca86}")
        cutscene:text("{hometown.text.it_s_not_clear_what_happens_if_you_touch_the_sen_4c3043f2b5}")
    end,

    entrance_bookshelf = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_a_bookshelf_full_of_hymnals_and_scripture_d0bd147352}")
        cutscene:text("{hometown.text.wait_5_and_some_copies_of_lord_of_the_hammer_5330a5d753}")
    end,

    pitcher = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_a_large_pitcher_of_water_cdade4bf24}")
        cutscene:text("{hometown.text.cups_are_stored_below_it_a6c5306005}")
    end,

    drinks = function(cutscene, event)
        cutscene:text("{hometown.text.juice_wait_5_and_wafer_like_crackers_61346c1610}")
    end,

    cupboard = function(cutscene, event)
        cutscene:text("{hometown.text.documents_87a11b64c8}")
    end,

    office_bookshelf = function(cutscene, event)
        cutscene:text("{hometown.text.books_many_copies_of_lord_of_the_hammer_wait_5_a_b87cd7d0a1}")
    end,

    plaque = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_a_plaque_bearing_the_words_of_a_famous_writ_f45b6717c2}")
        cutscene:text("{hometown.text.hope_comes_to_those_who_believe_and_for_those_th_a6896c293f}")
        cutscene:text("{hometown.text.wait_5_may_our_hope_shine_so_brightly_fadbc18f52}")
        cutscene:text("{hometown.text.wait_5_that_they_wait_5_too_wait_5_may_keep_shel_838eb83449}")
    end,

    hanging = function(cutscene, event)
        cutscene:text("{hometown.text.seems_to_be_some_sort_of_incense_container_c16d165826}")
    end,

    wardrobe = function(cutscene, event)
        cutscene:text("{hometown.text.the_wardrobe_is_full_of_choir_robes_wait_5_there_214e862262}")
    end,

    bells = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_a_set_of_bells_of_different_sizes_14645b27d0}")
        local dowemess = cutscene:choicer({"{hometown.text.mess_with_them_8ab7caee20}", "{hometown.text.don_t_bfed24b7dd}"})
        if dowemess == 1 then -- I tried to port the thing but it kinda broke. Any help on that?
            local count = 0
            Assets.playSound("churchbell_short", (0.7 - count / 8), 1.17 - count / 40)
            count = count + 1
            cutscene:wait(0.05)
            Assets.playSound("churchbell_short", (0.7 - count / 8), 0.97 - count / 40)
            count = count + 1
            cutscene:wait(0.05)
            Assets.playSound("churchbell_short", (0.7 - count / 8), 1.17 - count / 40)
            count = count + 1
            cutscene:wait(0.05)
            Assets.playSound("churchbell_short", (0.7 - count / 8), 0.97 - count / 40)
            count = count + 1
            cutscene:wait(0.05)
            Assets.playSound("churchbell_short", (0.7 - count / 8), 1.17 - count / 40)
            count = count + 1
            cutscene:wait(0.05)
            Assets.playSound("churchbell_short", (0.7 - count / 8), 0.97 - count / 40)
            cutscene:wait(0.5)
        end
    end,

    piano = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_a_keyboard_it_has_settings_to_sound_like_ei_836de4a6df}")
    end,
}
