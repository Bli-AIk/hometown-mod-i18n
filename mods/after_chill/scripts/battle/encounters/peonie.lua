local peonie, super = Class(Encounter)

function peonie:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* A flower bouquet floats into the path!"

    -- Battle music ("battle" is rude buster)
    self.music = "snowstorm"
    -- Enables the purple grid battle background
    self.background = true 

    -- Add the dummy enemy to the encounter
    self:addEnemy("peonie")
    self:addEnemy("peonie")
    self:addEnemy("peonie")
end

function peonie:onStateChange(old, new, reason) 
   if old == "INTRO" and new == "ACTIONSELECT" then
    self.bg = SnowflakeBG()
    Game.battle:addChild(self.bg)
   elseif new == "TRANSITIONOUT" then 
    self.bg:remove()
   end 
    super.onStateChange(self, old, new, reason)
end 


return peonie
