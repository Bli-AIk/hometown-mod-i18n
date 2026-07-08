return {
    ---@param cutscene WorldCutscene
    sell = function(cutscene, event)
        local function checkMoney()
            if Game.money >= 140 then 
                Game.money = Game.money - 140
                return true 
            else 
                return false 
            end 
        end  
        if Game:hasPartyMember("ralsei") then 
            cutscene:text("* Hey,[wait:5] kids!")
            cutscene:text("* I don't know where I am,[wait:5]\nbut you want some candy?")
            cutscene:text("* Oh,[wait:5] sure!", "blush_pleased", "ralsei")
            local choice = cutscene:choicer({"Buy", "Sell", "Who are you?", "Go Back"})
            if choice == 1 then 
                cutscene:text("* Glad you decided to take a look at my wares!")
                cutscene:wait(0.2)
                local sec = cutscene:textChoicer("* [color:yellow]HoneyDrop[color:reset] costs [color:yellow]$140[color:reset].", {"Buy", "Go Back"})
                if sec == 1 then 
                    if checkMoney() then 
                        Assets.playSound("item")
                        local success, text = Game.inventory:tryGiveItem("honey_drop")
                        cutscene:text(text)
                        if success then
                            cutscene:text("* Thank you,[wait:5] miss!", "blush", "ralsei")
                            cutscene:text("* You're always welcome,[wait:2] sweet.")
                        end
                    else 
                        cutscene:text("* Sweet,[wait:5] you don't have enough money.")
                        cutscene:text("* Remember,[wait:5] it costs [color:yellow]$140[color:reset].")
                        cutscene:wait(0.5)
                        cutscene:text("* I don't make exceptions for any of my customers,[wait:5] sorry!")
                    end
                else 
                    cutscene:text("* Oh,[wait:2] you don't want candy?")
                    cutscene:text("* Smart choice!")
                end 
            elseif choice == 2 then 
                cutscene:text("* Sorry,[wait:2] sweet,[wait:2] but I don't need anything!")
            elseif choice == 3 then 
                cutscene:text("* I'm the receptionist at the hospital.")
                cutscene:text("* It's very boring over there,[wait:5] everyone's so rude and needy.")
                cutscene:text("* I don't know this place,[wait:5] but I really love the serenity!")
            elseif choice == 4 then
                cutscene:text("* Take care, both of ya.")
            end
        else 
            cutscene:text("* Hey there!")
            cutscene:text("* You're the first person I've met.")
            cutscene:text("* Would you like to look at my wares?") 
            local choice = cutscene:choicer({"Buy", "Sell", "Who are you?", "Go Back"})
            if choice == 1 then 
                cutscene:text("* Glad you decided to take a look at my wares!")
                cutscene:wait(0.2)
                local sec = cutscene:textChoicer("* [color:yellow]HoneyDrop[color:reset] costs [color:yellow]$140[color:reset].", {"Buy", "Go Back"})
                if sec == 1 then 
                    if checkMoney() then 
                        Assets.playSound("item")
                        local success, text = Game.inventory:tryGiveItem("honey_drop")
                        cutscene:text(text)
                        if success then
                            cutscene:text("* You're always welcome,[wait:2] sweet.")
                        end
                    else 
                        cutscene:text("* Sweet,[wait:5] you don't have enough money.")
                        cutscene:text("* Remember,[wait:5] it costs [color:yellow]$140[color:reset].")
                        cutscene:wait(0.5)
                        cutscene:text("* I don't make exceptions for any of my customers,[wait:5] sorry!")
                    end 
                else 
                    cutscene:text("* Oh,[wait:2] you don't want candy?")
                    cutscene:text("* Smart choice!")
                end 
            elseif choice == 2 then 
                cutscene:text("* Sorry,[wait:2] sweet,[wait:2] but I don't need anything from ya!")
            elseif choice == 3 then 
                cutscene:text("* I'm the receptionist at the hospital.")
                cutscene:text("* It's very boring over there,[wait:5] everyone's so rude and needy.")
                cutscene:text("* I don't know this place,[wait:5] but I really love the serenity!")
                cutscene:wait(0.5)
                cutscene:text("* Oh,[wait:2] don't worry sweet,[wait:2] you're good with me too.")
            elseif choice == 4 then
                cutscene:text("* Take care!")
            end 
        end
    end
}
