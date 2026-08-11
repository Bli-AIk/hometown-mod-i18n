return {
    ---@param cutscene WorldCutscene

    hospitalpiano = function(cutscene, event)
        cutscene:text("{hometown.hospital_piano.obligatory_hospital_piano_shrunk_fit}")
        cutscene:text("{hometown.hospital_piano.result_missing_most_good_keys}")
        cutscene:text("{hometown.hospital_piano.play}")
        local opinion = cutscene:choicer({"{yes}", "{no}"})
            if opinion == 1 then
                Assets.playSound("pianonoise")
                cutscene:text("{hometown.hospital_piano.plink}")
            else
                cutscene:text("{hometown.hospital_piano.hands_linger_over_keys_doing}")
            end
    end,

    pre_knight_corner = function (cutscene, event)
        local susie = cutscene:getCharacter("susie")
        if Game:getFlag("knight_corner", false) then
            if cutscene:getCharacter(susie) then
                cutscene:text("{hometown.smoke.door}")
                cutscene:text("{hometown.pre_knight_corner.uh_mayors_office}", "sus_nervous", "susie")
                cutscene:text("{hometown.pre_knight_corner.if_got_would_big_trouble}", "nervous_side", "susie")
                cutscene:text("{hometown.pre_knight_corner.like_care_lets_go}", "teeth_smile", "susie")
            end
        end
    end,

    hospitaltoy = function(cutscene, event)

        cutscene:text("{hometown.hospitaltoy.toy_beads_track}")
        if Game:getFlag("POST_SNOWGRAVE") then
            cutscene:text("{hometown.hospitaltoy.one_blue_beads_broken_torn}")
        else
            cutscene:text("{hometown.hospitaltoy.beads_toy_march}")
        end
        
    end,

    asgorefridge = function(cutscene, event)
        cutscene:text("{hometown.asgore_fridge.rusty_fridge_some_photos}")
        local opinion = cutscene:choicer({"{hometown.asgore_fridge.open_fridge}", "{hometown.bells.dont}", "{hometown.asgore_fridge.see_photos}"})
        if opinion == 1 then
          cutscene:text("{hometown.asgore_fridge.all_inside_jar_single_pickle}")
        elseif opinion == 3 then
          cutscene:text("{hometown.asgore_fridge.photo_mother_father_their_wedding}")
          cutscene:text("{hometown.asgore_fridge.shes_holding_bouquet_seven_flowers}")
          cutscene:text("{hometown.asgore_fridge.reindeer_looking_monster_stands_nearby}")
          cutscene:text("{hometown.asgore_fridge.all_look_happy}")
        else
          cutscene:text("{hometown.asgore_fridge.decide_look}")
        end
    end,

    asgoretruck = function(cutscene, event)
        cutscene:text("{hometown.asgoretruck.dads_truck}")
        cutscene:text("{hometown.asgoretruck.floor_front_seat_littered_old}")
    end,

    librarybook1 = function(cutscene, event)

      cutscene:text("{hometown.library_book_1.how_care_human}")
      cutscene:text("{hometown.library_book_1.book_monsters_how_care_humans}")
      local opinion = cutscene:choicer({"{hometown.library_book_1.look_back}", "{hometown.library_book_1.look_inside}"})
        if opinion == 1 then
          cutscene:text("{hometown.library_book_1.according_card_back}")
          cutscene:text("{hometown.library_book_1.looks_like_mother_took_repeatedly}")
        else
            cutscene:text("{hometown.library_book_1.photos_unfamiliar_humans_inside}")
            local leader_id = GeneralUtils:getLeader().id
            if leader_id == "kris" then
                cutscene:text("{hometown.library_book_1.shut_book_quickly}")
            end
        end

    end,

    librarybook2 = function(cutscene, event)

      cutscene:text("{hometown.library_book_2.book_1_souls_read}")
      local opinion = cutscene:choicer({"{hometown.library_book_2.read}", "{hometown.bells.dont}"})
        if opinion == 1 then
          cutscene:text("{hometown.library_book_2.soul_called_many_things}")
          cutscene:text("{hometown.library_book_2.font_compassion_source_will}")
          cutscene:text("{hometown.library_book_2.container_life_force}")
          cutscene:text("{hometown.library_book_2.even_now_true_function_unknown}")
        end

    end,

    papyrushouse = function(cutscene, event)

      Assets.playSound("knock")
      cutscene:text("{hometown.papyrushouse.knock_knock_knock}")
      cutscene:text("{hometown.music_player.text}")
      cutscene:text("{hometown.papyrushouse.response_even_distant_trousle_bones}")

    end,

    sansplin = function(cutscene, event)

      Assets.playSound("bell")

    end,

    iceesoda = function(cutscene, event)

      cutscene:text("{hometown.icee_soda.soda_dispensing_machine}")
      local opinion = cutscene:choicer({"{hometown.icee_soda.inspect}", "{hometown.icee_soda.not}"})
        if opinion == 1 then
          cutscene:text("{hometown.icee_soda.took_look_flavors}")
          cutscene:text("{hometown.icee_soda.water}")
          cutscene:text("* ICE")
          cutscene:text("{hometown.icee_soda.double_ice}")
          cutscene:text("{hometown.icee_soda.bread}")
          cutscene:text("{hometown.icee_soda.flamin_hot_cheese_soda}")
          cutscene:text("{hometown.icee_soda.gamer_blood_energy_drink}")
          cutscene:text("{hometown.icee_soda.juice_red_flavor}")
        end

    end,
	
    toilet = function(cutscene, event)
        cutscene:text("{hometown.toilet.toilet_flush}")
        local choice = cutscene:choicer({"{yes}", "{no}"})
        if choice == 1 then
            Game.world.music:fade(0,0.001)
            Assets.playSound("toilet")
			
            cutscene:wait(1)
			
            Assets.playSound("won")
            cutscene:text("{hometown.toilet.flushed_toilet}")
            Game.world.music:fade(1,1)
        end
    end,
	
    asriel_bed = function(cutscene, event)
        cutscene:text("{hometown.asriel_bed.cds_under_bed_classical_jazz}")
        cutscene:text("{hometown.asriel_bed.also_game_console_one_normal}")
    end,

    torcar = function(cutscene, event)
        if Game.party[1].id == "kris" then
            cutscene:text("{hometown.toriel_car.moms_car}")
            cutscene:text("{hometown.toriel_car.seems_like_hasnt_replaced_tires}")
        else
            cutscene:text("{hometown.toriel_car.red_car_can_hold_up}")
            cutscene:text("{hometown.toriel_car.tires_car_appear_slashed}")
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
                cutscene:text("{hometown.rudy.well_if_isnt_dear_noelle}", "happier", "rudy")
                if susie then
                    cutscene:text("{hometown.rudy.see_youve_brought}", "smile", "rudy")
                    local notreally = "friend"
                    local susieline = "???"
                    if kris then
                        notreally = "friends"
                        susieline = "{hometown.rudy.kris}"
                    end
                    local greeting_id = notreally == "friend" and "hometown.rudy.friend_well" or "hometown.rudy.friends_well"
                    cutscene:text("{"..greeting_id.."}", "wink", "rudy", {reactions={
                        {"DAD!!!", "mid", "mid", "shock", "noelle"},
                        {susieline, "right", "bottom", "shy_b", "susie"}
                    }})
                end
                cutscene:text("{hometown.rudy.how_sweetheart}", "smile_side", "rudy")
                cutscene:text("{hometown.rudy.much_lately_having_fun_friends}", "smile_closed", "noelle")
                cutscene:text("{hometown.rudy.ah_great_great}", "happy", "rudy")
            elseif susie then
                if kris then
                    cutscene:text("{hometown.rudy.susie_kris_isnt_wonderful_see}", "happier", "rudy")
                    cutscene:text("{hometown.rudy.what_susie_needs_some_noelle}", "wink", "rudy")
                else
                    cutscene:text("{hometown.rudy.susie_isnt_wonderful_see}", "happier", "rudy")
                    cutscene:text("{hometown.rudy.what_need_some_noelle_advice}", "wink", "rudy")
                end
                cutscene:text("{hometown.rudy.wh}", "blush", "susie")
                cutscene:text("{hometown.rudy.heh_heh_whatever_say}", "smile", "rudy")
            elseif kris then
                cutscene:text("{hometown.rudy.hey_krismas_whats_up}", "happier", "rudy")
                if #Game.party == 1 then
                    cutscene:text("{hometown.rudy.wheres_friend_busy}", "neutral", "rudy")
                    cutscene:text("{hometown.rudy.now_dont_worry_sure_shell}", "neutral", "rudy")
                else
                    cutscene:text("{hometown.rudy.youve_got_some_new_friends}", "smile", "rudy")
                    cutscene:text("{hometown.rudy.well_meantime_kris_let_tell}", "neutral", "rudy")
                    cutscene:text("{hometown.rudy.noelle_susie_dont_forget_alright}", "upset", "rudy")
                    cutscene:text("{hometown.rudy.seem_happy_around}", "wink", "rudy")
                end
            else
                cutscene:text("{hometown.rudy.heh_heh}", "smile_side", "rudy")
                cutscene:text("{hometown.rudy.wow_gotta_first_time_visitors}", "happy", "rudy")
                cutscene:text("{hometown.rudy.whom_dont_even_know}", "happier", "rudy")
                Assets.playSound("rudylaugh")
                rudy:setAnimation("laugh")
                cutscene:wait(1.5)
                rudy:setSprite("d")
            end
            cutscene:text("{hometown.rudy.oh_wanted_chat_something}", "smile_side", "rudy")
            Game.world.map.rudy_greeting = true
        else
            cutscene:text("{hometown.rudy.want_chat}", "smile", "rudy")
        end
        local topic = cutscene:choicer({"{hometown.rudy.sickness}", "{hometown.rudy.leave}"})
        if topic == 1 then
            if noelle then
                cutscene:text("{hometown.rudy.dont_worry_sweetie_gonna_outta}", "smile", "rudy")
                cutscene:text("{hometown.rudy.need_bit_more_rest_all}", "smile_side", "rudy")
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
                    greeting_id = susie and "hometown.rudy.hey_kris_susie_dont_tell" or "hometown.rudy.hey_kris_dont_tell_noelle"
                elseif susie then
                    greeting_id = "hometown.rudy.hey_susie_dont_tell_noelle"
                else
                    greeting_id = "hometown.rudy.hey_dont_tell_noelle"
                end
                cutscene:text("{"..greeting_id.."}", "upset", "rudy")
                cutscene:text("{hometown.rudy.sure_if_gonna_out_here}", "serious", "rudy")
                cutscene:text("{hometown.rudy.coughings_getting_worse_recently}", "upset", "rudy")
                cutscene:text("{hometown.rudy.now_dont_worry_going_down}", "wink", "rudy")
                if kris or susie then
                    if Game:getFlag("rudy_promise") then
                        cutscene:text("{hometown.rudy.hey}", "happy", "rudy")
                        cutscene:text("{hometown.rudy.thanks_again_promise}", "happier", "rudy")
                        cutscene:text("{hometown.rudy.dont_worry_more_than_fine}", "wink", "rudy")
                    else
                        if kris then
                            if susie then
                                cutscene:text("{hometown.rudy.if_kris_kris_susie_if}", "serious", "rudy")
                            else
                                cutscene:text("{hometown.rudy.if_kris_kris_if_something}", "serious", "rudy")
                            end
                        elseif susie then
                            cutscene:text("{hometown.rudy.if_susie_susie_if_something}", "serious", "rudy")
                        end
                        cutscene:text("{hometown.rudy.promise_youll_take_good_care}", "smile_side", "rudy")
                        cutscene:text("{hometown.rudy.cant_left_all_alone_herself}", "neutral", "rudy")
                        cutscene:text("{hometown.rudy.much_ask}", "smile_side", "rudy")
                        if kris then
                            cutscene:choicer({"{hometown.rudy.promise_2}", "{hometown.rudy.promise_2}"})
                            if susie then
                                cutscene:text("{hometown.rudy.promise_3}", "shy_down", "susie")
                            end
                        elseif susie then
                            cutscene:text("{hometown.rudy.promise}", "shy_down", "susie")
                        end
                        cutscene:text("{hometown.rudy.h_heh_thank}", "smile_side", "rudy")
                        Assets.playSound("rudycough")
                        rudy:setAnimation("cough")
                        cutscene:wait(1.5)
                        rudy:setSprite("d")
                        Game:setFlag("rudy_promise", true)
                    end
                else
                    cutscene:text("{hometown.rudy.huh_what_diagnosed}", "serious", "rudy")
                    cutscene:text("{hometown.rudy.appreciate_concern}", "smile_side", "rudy")
                    cutscene:text("{hometown.rudy.like_anything_could_heh}", "happy", "rudy")
                end
            end
        else
            cutscene:text("{hometown.rudy.good_day}", "happy", "rudy")
        end
    end,

    hospitalroom2bed = function(cutscene, event)
        if Game:getFlag("POST_SNOWGRAVE") then
            cutscene:text("{hometown.hospitalroom2bed.hes_breathing_slowly}")
        else
            cutscene:text("{hometown.hospitalroom2bed.empty_bed}")
        end
    end,

    blook = function(cutscene, event) --placeholder dialogue lol
        local blook = cutscene:getCharacter("napstablook")
        blook:setFacing("right")
        cutscene:text("{hometown.blook.oh_hey}", nil)
        cutscene:text("{hometown.blook.if_looking_officer_undyne_shes}", nil)
        blook:setFacing("down")
    end,

    sans = function(cutscene, event)
        local susie = cutscene:getCharacter("susie_lw")
        cutscene:text("{hometown.sans.heya}", "neutral", "sans")
        cutscene:text("{hometown.sans.need_somethin}", "neutral", "sans")
        local choice = cutscene:choicer({"{hometown.sans.when_can_see_brother}", "{hometown.sans.nothing}"})
        if choice == 1 then
            cutscene:text("{hometown.sans.wanna_see_brother_huh}", "look_left", "sans")
            cutscene:text("{hometown.sans.hmm}", "eyes_closed", "sans")
            cutscene:text("{hometown.sans.yeah_can_see}", "neutral", "sans")
            cutscene:text("{hometown.sans.when}", "look_left", "sans")
            cutscene:text("{hometown.sans.tomorrow}", "wink", "sans")
            cutscene:text("{hometown.sans.give_take_three_years}", "joking", "sans")
        else
            cutscene:text("{hometown.sans.seeya}", "wink", "sans")
        end

    end,

    noellegate = function(cutscene, event)
        cutscene:text("{hometown.noellegate.ornate_gate_appears_locked}")
    end,
}
