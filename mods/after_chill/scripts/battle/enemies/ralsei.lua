local ralsei, super = Class(EnemyBattler)

function ralsei:init()
    super.init(self)

    self.name = "Ralsei"
    self:setActor("enemy_ralsei")

    self.max_health = 280
    self.health = 280
    self.attack = 15
    self.ui_modified = false
    self.defense = 12
    self.money = 63
    self.dmg_sprite_offset = {-14, 13}
    self.tired_percentage = 0
    self.mercy = 100  
    self.spare_points = 20 

    self.waves = {
        "ralsei/fire_spin", 
        "ralsei/manual_throw", 
        "ralsei/star_bomb"
    }

    self.dialogue_offset = {-60, 5}
    self.dialogue = {}
    TableUtils.merge(self.actor.animations, {
        ["hurt"] = {"battle/hurt", 0.1, false}
    }, false)

    self.check = "AT "..self.attack.." DF "..self.defense.."\n* The dark prince, seemingly lost in his own dark."

    self.text = {
        "* Fire emanates from the floor.",
        "* Smells like burnt friendship.",
        "* You shiver a little,[wait:2] even though it isn't cold.",
    }
    self:registerAct("Apologize")
    -- self:registerAct("???", "...")
    -- self.acts[3].color = {COLORS.red}
end

function ralsei:onDefeat()
   if self:getFlag("dead") then 
        Game.battle:startCutscene(function(cutscene)
            Game.battle.battle_ui:endAttack()
            self.exit_on_defeat = false 
            self:setSprite("battle_alt/hurt_1")
            self:setPosition(533, 284)
            Game.battle.music:fade(0, 2)
            cutscene:wait(2)
            cutscene:text("* K-[wait:2]K-[wait:2]Kris...?", "concern_smile", "ralsei")
            cutscene:text("* Why...[wait:2] why would you..[wait:2]", "down", "ralsei")
            self:shake(2)
            Assets.playSound("damage")
            Assets.playSound("levelup")
            self:onDefeatFatal()
            self.x = self.x + 50 
            self.scale_x = -2 
        end)
   end 
end       

function ralsei:onAct(battler, name)
    if name == "Apologize" then
        local ap = self.apologize or 0 
        if not self:getFlag("dead") then 
            return {
            "* You apologized to Ralsei.",
            "* Nothing happened."
        }
        end 
        if ap == 0 then  
        self.apologize = ap + 1 
        return {
            "* You apologized to Ralsei.",
            "* Nothing happened."
        }
    elseif ap == 1 then 
        self.apologize = ap + 1 
        return { 
            "* You apologized about starting a battle with him.", 
            "* Ralsei looks at you.", 
            "* (Nothing seems to happen...)[wait:5]\n* (Try apologizing again!)"
        }
    elseif ap == 2 then 
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* Kris sincerely apologized to\nRalsei.")
            Game.battle.music:fade(0, 0.5)
            cutscene:wait(0.5)
            Assets.playSound("mercyadd")
            self:mercyFlash()
            cutscene:text("* Kris tried to spare Ralsei.")
            cutscene:wait(0.5)
            Game:getPartyMember("ralsei"):setFlag("serious", false)
            self:setAnimation("idle")
            cutscene:text("* K[wait:2]-Kris?\n* You are...[wait:5] sparing me...?", "blush", "ralsei")
            self:addMercy(100)
            cutscene:text("* W[wait:2]-well,[wait:2] that was unexpected...", "blush_pleased_open", "ralsei")
            cutscene:after(function()
                Game.battle.tired_bar:slideTo(-300, Game.battle.tired_bar.y, 1)
                Game.battle:setState("VICTORY")
            end)
        end) 
    end 

