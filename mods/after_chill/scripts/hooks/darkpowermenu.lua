local DarkpowerMenu, super = HookSystem.hookScript(DarkPowerMenu)

function DarkPowerMenu:getSpells()
    local spells = {}
    local party = self.party:getSelected()
    if party:hasAct() then
        table.insert(spells, Registry.createSpell("_act"))
    end
    if Game:getFlag("geno") then 
        table.insert(spells, Registry.createSpell("_rupture"))
    end 
    for _,spell in ipairs(party:getSpells()) do
        table.insert(spells, spell)
    end
    return spells
end

return DarkPowerMenu
