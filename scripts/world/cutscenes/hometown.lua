return {
    ---@param cutscene WorldCutscene

    hospitalpiano = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_an_obligatory_hospital_piano_wait_5_shrunk__cc5ed8bee4}")
        cutscene:text("{hometown.text.as_a_result_wait_5_it_s_missing_most_of_the_good_523d68d949}")
        cutscene:text("{hometown.text.play_it_4c0ed6f529}")
        local opinion = cutscene:choicer({"{yes}", "{no}"})
            if opinion == 1 then
                Assets.playSound("pianonoise")
                cutscene:text("{hometown.text.plink_6ad3e77c20}")
            else
                cutscene:text("{hometown.text.your_hands_linger_over_the_keys_doing_nothing_da9edbb6df}")
            end
    end,

    pre_knight_corner = function (cutscene, event)
        local susie = cutscene:getCharacter("susie")
        if Game:getFlag("knight_corner", false) then
            if cutscene:getCharacter(susie) then
                cutscene:text("{hometown.text.it_s_a_door_fb1c09569b}")
                cutscene:text("{hometown.text.that_s_the_uh_mayor_s_office_6f4ba7ff6d}", "sus_nervous", "susie")
                cutscene:text("{hometown.text.if_we_got_in_we_would_be_in_big_trouble_7e2e25c7bb}", "nervous_side", "susie")
                cutscene:text("{hometown.text.not_like_i_care_let_s_go_d029c6e940}", "teeth_smile", "susie")
            end
        end
    end,

    hospitaltoy = function(cutscene, event)

        cutscene:text("{hometown.text.it_s_a_toy_with_beads_on_a_track_9d677ebb02}")
        if Game:getFlag("POST_SNOWGRAVE") then
            cutscene:text("{hometown.text.one_of_the_blue_beads_is_broken_and_torn_off_a438cb678f}")
        else
            cutscene:text("{hometown.text.the_beads_of_the_toy_march_on_8237c7c14f}")
        end
        
    end,

    asgorefridge = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_a_rusty_fridge_with_some_photos_on_it_0aa80b037b}")
        local opinion = cutscene:choicer({"{hometown.text.open_fridge_005bc4f5b8}", "{hometown.text.don_t_bfed24b7dd}", "{hometown.text.see_photos_770dd0d021}"})
        if opinion == 1 then
          cutscene:text("{hometown.text.all_that_s_inside_is_a_jar_with_a_single_pickle__093c94edd9}")
        elseif opinion == 3 then
          cutscene:text("{hometown.text.a_photo_of_your_mother_and_father_on_their_weddi_4e25ece3e8}")
          cutscene:text("{hometown.text.she_s_holding_a_bouquet_of_seven_flowers_68028dbfcd}")
          cutscene:text("{hometown.text.a_reindeer_looking_monster_stands_nearby_in_a_tu_2c1d7a7cfe}")
          cutscene:text("{hometown.text.they_all_look_happy_a31b6f7dad}")
        else
          cutscene:text("{hometown.text.you_decide_not_to_look_e927ec71df}")
        end
    end,

    asgoretruck = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_your_dad_s_truck_ea171fc645}")
        cutscene:text("{hometown.text.the_floor_of_the_front_seat_is_littered_with_old_68e16cc962}")
    end,

    librarybook1 = function(cutscene, event)

      cutscene:text("{hometown.text.how_to_care_for_a_human_a74e98d28f}")
      cutscene:text("{hometown.text.it_s_a_book_for_monsters_about_how_to_care_for_h_92aad532b6}")
      local opinion = cutscene:choicer({"{hometown.text.look_in_the_back_317e819db7}", "{hometown.text.look_inside_63296963c5}"})
        if opinion == 1 then
          cutscene:text("{hometown.text.according_to_the_card_in_the_back_877f78a2a9}")
          cutscene:text("{hometown.text.looks_like_your_mother_took_it_repeatedly_many_y_82baade760}")
        else
            cutscene:text("{hometown.text.there_are_photos_of_unfamiliar_humans_inside_9ce597118e}")
            local leader_id = GeneralUtils:getLeader().id
            if leader_id == "kris" then
                cutscene:text("{hometown.text.you_shut_the_book_quickly_91ff636c59}")
            end
        end

    end,

    librarybook2 = function(cutscene, event)

      cutscene:text("{hometown.text.it_s_book_1_about_souls_read_it_9d9e5aa0e5}")
      local opinion = cutscene:choicer({"{hometown.text.read_852b438f91}", "{hometown.text.don_t_bfed24b7dd}"})
        if opinion == 1 then
          cutscene:text("{hometown.text.the_soul_has_been_called_many_things_fb7f8e05e9}")
          cutscene:text("{hometown.text.the_font_of_our_compassion_the_source_of_our_wil_c11e28a729}")
          cutscene:text("{hometown.text.the_container_of_our_life_force_a15e7a3392}")
          cutscene:text("{hometown.text.but_even_now_wait_5_the_true_function_of_it_is_u_187fa0c99a}")
        end

    end,

    papyrushouse = function(cutscene, event)

      Assets.playSound("knock")
      cutscene:text("{hometown.text.knock_knock_knock_74742ece2b}")
      cutscene:text("{hometown.text.text_9727d4d874}")
      cutscene:text("{hometown.text.no_response_wait_5_not_even_the_distant_trousle__dcd7fdaacd}")

    end,

    sansplin = function(cutscene, event)

      Assets.playSound("bell")

    end,

    iceesoda = function(cutscene, event)

      cutscene:text("{hometown.text.it_s_a_soda_dispensing_machine_d40ad42f3e}")
      local opinion = cutscene:choicer({"{hometown.text.inspect_18ca87afec}", "{hometown.text.not_ca1dd39379}"})
        if opinion == 1 then
          cutscene:text("{hometown.text.you_took_a_look_at_the_flavors_168f5650ce}")
          cutscene:text("{hometown.text.water_d05d90dbe2}")
          cutscene:text("* ICE")
          cutscene:text("{hometown.text.double_ice_0216827943}")
          cutscene:text("{hometown.text.bread_2ec01e82cb}")
          cutscene:text("{hometown.text.flamin_hot_cheese_soda_5e1b3eb31b}")
          cutscene:text("{hometown.text.gamer_blood_energy_drink_b15ec39bd9}")
          cutscene:text("{hometown.text.juice_red_flavor_cdaf82a2cf}")
        end

    end,
	
    toilet = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_a_toilet_wait_5_flush_it_6a84997f9b}")
        local choice = cutscene:choicer({"{yes}", "{no}"})
        if choice == 1 then
            Game.world.music:fade(0,0.001)
            Assets.playSound("toilet")
			
            cutscene:wait(1)
			
            Assets.playSound("won")
            cutscene:text("{hometown.text.you_flushed_the_toilet_02fbdcd8e1}")
            Game.world.music:fade(1,1)
        end
    end,
	
    asriel_bed = function(cutscene, event)
        cutscene:text("{hometown.text.there_are_cds_under_the_bed_wait_5_classical_wai_c92f86bea4}")
        cutscene:text("{hometown.text.there_s_also_a_game_console_wait_5_it_has_one_no_7486457473}")
    end,

    torcar = function(cutscene, event)
        if Game.party[1].id == "kris" then
            cutscene:text("{hometown.text.it_s_your_mom_s_car_6305953cb5}")
            cutscene:text("{hometown.text.seems_like_she_hasn_t_replaced_the_tires_yet_jud_a6e93ea46f}")
        else
            cutscene:text("{hometown.text.a_red_car_that_can_hold_up_to_at_least_four_peop_ebb68b9419}")
            cutscene:text("{hometown.text.the_tires_on_the_car_appear_to_be_slashed_5ac1a48490}")
        end
    end,

    rudy = function(cutscene, event)
        local rudy = cutscene:getCharacter("rudy")
        local noelle = cutscene:getCharacter("noelle_lw")
        local susie = cutscene:getCharacter("susie_lw")
        local kris = cutscene:getCharacter("kris_lw")
        Assets.playSound("rudycough")
        rudy:setAnimation("cough")
        cutscene:wait(1.5)
        rudy:setSprite("d")
        if not Game.world.map.rudy_greeting then
            if noelle then
                cutscene:text("{hometown.text.well_wait_5_if_it_isn_t_my_dear_noelle_c522059a10}", "happier", "rudy")
                if susie then
                    cutscene:text("{hometown.text.i_see_you_ve_brought_23d9f32ce0}", "smile", "rudy")
                    local notreally = "friend"
                    local susieline = "???"
                    if kris then
                        notreally = "friends"
                        susieline = "{hometown.text.kris_5cb6cdccbc}"
                    end
                    local greeting_id = notreally == "friend" and "hometown.text.your_friend_wait_5_as_well_react_1_wait_5_react__bdbb70f915" or "hometown.text.your_friends_wait_5_as_well_react_1_wait_5_react_4f2e217c44"
                    cutscene:text("{"..greeting_id.."}", "wink", "rudy", {reactions={
                        {"DAD!!!", "mid", "mid", "shock", "noelle"},
                        {susieline, "right", "bottom", "shy_b", "susie"}
                    }})
                end
                cutscene:text("{hometown.text.how_have_you_been_wait_5_sweetheart_465523bd0e}", "smile_side", "rudy")
                cutscene:text("{hometown.text.not_much_wait_5_lately_i_ve_just_been_having_fun_f375a7fd98}", "smile_closed", "noelle")
                cutscene:text("{hometown.text.ah_wait_5_that_s_great_wait_5_that_s_great_112177e742}", "happy", "rudy")
            elseif susie then
                if kris then
                    cutscene:text("{hometown.text.susie_wait_5_kris_wait_5_isn_t_it_wonderful_to_s_317bd938d7}", "happier", "rudy")
                    cutscene:text("{hometown.text.what_is_it_wait_5_susie_needs_me_for_some_noelle_09575fb849}", "wink", "rudy")
                else
                    cutscene:text("{hometown.text.susie_isn_t_it_wonderful_to_see_you_a8f95731ae}", "happier", "rudy")
                    cutscene:text("{hometown.text.what_is_it_wait_5_need_me_for_some_noelle_advice_b7483a6a93}", "wink", "rudy")
                end
                cutscene:text("{hometown.text.wh_wait_5_i_wait_5_face_teeth_b_no_7003a6d462}", "blush", "susie")
                cutscene:text("{hometown.text.heh_wait_5_heh_wait_10_whatever_you_say_98652dee1a}", "smile", "rudy")
            elseif kris then
                cutscene:text("{hometown.text.hey_krismas_wait_5_what_s_up_920c7c0903}", "happier", "rudy")
                if #Game.party == 1 then
                    cutscene:text("{hometown.text.where_s_your_friend_wait_5_is_she_busy_525c67a600}", "neutral", "rudy")
                    cutscene:text("{hometown.text.now_wait_5_don_t_worry_wait_5_i_m_sure_she_ll_ge_f586c155c1}", "neutral", "rudy")
                else
                    cutscene:text("{hometown.text.you_ve_got_some_new_friends_i_see_f70ea7c16d}", "smile", "rudy")
                    cutscene:text("{hometown.text.well_wait_5_in_the_meantime_wait_10_kris_wait_5__de0f3e1c02}", "neutral", "rudy")
                    cutscene:text("{hometown.text.noelle_wait_5_susie_wait_10_don_t_forget_about_t_7b107c02b6}", "upset", "rudy")
                    cutscene:text("{hometown.text.they_seem_to_be_happy_around_you_7d168cbdbf}", "wink", "rudy")
                end
            else
                cutscene:text("{hometown.text.heh_wait_5_heh_e83c0bc0bf}", "smile_side", "rudy")
                cutscene:text("{hometown.text.wow_wait_5_this_is_gotta_be_the_first_time_i_hav_ade9df19a6}", "happy", "rudy")
                cutscene:text("{hometown.text.whom_i_don_t_even_know_acb7baac17}", "happier", "rudy")
                Assets.playSound("rudylaugh")
                rudy:setAnimation("laugh")
                cutscene:wait(1.5)
                rudy:setSprite("d")
            end
            cutscene:text("{hometown.text.oh_wait_5_you_wanted_to_chat_about_something_d3290f4277}", "smile_side", "rudy")
            Game.world.map.rudy_greeting = true
        else
            cutscene:text("{hometown.text.want_to_chat_54968cf3ba}", "smile", "rudy")
        end
        local topic = cutscene:choicer({"{hometown.text.sickness_ac52ddc76b}", "{hometown.text.leave_7e3520a973}"})
        if topic == 1 then
            if noelle then
                cutscene:text("{hometown.text.don_t_worry_sweetie_wait_5_i_m_gonna_be_outta_he_11fd1e157f}", "smile", "rudy")
                cutscene:text("{hometown.text.i_just_wait_10_need_a_bit_more_rest_wait_5_that__8043e611eb}", "smile_side", "rudy")
            else
                local names = ""
                if kris then
                    names = ",[wait:5] Kris"
                    if susie then
                        names = ",[wait:5] Kris,[wait:5] Susie"
                    end
                elseif susie then
                    names = ",[wait:5] Susie"
                end
                local greeting_id
                if kris then
                    greeting_id = susie and "hometown.text.hey_wait_5_kris_wait_5_susie_wait_10_don_t_tell__56a4d69b88" or "hometown.text.hey_wait_5_kris_wait_10_don_t_tell_that_to_noell_8907f408cf"
                elseif susie then
                    greeting_id = "hometown.text.hey_wait_5_susie_wait_10_don_t_tell_that_to_noel_b0903b40de"
                else
                    greeting_id = "hometown.text.hey_wait_10_don_t_tell_that_to_noelle_wait_5_but_afa0f020e9"
                end
                cutscene:text("{"..greeting_id.."}", "upset", "rudy")
                cutscene:text("{hometown.text.i_m_not_sure_if_i_m_gonna_be_out_of_here_anytime_c7d80f1fdf}", "serious", "rudy")
                cutscene:text("{hometown.text.the_coughing_s_been_getting_worse_recently_8d7ec1cdc1}", "upset", "rudy")
                cutscene:text("{hometown.text.now_wait_5_don_t_worry_wait_5_i_m_not_going_down_7a3a97d7e7}", "wink", "rudy")
                if kris or susie then
                    if Game:getFlag("rudy_promise") then
                        cutscene:text("{hometown.text.hey_0499e75032}", "happy", "rudy")
                        cutscene:text("{hometown.text.thanks_again_for_that_promise_fa6fe9f208}", "happier", "rudy")
                        cutscene:text("{hometown.text.and_don_t_worry_about_me_wait_5_i_m_more_than_fi_9bca146048}", "wink", "rudy")
                    else
                        if kris then
                            if susie then
                                cutscene:text("{hometown.text.but_if_wait_10_kris_wait_10_kris_wait_5_susie_wa_7452e85b84}", "serious", "rudy")
                            else
                                cutscene:text("{hometown.text.but_if_wait_10_kris_wait_10_kris_wait_5_if_somet_37652ff755}", "serious", "rudy")
                            end
                        elseif susie then
                            cutscene:text("{hometown.text.but_if_wait_10_susie_wait_10_susie_wait_5_if_som_eef4433d30}", "serious", "rudy")
                        end
                        cutscene:text("{hometown.text.promise_me_you_ll_take_good_care_of_noelle_wait__f87f0a83ef}", "smile_side", "rudy")
                        cutscene:text("{hometown.text.she_can_t_be_left_all_alone_by_herself_56cf72745e}", "neutral", "rudy")
                        cutscene:text("{hometown.text.is_that_not_too_much_to_ask_b130a61186}", "smile_side", "rudy")
                        if kris then
                            cutscene:choicer({"{hometown.text.promise_fe5671922b}", "{hometown.text.promise_fe5671922b}"})
                            if susie then
                                cutscene:text("{hometown.text.we_wait_10_we_promise_71f2aeb61b}", "shy_down", "susie")
                            end
                        elseif susie then
                            cutscene:text("{hometown.text.i_wait_10_i_promise_37376758a8}", "shy_down", "susie")
                        end
                        cutscene:text("{hometown.text.h_wait_10_heh_wait_5_thank_you_f78b3d6eb1}", "smile_side", "rudy")
                        Assets.playSound("rudycough")
                        rudy:setAnimation("cough")
                        cutscene:wait(1.5)
                        rudy:setSprite("d")
                        Game:setFlag("rudy_promise", true)
                    end
                else
                    cutscene:text("{hometown.text.huh_wait_5_what_i_m_diagnosed_with_fed77bb342}", "serious", "rudy")
                    cutscene:text("{hometown.text.i_appreciate_your_concern_wait_5_but_2faafc04df}", "smile_side", "rudy")
                    cutscene:text("{hometown.text.it_s_not_like_there_s_anything_you_could_do_wait_4be9eda4a1}", "happy", "rudy")
                end
            end
        else
            cutscene:text("{hometown.text.have_a_good_day_46f680b48d}", "happy", "rudy")
        end
    end,

    hospitalroom2bed = function(cutscene, event)
        if Game:getFlag("POST_SNOWGRAVE") then
            cutscene:text("{hometown.text.he_s_breathing_slowly_bdf1a791f9}")
        else
            cutscene:text("{hometown.text.it_s_an_empty_bed_1178129bbf}")
        end
    end,

    blook = function(cutscene, event) --placeholder dialogue lol
        local blook = cutscene:getCharacter("napstablook")
        blook:setFacing("right")
        cutscene:text("{hometown.text.oh_wait_5_hey_f522b97840}", nil)
        cutscene:text("{hometown.text.if_you_re_looking_for_officer_undyne_she_s_not_h_23af7c43d4}", nil)
        blook:setFacing("down")
    end,

    sans = function(cutscene, event)
        local susie = cutscene:getCharacter("susie_lw")
        cutscene:text("{hometown.text.font_sans_heya_920e604cd5}", "neutral", "sans")
        cutscene:text("{hometown.text.font_sans_you_need_somethin_e2cad04a12}", "neutral", "sans")
        local choice = cutscene:choicer({"{hometown.text.when_can_we_see_your_brother_3296156765}", "{hometown.text.nothing_4481948392}"})
        if choice == 1 then
            cutscene:text("{hometown.text.font_sans_you_wanna_see_my_brother_wait_5_huh_3f37af0571}", "look_left", "sans")
            cutscene:text("{hometown.text.font_sans_hmm_ed0d813e52}", "eyes_closed", "sans")
            cutscene:text("{hometown.text.font_sans_yeah_you_can_see_him_4e76601a6a}", "neutral", "sans")
            cutscene:text("{hometown.text.font_sans_as_for_when_bd7ab658c3}", "look_left", "sans")
            cutscene:text("{hometown.text.font_sans_tomorrow_3af66493d9}", "wink", "sans")
            cutscene:text("{hometown.text.font_sans_give_or_take_three_years_061cba79ba}", "joking", "sans")
        else
            cutscene:text("{hometown.text.font_sans_seeya_a4625f21e3}", "wink", "sans")
        end

    end,

    noellegate = function(cutscene, event)
        cutscene:text("{hometown.text.it_s_an_ornate_gate_wait_5_it_appears_to_be_lock_6744b49639}")
    end,
}
