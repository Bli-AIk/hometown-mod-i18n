return function(cutscene)

    local kris = cutscene:getCharacter("kris_lw")
    local susie = cutscene:getCharacter("susie_lw")
    local noelle = cutscene:getCharacter("noelle_lw")

    local solo = kris and not susie and not noelle and not cutscene:getCharacter("ralsei")

    local duo_s = kris and susie and not noelle and not cutscene:getCharacter("ralsei")
    local duo_n = kris and noelle and not susie and not cutscene:getCharacter("ralsei")

    local transition = nil

    if solo then
        cutscene:detachCamera()
        cutscene:detachFollowers()

        cutscene:slideTo(kris,  620, 280, 0.25)
        cutscene:panTo(620, 245, 0.25)
        cutscene:wait(0.25)

        kris.visible = false

        transition = darktransitionplus(320, {["kris_only"] = solo})

        transition.loading_callback = function() 
            Game.world:loadMap("dark/castletown/area_1")
            if Game.world.music then
                Game.world.music:stop()
            end
            for _,party in ipairs(Game.party) do
                local char = Game.world:getCharacter(party.id)
                char.visible = false
            end
        end

        local waiting = true
        local endData = nil

        transition.end_callback = function(transition, data)
            waiting = false
            endData = data
        end

        transition.layer = 99999

        Game.world:addChild(transition)

        cutscene:wait(function() return not waiting end)

        if not Game:hasPartyMember("ralsei") then
            Game:addPartyMember("ralsei")
        end

        for _, character in ipairs(endData) do
            local char = Game.world:getPartyCharacterInParty(character.party)
            local kx, ky = character.sprite_1:localToScreenPos(character.sprite_1.width / 2, 0)
            char:setScreenPos(kx, transition.final_y)
            char.visible = true
            char:setFacing("down")
        end

        cutscene:interpolateFollowers()

        cutscene:attachCamera()
        cutscene:attachFollowers()
    elseif duo_s then
        cutscene:detachCamera()
        cutscene:detachFollowers()

        cutscene:slideTo(kris,  620 - 30, 280, 0.25)
        cutscene:slideTo(susie, 620 + 30, 280, 0.25)
        cutscene:panTo(620, 245, 0.25)
        cutscene:wait(0.25)

        kris.visible = false
        susie.visible = false

        transition = darktransitionplus(320)

        transition.loading_callback = function() 
            Game.world:loadMap("dark/castletown/area_1")
            if Game.world.music then
                Game.world.music:stop()
            end
            for _,party in ipairs(Game.party) do
                local char = Game.world:getCharacter(party.id)
                char.visible = false
            end
        end

        local waiting = true
        local endData = nil

        transition.end_callback = function(transition, data)
            waiting = false
            endData = data
        end

        transition.layer = 99999

        Game.world:addChild(transition)

        cutscene:wait(function() return not waiting end)

        if not Game:hasPartyMember("ralsei") then
            Game:addPartyMember("ralsei")
        end

        for _, character in ipairs(endData) do
            local char = Game.world:getPartyCharacterInParty(character.party)
            local kx, ky = character.sprite_1:localToScreenPos(character.sprite_1.width / 2, 0)
            char:setScreenPos(kx, transition.final_y)
            char.visible = true
            char:setFacing("down")
        end

        cutscene:interpolateFollowers()

        cutscene:attachCamera()
        cutscene:attachFollowers()
    elseif duo_n then
        cutscene:detachCamera()
        cutscene:detachFollowers()

        cutscene:slideTo(kris,  620 - 30, 280, 0.25)
        cutscene:slideTo(noelle, 620 + 30, 280, 0.25)
        cutscene:panTo(620, 245, 0.25)
        cutscene:wait(0.25)

        kris.visible = false
        noelle.visible = false

        transition = darktransitionplus(320)

        transition.loading_callback = function() 
            Game.world:loadMap("dark/castletown/area_1")
            if Game.world.music then
                Game.world.music:stop()
            end
            for _,party in ipairs(Game.party) do
                local char = Game.world:getCharacter(party.id)
                char.visible = false
            end
        end

        local waiting = true
        local endData = nil

        transition.end_callback = function(transition, data)
            waiting = false
            endData = data
        end

        transition.layer = 99999

        Game.world:addChild(transition)

        cutscene:wait(function() return not waiting end)

        if not Game:hasPartyMember("ralsei") then
            Game:addPartyMember("ralsei")
        end

        for _, character in ipairs(endData) do
            local char = Game.world:getPartyCharacterInParty(character.party)
            local kx, ky = character.sprite_1:localToScreenPos(character.sprite_1.width / 2, 0)
            char:setScreenPos(kx, transition.final_y)
            char.visible = true
            char:setFacing("down")
        end

        cutscene:interpolateFollowers()

        cutscene:attachCamera()
        cutscene:attachFollowers()
    else
        cutscene:text("{hometown.text.you_can_t_enter_yet_a4e382127c}")
    end
end