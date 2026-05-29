local shadow, super = Class(EnemyBattler)

function shadow:init()
    super.init(self)

    self.name = "Shadow"
    self:setActor("enemy_shadow")
    self.disable_mercy = true 
    self.max_health = 2500
    self.health = 2500
    self.tired_percentage = 0
    local kris = Game.battle:getPartyBattler("kris")
    self.attack = kris.chara:getStat("attack") - 2 
    self.defense = kris.chara:getStat("defense") - 2
    self.money = 100
    self.spare_points = 0
    self.fx1 = self:addFX(ColorMaskFX(COLORS.black))
    self.fx2 = self:addFX(OutlineFX())

    self.waves = {}
    self.dialogue = {} 
    self.check = "AT ??? DF ???\n* Your worst nightmare."

    self.text = {
        "* The cold has no affect on you.", 
        "* Your regret grows.", 
        "* The shadow shows no emotion.\n* Although it seems to be smiling.", 
    }
    self:registerAct("Plead")
end 

function shadow:onAct(battler, name)
    if name == "Plead" then 
        return "* You begged for mercy.[wait:10]\n* Nothing happened."
    end
    return super.onAct(self, battler, name)
end

function shadow:onAdd(parent)
    if parent == Game.battle then 
        self:setAnimation("battle/transition")
    end 
    super.onAdd(self, parent)
end 

function shadow:onHurt(damage, battler)
    super.onHurt(self, damage, battler)
    if self.health <= (self.max_health * 0.98) then 
        Game.battle.battle_ui:endAttack()
        Game.battle:startCutscene(function(cutscene)
            local kris = Game.battle.party[1]
            kris:setAnimation("battle/idle")
            cutscene:wait(1.3)
            cutscene:setSpeaker("shadow")
            Game.world.music:fade(0, 0.5)
            cutscene:wait(0.5)
            cutscene:text("* Wow,[wait:5] putting up quite the fight,[wait:5] aren't you?")
            cutscene:text("* After all, killing me won't do [shake:1]anything[shake:0].")
            Assets.playSound("suslaugh")
            cutscene:wait(1)
            cutscene:text("* Kris.[wait:10][noskip][speed:0.7]\n* Your actions don't matter.[wait:5]\n* They're all futile.")
            Assets.playSound("ui_spooky_action", 1, 1.7)
            Game.battle.timer:tween(0.5, self, {scale_y = 0})
            cutscene:wait(0.7)
            self:setActor("shadow")
            self:removeFX(self.fx1)
            self:removeFX(self.fx2)
            self:setAnimation("ball")
            self.alpha = 0 
            local sfx = Assets.playSound("appear")
            self:fadeTo(1, sfx:getDuration())
            self:setScale(1)
            cutscene:wait(sfx:getDuration())
          --  self:jumpTo(700, 200)
        end)
    end 
end 

return shadow
