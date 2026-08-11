return {
    ---@param cutscene WorldCutscene
    organ = function(cutscene, event, player)
        cutscene:text("{hometown.organ.giant_organ}")
    end,

    door = function(cutscene, event, player)
        cutscene:text("{hometown.door.door_large_person_could_fit}")
        local choice = cutscene:choicer({"{hometown.door.turn_doorknob}", "Do not"})
        if choice == 1 then
            cutscene:text("{hometown.door.turned_doorknob}")
            cutscene:text("{hometown.music_player.text}")
            if Game.party[1].id == "kris" then
                cutscene:text("{hometown.door.didnt_anything_else}")
            else
                cutscene:text("{hometown.door.opening_must_locked}")
            end
        end
    end,

    candles = function(cutscene, event, player)
        cutscene:text("{hometown.candles.altar_full_hope_candles_each}")
    end,

    fire_extinguisher = function(cutscene, event, player)
        if cutscene:getCharacter("susie_lw") then
            cutscene:text("{hometown.fire_extinguisher.fire_extinguisher_some_reason_feeling}")
            cutscene:text("{hometown.fire_extinguisher.susie_will_say_something_stupid}", nil, nil, {reactions={{"{hometown.fire_extinguisher.should_make_one_shoots_whip}", "mid", "bottom", "smile", "susie"}}})
        else
            cutscene:text("{hometown.fire_extinguisher.fire_extinguisher}")
        end
    end,

    holy_water = function(cutscene, event)
        cutscene:text("{hometown.holy_water.bowl_blessed_water_motion_sensor}")
        cutscene:text("{hometown.holy_water.clear_what_happens_if_touch}")
    end,

    entrance_bookshelf = function(cutscene, event)
        cutscene:text("{hometown.entrance_bookshelf.bookshelf_full_hymnals_scripture}")
        cutscene:text("{hometown.entrance_bookshelf.some_copies_lord_hammer}")
    end,

    pitcher = function(cutscene, event)
        cutscene:text("{hometown.pitcher.large_pitcher_water}")
        cutscene:text("{hometown.pitcher.cups_stored_below}")
    end,

    drinks = function(cutscene, event)
        cutscene:text("{hometown.drinks.juice_wafer_like_crackers}")
    end,

    cupboard = function(cutscene, event)
        cutscene:text("{hometown.smoke.documents}")
    end,

    office_bookshelf = function(cutscene, event)
        cutscene:text("{hometown.office_bookshelf.books_many_copies_lord_hammer}")
    end,

    plaque = function(cutscene, event)
        cutscene:text("{hometown.plaque.plaque_bearing_words_famous_writer}")
        cutscene:text("{hometown.plaque.hope_comes_who_believe_cannot}")
        cutscene:text("{hometown.plaque.may_hope_shine_brightly}")
        cutscene:text("{hometown.plaque.may_keep_shelter_dark}")
    end,

    hanging = function(cutscene, event)
        cutscene:text("{hometown.hanging.seems_some_sort_incense_container}")
    end,

    wardrobe = function(cutscene, event)
        cutscene:text("{hometown.wardrobe.wardrobe_full_choir_robes_even}")
    end,

    bells = function(cutscene, event)
        cutscene:text("{hometown.bells.set_bells_different_sizes}")
        local dowemess = cutscene:choicer({"{hometown.bells.mess}", "{hometown.bells.dont}"})
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
        cutscene:text("{hometown.piano.keyboard_settings_sound_like_either}")
    end,
}
