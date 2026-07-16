local dusteer1, super = Class(Encounter)

function dusteer1:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Reinfrost enters the arena,[wait:5]\ntracking snow behind them!"

    self.music = "snowstorm"
    -- Enables the purple grid battle background
    self.background = true
    self:addEnemy("dusteer")
end

function dusteer1:onStateChange(old, new, reason) 
   if old == "INTRO" and new == "ACTIONSELECT" then
    self.bg = SnowflakeBG()
    Game.battle:addChild(self.bg)
   elseif new == "TRANSITIONOUT" then 
    self.bg:remove()
   end 
    super.onStateChange(self, old, new, reason)
end 


return dusteer1
