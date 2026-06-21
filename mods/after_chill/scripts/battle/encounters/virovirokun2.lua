local virovirokun2, super = Class(Encounter)

function virovirokun2:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Virovirokun blocks the way!"

    self.music = "snowstorm"
    -- Enables the purple grid battle background
    self.background = true
    self:addEnemy("virovirokun")
    self:addEnemy("virovirokun")
end

function virovirokun2:onStateChange(old, new, reason) 
   if old == "INTRO" and new == "ACTIONSELECT" then
    self.bg = SnowflakeBG()
    Game.battle:addChild(self.bg)
   elseif new == "TRANSITIONOUT" then 
    self.bg:remove()
   end 
    super.onStateChange(self, old, new, reason)
end 


return virovirokun2
