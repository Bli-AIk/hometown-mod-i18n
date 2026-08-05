local sirengeist, super = Class(Encounter)

function sirengeist:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* A freezing draft carries Sirengeist into the arena!"

    self.music = "snowstorm"
    -- Enables the purple grid battle background
    self.background = true
    self:addEnemy("sirengeist")
end

return sirengeist
