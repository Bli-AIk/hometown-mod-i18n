local shadow, super = Class(EnemyBattler)

function shadow:init()
    super.init(self)
    self.name = "Shadow"
    self:setActor("enemy_shadow")
    self.disable_mercy = true 
    self.max_health = 2500
    self.health = 2500
    self.wave_index = 1
    self.tired_percentage = 0
    local ralsei = Game.battle:getPartyBattler("ralsei")
    ralsei:addFX(ColorMaskFX(COLORS.black)) 
    ralsei:addFX(OutlineFX(Game:getPartyMember("ralsei").color))
    local kris = Game:getPartyMember("kris")
    self.attack = kris:getStat("attack") - 2 
    self.defense = kris:getStat("defense") - 2
    self.money = 100
    self.spare_points = 0
    self.fx1 = self:addFX(ColorMaskFX(COLORS.black))
    self.fx2 = self:addFX(OutlineFX())

    self.waves = {
       "shadow/slash", 
       "shadow/defend_bash", 
       "shadow/swing_arena", 
       "shadow/sword_star"
    }
    self.dialogue = {} 
    self.check = "AT ??? DF ???\n* Your worst nightmare."

    self.text = {
        "* The cold has no affect on you.", 
        "* Your regret grows.", 
        "* The shadow shows no emotion.\n* Although it seems to be smiling.", 
    }
    self:registerAct("Plead")
end 

function shadow:getNextWaves()
    local wave = self.waves[self.wave_index]
    self.wave_index = self.wave_index + 1
    if self.wave_index > #self.waves then
        self.wave_index = 1
    end
    return { wave }
end

function shadow:onAct(battler, name)
    if name == "Plead" then 
        return "* You begged for mercy.[wait:10]\n* Nothing happened."
    elseif name == "Standard" then 
        return "* "..battler.chara:getName().." tried to reason.[wait:5]\n* Nothing happened."
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
    Game.battle:startCutscene(function(cutscene)
    if self.health <= (self.max_health * 0.65) then 
        Game.battle.battle_ui:endAttack()
             local kris = Game.battle.party[1]
             kris:setAnimation("battle/idle")
             Game.world.music:fade(0, 1)
             Game.battle.music:fade(0, 1)
             cutscene:wait(2)
             cutscene:setSpeaker("shadow")
             cutscene:text("* Kris...[wait:5] no matter how hard you try...")
             cutscene:text("* I'll always be here.")
             cutscene:text("* [shake:1][color:red]THEY[color:reset][shake:0] will always be here.")
             cutscene:wait(1)
             cutscene:text("* Your attempts are all futile.")
             cutscene:text("* So,[wait:2] why keep trying?")
             self:setAnimation("battle/attack", function()
                 self:resetSprite()
             end)
             local sx, sy = kris:getRelativePos(kris.width/2, kris.height/2, Game.battle)
             local bullet = Sprite("effects/attack/shard", sx, sy)
             Game.battle:addChild(bullet)
             bullet:setScale(2)
             bullet:setOrigin(0.5, 0.5)
             local snd = Assets.playSound("swoon", 0.5, 1.4)
             bullet:play(0.1, false, function()
             bullet:remove()
             end)
             cutscene:wait(0.4)
             kris:shake(4, 0, 0, 0.2)
             kris:setSprite("fell")
             kris:statusMessage("msg", "swoon")
             kris.chara:setHealth(-999)
             cutscene:wait(1.6)
             kris:stopShake()
             cutscene:wait(0.4)
             cutscene:text("* Everything about you is pathetic.")
             cutscene:text("* Heh.[wait:5] Suffer in everything you've done.[wait:5]")
             cutscene:after(function()
             Game:setFlag("shadow_v", true)
             Game.battle:setState("TRANSITIONOUT")
             end)
        end 
    end)
end 

return shadow
