local sirengeist, super = Class(EnemyBattler)

function sirengeist:init()
    super.init(self)

    self.name = "Sirengeist"
    self:setActor("sirengeist")

    self.max_health = 70
    self.health = 70
    self.attack = 9
    self.defense = 9999
    self.money = 78

    self.spare_points = 20
    self.tired_percentage = 25

    self.dialogue = {
        "Code Green!", 
        "Aren't I loud?", 
        "You look quite blue."
    }

    self.waves = {
        "sirengeist/cross_throw", 
        "sirengeist/crossrain"
    }

    self.check = {
        "AT 9 DEF ?\n* A silly ghost with a blaring alert.[wait:5]\n* The sound seems to be from afar.", 
        "This ghost can only be hit through [color:yellow]MAGIC[color:reset]."
    } 
    self.wave_index = 1 
    self.experience = 20 

    self.text = {
        "* Sirengeist floats along with the wind.",
        "* Aren't sirens meant to be attractive?",
        "* You can hear whispers.\n* They seem loud in your ears."
    }
    self:registerAct("Mute", "Get\nMercy")
    self:registerAct("MuteX", "Full\nMercy", {"ralsei"}, 8)
    self:registerAct("TryMagic", "Learn\nMagic", {}, 16)
end

function sirengeist:getNextWaves()
    local wave = self.waves[self.wave_index]
    self.wave_index = self.wave_index + 1
    if self.wave_index > #self.waves then
        self.wave_index = 1
    end
    return { wave }
end

function sirengeist:getCheckText(battler)
    if self:canSpare() then 
    local base_text = "AT 9 DEF ?\n* A ghost with a blaring alert on its head."
    return base_text .. "\n* It seems to be completely silent now."
    else 
    return super.getCheckText(self, battler)
    end 
end 

function sirengeist:onAct(battler, name)
    if name == "TryMagic" then
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* Kris tried to channel their magic and attack into a \"spell\"!")
            cutscene:wait(1)
            battler:setAnimation("battle/attack_ready")
            local snd = Assets.playSound("boost")
            local fx = battler:addFX(ColorMaskFX(COLORS.white, 0))
            Game.battle.timer:tween(0.4, fx, {amount = 1}, "linear", function()
            Game.battle.timer:tween(0.4, fx, {amount = 0})
            end)
            cutscene:wait(0.8)
            cutscene:text("* Kris learnt a new \"spell\"\ntemporarily!")
            battler:resetSprite()
            for _, enemy in ipairs(Game.battle:getActiveEnemies()) do 
                enemy:removeAct("TryMagic")
                enemy:registerAct("SwordButt", "Attack\nGhost", {}, 8)
            end 
            -- self:removeAct("TryMagic")
            -- self:registerAct("SwordButt", "Attack\nGhost", {}, 8)
        end)
    elseif name == "SwordButt" then
        Game.battle:startActCutscene(function(cutscene)
            local return_text = "* The enemy was slightly hurt...[wait:5]\n* The pain made them giggle?"
            battler:setAnimation("swing", function() 
                Assets.playSound("scytheburst")
                battler:resetSprite() 
                local dmg = (battler.chara:getStat("attack")/1.5) * 5
                self:hurt(MathUtils.round(dmg), battler, function() 
                    return_text = "* The enemy ran away in fright..."
                    Game:addFlag("enemies_killed", 1)
                    self:onDefeatRun()
                end) 
            end)
            cutscene:wait(1) 
            cutscene:text(return_text)
        end)
    elseif name == "Mute" then
        self:addMercy(60)
        self:flash()
        return {
            "* Kris tried to get the enemy to be quiet!", 
            "* The enemy's alert flashed and went even louder!" 
        }
    elseif name == "MuteX" then 
    Game.battle:startActCutscene(function(cutscene)
        cutscene:text("* You and Ralsei tried to get the enemy to be quiet.")
        cutscene:text("* Hey,[wait:2] I know you like blaring...", "pleased", "ralsei")
        cutscene:text("* But could you please tone\nit down?", "stressed", "ralsei")
        cutscene:wait(0.5)
        cutscene:text("* The enemy couldn't hear Ralsei\nover the noise.")
        self:addMercy(100)
        cutscene:text("* The enemy laughed at Ralsei![react:ralsei]", {reactions ={
            ralsei = {"H-Hey! It's not\nmy fault!", "right", "mid", "owo_angry", "ralsei"}
        }})
    end)
    elseif name == "Standard" then  
        if battler.chara.id == "ralsei" then 
            Game.battle:startActCutscene(function(cutscene)
                cutscene:text("* Ralsei told a joke to the enemy.")
                cutscene:text("* You really shouldn't be [color:yellow]alarmed[color:reset]![wait:10]\n* We're very friendly!", "blush_pleased", "ralsei")
                self:addMercy(25)
                cutscene:text("* The enemy didn't get the joke...[wait:5]\n* But they giggled nevertheless!")
                self.dialogue_override = "Code Red!\nBad Joke!"
            end)
        end 
    end   
    return super.onAct(self, battler, name)
end 

return sirengeist