elseif name == "WakeUp" then 
    Game.battle.tired_bar:addTired(-8)
    Assets.playSound("bell_bounce_short")
    return "* Kris rubbed their eyes and gripped their sword tighter![wait:5]\n* [color:blue]TIREDNESS[color:reset] reduced!"

    elseif name == "???" then 
        Game.battle:startActCutscene(function(cutscene)
            Game.battle.music:play("d")
            self.exit_on_defeat = false 
            Game.battle.music:setVolume(0)
            Game.battle.music:fade(1, 0.5)
            cutscene:wait(1)
            battler:setAnimation("battle/idle")
            Assets.playSound("break1", 0.6, 0.8)
            battler:shake(3, 0)
            cutscene:wait(25/30)      
            Assets.playSound("boost")
            local fx = battler:addFX(ColorMaskFX(COLORS.white))
            Game.battle.timer:tween(0.5, fx, {amount = 0})
            for i = 1, 2 do 
                battler:addFX(OutlineFX(COLORS.maroon), "fx"..i.."") 
            end 
            battler:setAnimation("battle/attack_ready")
            cutscene:wait(15/30)
            local ralsei = Game.battle:getEnemyBattler("ralsei")
            cutscene:battlerText(ralsei, "Kris,[wait:5] what\nare you doing?")
            cutscene:battlerText(ralsei, "Your..[wait:5] eyes...")
            cutscene:battlerText(ralsei, "I-[wait:2]I...")
            battler:setAnimation("battle/attack")
            Assets.playSound("scytheburst")
            local sprite = Sprite("effects/attack/cut", 476, 200)
            Game.battle:addChild(sprite)
            sprite:setScale(2)
            cutscene:wait(0.1)
            sprite:play(0.1, false, function() sprite:remove() ralsei:hurt(math.ceil(battler.chara:getStat("attack") * 14 - ralsei.defense), battler, nil, COLORS.red) end)
            cutscene:wait(0.2)
            ralsei:resetSprite()
            battler:removeFX("fx1")
            battler:removeFX("fx2")
            battler:resetSprite()
            Assets.playSound("levelup")
            Game.battle.music:fade(0, 2)
            cutscene:wait(2)
            cutscene:battlerText(ralsei, "(I-I'm still alive..?)")
            cutscene:battlerText(ralsei, "(...Better go,[wait:2]\nbefore...[wait:2])")
            Assets.playSound("wing")
            ralsei:resetSprite()
            ralsei.y = 285 -- 271
            ralsei:setSprite("walk/left_1")
            cutscene:wait(0.2)
            ralsei:setSprite("walk/left")
            ralsei.sprite:play(0.25, true)
            ralsei:slideTo(700, ralsei.y, 2)
            cutscene:wait(2)
            ralsei.visible = false
            Game:setFlag("encounter#ralsei:violenced", true) 
            cutscene:after(function()
                Game:setFlag("geno", true)
                Game.battle:setState("TRANSITIONOUT")
            end)
            end)
    end
    return super.onAct(self, battler, name)
end

function ralsei:onHurt(damage, battler)
    for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
            child.x = child.x - 22
            child.y = child.y + 20 
        end 
    end 
    if self.health <= (self.max_health * 0.4) and Game:getFlag("enemies_killed", 0) >= 10 then 
        self:registerAct("???", "...")
        self.acts[3].color = {COLORS.red}
    end
    super.onHurt(self, damage, battler)
    self:getActiveSprite():stopShake()
    if not Game.battle:hasCutscene() then
    if self.mercy == 100 then 
        self.mercy = 0 
        self.disable_mercy = true 
        Game.battle.battle_ui:endAttack()
        Game.battle:startCutscene(function(cutscene)
            Game.battle.music:fade(0, 2)
            cutscene:wait(2)
            self:setFlag("dead", true)
            cutscene:battlerText("ralsei", "Y-[wait:2]you were\nreally serious..?")
            cutscene:battlerText("ralsei", "Kris,[wait:2] we can't divert\nfrom the prophecy!")
            cutscene:wait(2)
            cutscene:battlerText("ralsei", "If stopping you is\nthe only way to\nsave the prophecy..")
            cutscene:battlerText("ralsei", "Then so be it!")
            local snd = Assets.playSound("boost")
            local fx = self:addFX(ColorMaskFX(COLORS.white))
            fx.amount = 0 
            Game:getPartyMember("ralsei"):setFlag("serious", true)
            self:setAnimation("attack")
            Game.battle.music:fade(1, 1)
            Game.battle.timer:tween(0.4, fx, {amount = 1})
            cutscene:wait(0.4)
            Game.battle.timer:tween(0.4, fx, {amount = 0})
            cutscene:wait(0.5)
            self:setAnimation("spell")
            self:healEffect()
            Assets.playSound("spell_cure_slight_smaller")
            Game.battle.battle_ui.action_boxes[1].buttons[4].disabled=true
            cutscene:wait(0.7)
            self:setHardMode()
            cutscene:after(function()
                battler:resetSprite()
                Game.battle:setState("DEFENDINGBEGIN", {"ralsei/fireshock"})
            end)
        end)
    end 
end 
end 

function ralsei:setHardMode()
    self.waves = {}
    self.check = "AT "..self.attack.." DF 12\n* Standing in your way. \n* FIGHT him to his demise."
    self.health = self.max_health
    self.defense = self.defense + 5 
    self.kaboom = true 
    local tired = TiredBar(-200, -200)
    Game.battle:addChild(tired)
    Game.battle.tired_bar = tired
    Game.battle.tired_bar:setPosition(Game.battle.tired_bar.x, 6)
    Game.battle.tired_bar:slideTo(70, 6, 0.6)
    self:registerAct("WakeUp", "Reduce\nTired", {}, 8)
end 

function ralsei:getEncounterText()
    if self.kaboom then 
        self.kaboom = nil
        return "* Ralsei's defense went up.[wait:5]\n* Ralsei can heal himself.[wait:5]\n* Ralsei will attempt to induce [color:blue]tired[color:reset]."
    else 
        return super.getEncounterText(self)
    end  
end 
      

function ralsei:onAdd(parent)
    self:setAnimation("battle/intro")
end 

return ralsei
