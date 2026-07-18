-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(Item, "cross_bow")

function item:init()
    super.init(self)

    -- Display name
    self.name = "CrossBow"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Cool\nBow"
    -- Menu description
    self.description = "A cute bow that Susie would refuse to wear.\nIs shaped like a cross."

    -- Amount healed (HealItem variable)
    self.heal_amount = 0

    -- Default shop price (sell price is halved)
    self.price = 350
    -- Whether the item can be sold
    self.can_sell = true

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        defense = 5
    }

    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = false 
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Never in hell!",
        ralsei = "It fits perfectly on my scarf!",
        noelle = "Reminds me of blood donation places.",
    }
end


return item
