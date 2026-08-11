return {
    ---@param cutscene WorldCutscene
    door = function(cutscene, event, player)
        cutscene:text("{hometown.door.locked}")
        if Game:hasPartyMember("noelle") then
            cutscene:text("{hometown.door.why_trying_open_parents_room}", "what_smile_b", "noelle")
        end
    end,

    dess_blocker = function(cutscene, event, player)
        cutscene:text("{hometown.dess_blocker.umm_sorry_guests_arent_allowed}", "smile_side", "noelle")
        cutscene:text("{hometown.dess_blocker.especially_after_what_happened_last}", "what_smile", "noelle")
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
		cutscene:text("{hometown.noelle_computer.noelles_computer_cycling_wallpaper}")
		if name == "Kris" then
			wallpaper[4] = "a motion-blurred photo of you as a kid."
		end
		cutscene:text("{hometown.noelle_computer.text}"..Utils.pick(wallpaper)..")")
    end,
	
    noelle_plant = function(cutscene, event, player)
        local name = Game.world.player.actor.name
		if name == "Kris" then
			cutscene:text("{hometown.noelle_plant.christmas_cactus_remember_named_krismas}")
		else
			cutscene:text("{hometown.noelle_plant.christmas_cactus_dont_know_name}")
		end
    end,
	
    noelle_closet = function(cutscene, event, player)
        local name = Game.world.player.actor.name
        if name == "Kris" then
			cutscene:text("{hometown.noelle_closet.great_hiding_place_although_smells}")
		else
			cutscene:text("{hometown.noelle_closet.clothes_wardrobe_pair_small_angel}")
		end
    end,
	
    dess_box = function(cutscene, event, player)
        local name = Game.world.player.actor.name
        cutscene:text("{hometown.dess_box.box_odds_ends_dig_through}")
		local choice = cutscene:choicer({"{hometown.dess_box.dig_through}", "{hometown.dess_box.dont_dig_through}"})
        if choice == 1 then
			cutscene:text("{hometown.dess_box.dug_through_box_found}")
			cutscene:text("{hometown.dess_box.couple_burnt_lighters_rusted_multitool}")
			cutscene:text("{hometown.dess_box.walkie_talkies_loose_binoculars_pair}")
			cutscene:text("{hometown.dess_box.violent_comic_books_paintballs_cracked}")
			if name == "Kris" then			
				cutscene:text("{hometown.dess_box.brothers_retainer_old_mint_cans}")
			else
				cutscene:text("{hometown.dess_box.used_retainer_old_mint_cans}")
			end
		else
			cutscene:text("{hometown.dess_box.lot}")
		end
    end,
	
    dess_shelf = function(cutscene, event, player)
        local name = Game.world.player.actor.name
        if name == "Kris" then
			cutscene:text("{hometown.dess_shelf.shelf_front_all_holiday_themed}")
			cutscene:text("{hometown.dess_shelf.back_all_scary_games_never}")
		else
			cutscene:text("{hometown.dess_shelf.shelf_packed_tons_games_movies}")
		end
    end,
}
