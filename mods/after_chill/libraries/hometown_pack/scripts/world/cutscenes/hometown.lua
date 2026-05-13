return {
    ---@param cutscene WorldCutscene

    hospitalpiano = function(cutscene, event)
        cutscene:text("* (It's an obligatory hospital piano,[wait:5] shrunk to fit in the corner.)")
        cutscene:text("* (As a result,[wait:5] it's missing most of the good keys.)")
        cutscene:text("* (Play it?)")
        local opinion = cutscene:choicer({"Yes", "No"})
            if opinion == 1 then
                Assets.playSound("pianonoise")
                cutscene:text("* (Plink...)")
            else
                cutscene:text("* (Your hands linger over the keys doing nothing.)")
            end
    end,

    pre_knight_corner = function (cutscene, event)
        local susie = cutscene:getCharacter("susie")
        if Game:getFlag("knight_corner", false) then
            if cutscene:getCharacter(susie) then
                cutscene:text("* (It's a door.)")
                cutscene:text("* That's the uh, mayor's office.", "sus_nervous", "susie")
                cutscene:text("* If we got in we would be in big trouble.", "nervous_side", "susie")
                cutscene:text("* Not like i care, let's go.", "teeth_smile", "susie")
            end
        end
    end,

    hospitaltoy = function(cutscene, event)

        cutscene:text("* (It's a toy with beads on a track.)")
        if Game:getFlag("POST_SNOWGRAVE") then
            cutscene:text("* (One of the blue beads is broken and torn off.)")
        else
            cutscene:text("* (The beads of the toy march on.)")
        end
        
    end,

    asgorefridge = function(cutscene, event)
        cutscene:text("* (It's a rusty fridge with some photos on it.)")
        local opinion = cutscene:choicer({"\nOpen\nFridge\n", "Don't", "See photos"})
        if opinion == 1 then
          cutscene:text("* (All that's inside is a jar with a single pickle in it...)")
        elseif opinion == 3 then
          cutscene:text("* (A photo of your mother and father on their wedding day.)")
          cutscene:text("* (She's holding a bouquet of seven flowers.)")
          cutscene:text("* (A reindeer-looking monster stands nearby in a tuxedo.)")
          cutscene:text("* (They all look happy.)")
        else
          cutscene:text("* (You decide not to look.)")  
        end
    end,

    asgoretruck = function(cutscene, event)
    	cutscene:text("* (It's your dad's truck.)")
        cutscene:text("* (The floor of the front seat is littered with old papers and country CDs...)")
    end,

    librarybook1 = function(cutscene, event)

      cutscene:text("* How To Care For A Human")
      cutscene:text("* (It's a book for monsters about how to care for humans.)")
      local opinion = cutscene:choicer({"Look in\nthe back", "Look inside"})
        if opinion == 1 then
          cutscene:text("* (According to the card in the back...)")
          cutscene:text("* (... looks like your mother took it repeatedly many years ago.)")
        else
            cutscene:text("* (There are photos of unfamiliar humans inside.)")
            cutscene:text("* (You shut the book quickly.)")
        end

    end,

    librarybook2 = function(cutscene, event)

      cutscene:text("* (It's BOOK 1 about SOULS. Read it?)")
      local opinion = cutscene:choicer({"Read", "Don't"})
        if opinion == 1 then
          cutscene:text("* The SOUL has been called many things.")
          cutscene:text("* The font of our compassion. The source of our will.")
          cutscene:text("* The container of our \"life force.\"")
          cutscene:text("* But even now,[wait:5] the true function of it is unknown.")
        end

    end,

    papyrushouse = function(cutscene, event)

      Assets.playSound("knock")
      cutscene:text("* (Knock knock knock...)")
      cutscene:text("* (...)")
      cutscene:text("* (No response...)\n[wait:5]* (... not even the distant trousle of bones.)")

    end,

    sansplin = function(cutscene, event)

      Assets.playSound("bell")

    end,

    iceesoda = function(cutscene, event)

      cutscene:text("* (It's a soda-dispensing machine.)")
      local opinion = cutscene:choicer({"Inspect", "Not"})
        if opinion == 1 then
          cutscene:text("* (You took a look at the flavors.)")
          cutscene:text("* WATER")
          cutscene:text("* ICE")
          cutscene:text("* DOUBLE-ICE")
          cutscene:text("* BREAD")
          cutscene:text("* FLAMIN HOT CHEESE SODA")
          cutscene:text("* GAMER BLOOD ENERGY DRINK")
          cutscene:text("* Juice (Red Flavor)")
        end

    end,
	
    toilet = function(cutscene, event)
        cutscene:text("* (It's a toilet.)[wait:5]\n* (Flush it?)")
        local choice = cutscene:choicer({"Yes", "No"})
        if choice == 1 then
            Game.world.music:fade(0,0.001)
            Assets.playSound("toilet")
			
            cutscene:wait(1)
			
            Assets.playSound("won")
            cutscene:text("* (You flushed the toilet!)")
            Game.world.music:fade(1,1)
        end
    end,
	
    asriel_bed = function(cutscene, event)
        cutscene:text("* There are CDs under the bed.\n[wait:5]* Classical,[wait:5] jazz,[wait:5] religious ska...")
        cutscene:text("* There's also a game console.\n[wait:5]* It has one normal controller,[wait:5] and one knock-off one.")
    end,

    torcar = function(cutscene, event)
        if Game.party[1].id == "kris" then
            cutscene:text("* (It's your mom's car.)")
            cutscene:text("* (Seems like she hasn't replaced the tires yet, judging by the slashes.)")
        else
            cutscene:text("* (A red car that can hold up to at least four people.)")
            cutscene:text("* (The tires on the car appear to be slashed.)")
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
                cutscene:text("* Well,[wait:5] if it isn't my dear Noelle!", "happier", "rudy")
                if susie then
                    cutscene:text("* I see you've brought...", "smile", "rudy")
                    local notreally = "friend"
                    local susieline = "???"
                    if kris then
                        notreally = "friends"
                        susieline = "???\nKris???"
                    end
                    cutscene:text("* Your \""..notreally.."\",[wait:5] as well![react:1][wait:5][react:2]", "wink", "rudy", {reactions={
                        {"DAD!!!", "mid", "mid", "shock", "noelle"},
                        {susieline, "right", "bottom", "shy_b", "susie"}
                    }})
                end
                cutscene:text("* How have you been,[wait:5] sweetheart?", "smile_side", "rudy")
                cutscene:text("* Not much...[wait:5] Lately I've just been having fun with my friends.", "smile_closed", "noelle")
                cutscene:text("* Ah,[wait:5] that's great,[wait:5] that's great.", "happy", "rudy")
            elseif susie then
                if kris then
                    cutscene:text("* Susie![wait:5] Kris![wait:5] Isn't it wonderful to see you two!", "happier", "rudy")
                    cutscene:text("* What is it?[wait:5] Susie needs me for some Noelle advice?", "wink", "rudy")
                else
                    cutscene:text("* Susie! Isn't it wonderful to see you!", "happier", "rudy")
                    cutscene:text("* What is it?[wait:5] Need me for some Noelle advice?", "wink", "rudy")
                end
                cutscene:text("* Wh-[wait:5] I-[wait:5][face:teeth_b] NO!!!", "blush", "susie")
                cutscene:text("* Heh,[wait:5] heh...[wait:10] Whatever you say.", "smile", "rudy")
            elseif kris then
                cutscene:text("* Hey Krismas![wait:5] What's up?", "happier", "rudy")
                if #Game.party == 1 then
                    cutscene:text("* Where's your friend?[wait:5] Is she busy?", "neutral", "rudy")
                    cutscene:text("* Now,[wait:5] don't worry.[wait:5] I'm sure she'll get some free time for you.", "neutral", "rudy")
                else
                    cutscene:text("* You've got some new friends I see.", "smile", "rudy")
                    cutscene:text("* Well,[wait:5] in the meantime...[wait:10] Kris,[wait:5] let me tell you something.", "neutral", "rudy")
                    cutscene:text("* Noelle,[wait:5] Susie...[wait:10] Don't forget about them,[wait:5] alright?", "upset", "rudy")
                    cutscene:text("* They seem to be happy around you.", "wink", "rudy")
                end
            else
                cutscene:text("* Heh,[wait:5] heh...", "smile_side", "rudy")
                cutscene:text("* Wow,[wait:5] this is gotta be the first time I have visitors...", "happy", "rudy")
                cutscene:text("* Whom I don't even know!", "happier", "rudy")
                Assets.playSound("rudylaugh")
                rudy:setAnimation("laugh")
                cutscene:wait(1.5)
                rudy:setSprite("d")
            end
            cutscene:text("* Oh,[wait:5] you wanted to chat about something?", "smile_side", "rudy")
            Game.world.map.rudy_greeting = true
        else
            cutscene:text("* Want to chat?", "smile", "rudy")
        end
        local topic = cutscene:choicer({"Sickness", "Leave"})
        if topic == 1 then
            if noelle then
                cutscene:text("* Don't worry sweetie,[wait:5] I'm gonna be outta here in no time.", "smile", "rudy")
                cutscene:text("* I just...[wait:10] Need a bit more rest,[wait:5] that's all.", "smile_side", "rudy")
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
                cutscene:text("* Hey"..names.."...[wait:10] Don't tell that to Noelle,[wait:5] but...", "upset", "rudy")
                cutscene:text("* I'm not sure if I'm gonna be out of here anytime soon.", "serious", "rudy")
                cutscene:text("* The coughing's been getting worse recently.", "upset", "rudy")
                cutscene:text("* Now,[wait:5] don't worry.[wait:5] I'm not going down yet.", "wink", "rudy")
                if kris or susie then
                    if Game:getFlag("rudy_promise") then
                        cutscene:text("* Hey...", "happy", "rudy")
                        cutscene:text("* Thanks again for that promise.", "happier", "rudy")
                        cutscene:text("* And don't worry about me,[wait:5] I'm more than fine for now.", "wink", "rudy")
                    else
                        if kris then
                            if susie then
                                cutscene:text("* But if...[wait:10] Kris...[wait:10] Kris,[wait:5] Susie,[wait:5] if something happens,[wait:5] then...", "serious", "rudy")
                            else
                                cutscene:text("* But if...[wait:10] Kris...[wait:10] Kris,[wait:5] if something happens,[wait:5] then...", "serious", "rudy")
                            end
                        elseif susie then
                            cutscene:text("* But if...[wait:10] Susie...[wait:10] Susie,[wait:5] if something happens,[wait:5] then...", "serious", "rudy")
                        end
                        cutscene:text("* Promise me you'll take good care of Noelle,[wait:5] alright?", "smile_side", "rudy")
                        cutscene:text("* She can't be left all alone by herself...", "neutral", "rudy")
                        cutscene:text("* Is that not too much to ask?", "smile_side", "rudy")
                        if kris then
                            cutscene:choicer({"Promise", "Promise"})
                            if susie then
                                cutscene:text("* We...[wait:10] We promise.", "shy_down", "susie")
                            end
                        elseif susie then
                            cutscene:text("* I...[wait:10] I promise.", "shy_down", "susie")
                        end
                        cutscene:text("* H...[wait:10] Heh,[wait:5] thank you.", "smile_side", "rudy")
                        Assets.playSound("rudycough")
                        rudy:setAnimation("cough")
                        cutscene:wait(1.5)
                        rudy:setSprite("d")
                        Game:setFlag("rudy_promise", true)
                    end
                else
                    cutscene:text("* Huh?[wait:5] What I'm diagnosed with?", "serious", "rudy")
                    cutscene:text("* I appreciate your concern,[wait:5] but...", "smile_side", "rudy")
                    cutscene:text("* It's not like there's anything you could do,[wait:5] heh.", "happy", "rudy")
                end
            end
        else
            cutscene:text("* Have a good day.", "happy", "rudy")
        end
    end,

    hospitalroom2bed = function(cutscene, event)
        if Game:getFlag("POST_SNOWGRAVE") then
            cutscene:text("* (He's breathing slowly.)")
        else
            cutscene:text("* (It's an empty bed.)")
        end
    end,

    blook = function(cutscene, event) --placeholder dialogue lol
        local blook = cutscene:getCharacter("napstablook")
        blook:setFacing("right")
        cutscene:text("* oh...[wait:5] hey...", nil)
        cutscene:text("* if you're looking for officer undyne... she's not here at the moment...", nil)
        blook:setFacing("down")
    end,

    sans = function(cutscene, event)
        local susie = cutscene:getCharacter("susie_lw")
        cutscene:text("[font:sans]* heya.", "neutral", "sans")
        cutscene:text("[font:sans]* you need somethin'?", "neutral", "sans")
        local choice = cutscene:choicer({"When can\nwe see your\nbrother?", "Nothing"})
        if choice == 1 then
            cutscene:text("[font:sans]* you wanna see my brother,[wait:5] huh?", "look_left", "sans")
            cutscene:text("[font:sans]* hmm...", "eyes_closed", "sans")
            cutscene:text("[font:sans]* yeah you can see him.", "neutral", "sans")
            cutscene:text("[font:sans]* as for when?", "look_left", "sans")
            cutscene:text("[font:sans]* tomorrow.", "wink", "sans")
            cutscene:text("[font:sans]* give or take three years.", "joking", "sans")
        else
            cutscene:text("[font:sans]* seeya.", "wink", "sans")
        end

    end,

    noellegate = function(cutscene, event)
        cutscene:text("* (It's an ornate gate.)\n[wait:5]* (It appears to be locked.)")
    end,
}
