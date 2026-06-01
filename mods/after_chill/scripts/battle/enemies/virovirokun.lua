local Virovirokun, super = Class(EnemyBattler)

function Virovirokun:init()
    super.init(self)

    self.name = "Virovirokun"
    self:setActor("virovirokun")

    self.max_health = 1000
    self.health = 1000
    self.attack = 10
    self.defense = -25
    self.money = 25

    self.spare_points = 0
    self.tired_percentage = 0

    self.waves = {
        "virovirokun/needle",
        "virovirokun/invader"
    }

    self.check = "AT II DEF -V\nThis virus is sentient b"

    self.text = {
        "* Virovirokun is sweating\nsuspiciously.",
        "* Virovirokun uses a text\ndocument as a tissue.",
        "* Virovirokun is poking round\nthings with a spear.",
        "* Virovirokun is beeping a\ncriminal tune."
    }

    self.low_health_text = "* Virovirokun looks extra sick."

    self:registerAct("TakeCare")

    -- Custom Kristal act, made for testing

    self.text_override = nil
end


function Virovirokun:onAct(battler, name)
    if name == "TakeCare" then
        self:addMercy(50)
        return "* You took care of the sick virus!"
    end 
    return super.onAct(self, battler, name)
end

return Virovirokun