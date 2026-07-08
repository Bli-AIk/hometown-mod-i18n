-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "honey_drop")

function item:init()
    super.init(self)

    -- Display name
    self.name = "HoneyDrop"
    -- Name displayed when used in battle (optional)
    self.use_name = "HoneyDrop"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\n120HP"
    -- Shop description
    self.shop = "Perfection"
    -- Menu description
    self.description = "Looks like a giant block of caramel.\nYou feel the urge to lick it. +120HP."

    -- Amount healed (HealItem variable)
    self.heal_amount = 160

    -- Default shop price (sell price is halved)
    self.price = 90
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

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Hell yeah, caramel!!!",
        ralsei = "It melted in my mouth!",
        noelle = "Too much sugar...",
    }
end

return item
