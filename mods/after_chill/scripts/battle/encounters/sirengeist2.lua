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

function sirengeist2:onStateChange(old, new, reason) 
    if old == "INTRO" and new == "ACTIONSELECT" then
    self.bg = SnowflakeBG()
    Game.battle:addChild(self.bg)
    elseif new == "TRANSITIONOUT" then 
    self.bg:remove()
    end 
    super.onStateChange(self, old, new, reason)
end 


return sirengeist2
