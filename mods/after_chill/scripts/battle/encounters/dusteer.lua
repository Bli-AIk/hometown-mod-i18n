local dusteer, super = Class(Encounter)

function dusteer:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Reinfrost and their friends block your way!"

    self.music = "snowstorm"
    -- Enables the purple grid battle background
    self.background = true
    self:addEnemy("dusteer")
    self:addEnemy("dusteer")
end

return dusteer
