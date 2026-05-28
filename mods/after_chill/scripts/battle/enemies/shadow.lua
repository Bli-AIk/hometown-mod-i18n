local shadow, super = Class(EnemyBattler)

function shadow:init()
    super.init(self)

    self.name = "Shadow"
    self:setActor("enemy_shadow")

    self.max_health = 2500
    self.health = 2500
    self.tired_percentage = 0
    local kris = Game.battle:getPartyBattler("kris")
    self.attack = kris.chara:getStat("attack")
    self.defense = kris.chara:getStat("defense")
    self.money = 100
    self.spare_points = 0
    self:addFX(ColorMaskFX(COLORS.black))
    self:addFX(OutlineFX())

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
        return "* You begged for mercy.\n* Nothing happened."
    end
    return super.onAct(self, battler, name)
end

function shadow:onAdd(parent)
    if parent == Game.battle then 
        self:setAnimation("battle/transition")
    end 
    super.onAdd(self, parent)
end 

return shadow
