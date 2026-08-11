return {
    ---@param cutscene WorldCutscene
    door = function(cutscene, event, player)
        cutscene:text("{hometown.text.it_s_locked_827a359a7f}")
        if Game:hasPartyMember("noelle") then
            cutscene:text("{hometown.text.wait_5_why_are_we_trying_to_open_my_parents_room_ba71f33bbf}", "what_smile_b", "noelle")
        end
    end,

    dess_blocker = function(cutscene, event, player)
        cutscene:text("{hometown.text.umm_wait_5_sorry_wait_5_guests_aren_t_allowed_in_8c7eb81e2d}", "smile_side", "noelle")
        cutscene:text("{hometown.text.especially_after_what_happened_last_time_654d827adb}", "what_smile", "noelle")
    end,
	
    noelle_computer = function(cutscene, event, player)
        local name = Game.world.player.actor.name
		local wallpaper =  {"Noelle's family in the snow.",
							"Noelle's family looking festive.",
							"Noelle's family edited to be elves.",
							"a motion-blurred photo of a human child.",
							"Dess holding a cracked baseball bat.",
							"a picture of a far-off, snowy city.",
							"Noelle and Dess at the pageant as kids.",
							"some green dog puppet thing."}
		cutscene:text("{hometown.text.it_s_noelle_s_computer_the_cycling_wallpaper_is_a2d8bdc212}")
		if name == "Kris" then
			wallpaper[4] = "a motion-blurred photo of you as a kid."
		end
		cutscene:text("{hometown.text.wait_5_d34772a3d9}"..Utils.pick(wallpaper)..")")
    end,
	
    noelle_plant = function(cutscene, event, player)
        local name = Game.world.player.actor.name
		if name == "Kris" then
			cutscene:text("{hometown.text.it_s_a_christmas_cactus_you_remember_it_s_named__7584ba1533}")
		else
			cutscene:text("{hometown.text.it_s_a_christmas_cactus_you_don_t_know_the_name__f9fe7f569f}")
		end
    end,
	
    noelle_closet = function(cutscene, event, player)
        local name = Game.world.player.actor.name
        if name == "Kris" then
			cutscene:text("{hometown.text.a_great_hiding_place_wait_5_although_it_smells_l_00b97d467d}")
		else
			cutscene:text("{hometown.text.a_clothes_wardrobe_a_pair_of_small_angel_wings_a_c5eebc17fe}")
		end
    end,
	
    dess_box = function(cutscene, event, player)
        local name = Game.world.player.actor.name
        cutscene:text("{hometown.text.it_s_a_box_of_odds_and_ends_dig_through_59956c7ad7}")
		local choice = cutscene:choicer({"{hometown.text.dig_through_51c667534e}", "{hometown.text.don_t_dig_through_2b78c9051b}"})
        if choice == 1 then
			cutscene:text("{hometown.text.you_dug_through_the_box_and_found_cba3354b18}")
			cutscene:text("{hometown.text.a_couple_of_burnt_lighters_wait_5_rusted_multito_7293735c85}")
			cutscene:text("{hometown.text.walkie_talkies_wait_5_loose_binoculars_wait_5_a__beb1f0afcf}")
			cutscene:text("{hometown.text.violent_comic_books_wait_5_paintballs_wait_5_a_c_7f39c90bad}")
			if name == "Kris" then			
				cutscene:text("{hometown.text.your_brother_s_retainer_wait_5_and_old_mint_cans_58091980ff}")
			else
				cutscene:text("{hometown.text.a_used_retainer_wait_5_and_old_mint_cans_with_un_4dbe71efcb}")
			end
		else
			cutscene:text("{hometown.text.there_s_a_lot_af88aa866a}")
		end
    end,
	
    dess_shelf = function(cutscene, event, player)
        local name = Game.world.player.actor.name
        if name == "Kris" then
			cutscene:text("{hometown.text.it_s_a_shelf_in_the_front_are_all_the_holiday_th_8ae747bec3}")
			cutscene:text("{hometown.text.wait_5_and_at_the_back_are_all_the_scary_games_y_101b962d43}")
		else
			cutscene:text("{hometown.text.it_s_a_shelf_packed_with_tons_of_games_and_movie_a1248a318b}")
		end
    end,
}
