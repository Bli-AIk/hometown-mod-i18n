-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(Item, "venom_syringe")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Venom Syringe"
    -- Name displayed when used in battle (optional)
    self.use_name = "ULTIMATE CANDY"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Best\nhealing"
    -- Shop description
    self.shop = "A venom filled shot"
    -- Menu description
    self.description = "A venom filled shot, you have to poke, then inject it into enemys"

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
    
    --bolts
    self.bolt_count = 2
    self.bolt_speed = 8
    self.multibolt_variance = {{80,160,40},{80,160,40}}

    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Venom"
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "because im SUSIE GASTER",
        ralsei = "I dont really like needles...",
        noelle = "Ah i poked myself",
    }
end


return item
