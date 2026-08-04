-- This spell is only used for display in the POWER menu.

local spell, super = Class(Spell, "_rupture")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Rupture"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = ""
    -- Menu description
    self.description = "Powerful attack, gains more power the more kills the wielder has. Bonus DMG when enemy is TIRED."
    -- TP cost
    self.cost = 10

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"blade", "fatal"}
end

function spell:getTPCost(...) 
    local kills = Game:getFlag("enemies_killed", 0)
    if kills >= 10 then
        local scaling_kills = kills - 5
        local dynamic_tp = MathUtils.clamp(MathUtils.roundFromZero((scaling_kills * 1.5)), 10, 50)
        return dynamic_tp 
    end 
    return super.getTPCost(self, ...)
end 

return spell