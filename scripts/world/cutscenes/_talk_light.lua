return function(cutscene)
    local susie = cutscene:getCharacter("susie")
    local noelle = cutscene:getCharacter("noelle")
    local ceroba = cutscene:getCharacter("ceroba")
    if Game.world.map.id == "light/hometown/town_school" then
        if ceroba then
            cutscene:text("{hometown.talk_light.why_only_one_parking_place}", "unsure", ceroba)
            cutscene:text("{hometown.talk_light.only_one_car_town}", "unsure_alt", ceroba)
            if noelle then
                cutscene:text("{hometown.talk_light.oh_actually_because}", "smile", noelle)
                cutscene:text("* ...", "confused", noelle)
                cutscene:text("* ...", "frown", noelle)
                cutscene:text("* ...", "confused_surprise_b", noelle)
                cutscene:text("{hometown.talk_light.actually_dont_know}", "what_smile", noelle)
            end
        else
            cutscene:text("{hometown.talk_light.voice_echoes_aimlessly}")
        end
    elseif Game.world.map.id == "light/hometown/school/school_lobby" then
        if ceroba then
            cutscene:text("{hometown.talk_light.school_huh}", "alt", ceroba)
            cutscene:text("{hometown.talk_light.hopefully_wont_get_trouble_here}", "nervous_smile", ceroba)
            cutscene:text("{hometown.talk_light.especially_since_know}", "confounded", ceroba)
            cutscene:text("{hometown.talk_light.child_nor_teacher_walking_around}", "nervous_smile", ceroba)
        else
            cutscene:text("{hometown.talk_light.voice_echoes_aimlessly}")
        end
    elseif Game.world.map.id == "light/hometown/school/kris_class" then
        if ceroba then
            cutscene:text("{hometown.talk_light.generic_classroom}", "alt", ceroba)
            cutscene:text("{hometown.talk_light.personally_wouldnt_say_anything_talk}", "neutral", ceroba)
        else
            cutscene:text("{hometown.talk_light.voice_echoes_aimlessly}")
        end
    elseif Game.world.map.id == "light/hometown/school/toriel_class" then
        if ceroba then
            if not Game.world.map.ceroba_talk then
                cutscene:text("{hometown.talk_light.must_class_low_graders_right}", "neutral", ceroba)
                cutscene:text("* ...", "alt", ceroba)
                cutscene:text("{hometown.talk_light.wait_ms_toriel}", "surprised", ceroba)
                cutscene:text("{hometown.talk_light.toriel_toriel_dreemurr}", "nervous", ceroba)
                cutscene:text("{hometown.talk_light.probably_coincidence}", "dissapproving", ceroba)
                Game.world.map.ceroba_talk = 1
            else
                cutscene:text("* ...", "alt", ceroba)
                cutscene:text("{hometown.talk_light.kanako_would_love_here}", "dissapproving", ceroba)
            end
        else
            cutscene:text("{hometown.talk_light.voice_echoes_aimlessly}")
        end
    elseif Game.world.map.id == "light/hometown/school/school_door" then
        if ceroba then
            cutscene:text("{hometown.talk_light.another_school_corridor}", "alt", ceroba)
            cutscene:text("{hometown.talk_light.nothing_havent_seen}", "closed_eyes", ceroba)
        else
            cutscene:text("{hometown.talk_light.voice_echoes_aimlessly}")
        end
    elseif Game.world.map.id == "light/hometown/school/unused_class" then
        if ceroba then
            cutscene:text("{hometown.talk_light.classroom_quite_empty}", "unsure", ceroba)
            cutscene:text("{hometown.talk_light.must_unused_then}", "closed_eyes", ceroba)
        else
            cutscene:text("{hometown.talk_light.voice_echoes_aimlessly}")
        end
    else
        cutscene:text("{hometown.talk_light.voice_echoes_aimlessly}")
    end
end