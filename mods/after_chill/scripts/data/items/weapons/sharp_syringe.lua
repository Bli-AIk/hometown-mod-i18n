-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(Item, "sharp_syringe")

function item:init()
    super.init(self)

    -- Display name
    self.name = "SharpSyringe"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = "Hit\nTwice"
    -- Shop description
    self.shop = "Hits\nTwice"
    -- Menu description
    self.description = "Syringe that seems to be sharpened. \nAllows two attacks that are faster."

    -- Amount healed (HealItem variable)
    self.heal_amount = 0

    -- Default shop price (sell price is halved)
    self.price = 350
    -- Whether the item can be sold
    self.can_sell = true

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 5
    }
    
    -- Bolting it.
    self.bolt_count = 2
    self.bolt_speed = 10

    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Venom"
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Kris!?",
        ralsei = "Ow! I poked myself!",
        noelle = "Can I graze on this?",
    }
end


return item
