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

function sirengeist3:onStateChange(old, new, reason) 
    if old == "INTRO" and new == "ACTIONSELECT" then
    self.bg = SnowflakeBG()
    Game.battle:addChild(self.bg)
    elseif new == "TRANSITIONOUT" then 
    self.bg:remove()
    end 
    super.onStateChange(self, old, new, reason)
end 


return sirengeist3
