local item, super = Class(HealItem, "pocket_pie")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Pocket Pie"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heal\nHalf Of\nMax HP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A pie that can make anyone feel half-full!\nCan fit in your pocket somehow."

    -- Amount healed (HealItem variable)
    self.heal_amount = 80
    -- Default shop price (sell price is halved)
    self.price = 100
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    self.reactions = {  
        susie = "Too many vegetables...",
        ralsei = "Ouch, it burnt my tongue!", 
        noelle = "How does this fit into a pocket?"
    }

end

function item:onBattleUse(user, target)
    if #target > 1 then 
    for _, battler in ipairs(target) do
        local hp = 0
        if battler.chara then
            hp = battler.chara:getStat("health", 0, false)
        else
            hp = 0 
        end
        local individual_heal = math.floor(hp / 2)
        battler:heal(individual_heal)
    end 
        self.heal_amount = 0
        return true 
    else 
        local hp = target.chara:getStat("health", 0, false)
        local individual_heal = math.floor(hp / 2)
        self.heal_amount = individual_heal
        return super.onBattleUse(self, user, target)
    end 
end


return item