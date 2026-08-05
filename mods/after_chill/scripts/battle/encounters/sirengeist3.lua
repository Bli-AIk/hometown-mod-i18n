local sirengeist3, super = Class(Encounter)

function sirengeist3:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Wailing ghosts block the path!"

    self.music = "snowstorm"
    -- Enables the purple grid battle background
    self.background = true
    self:addEnemy("sirengeist")
    self:addEnemy("sirengeist")
    self:addEnemy("sirengeist")
end


return sirengeist3
