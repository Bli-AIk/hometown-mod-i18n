local sirengeist2, super = Class(Encounter)

function sirengeist2:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The wind seems to be howling with a ghostly presence."

    self.music = "snowstorm"
    -- Enables the purple grid battle background
    self.background = true
    self:addEnemy("sirengeist")
    self:addEnemy("sirengeist")
end


return sirengeist2
