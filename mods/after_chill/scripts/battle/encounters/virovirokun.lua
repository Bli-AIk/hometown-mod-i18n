local virovirokun, super = Class(Encounter)

function virovirokun:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Virovirokun blocks the way!"

    self.music = "snowstorm"
    -- Enables the purple grid battle background
    self.background = true
    -- local num = love.math.random(1, 3)
    -- for i = 1, num do 
    -- if num == 3 then 
    --     if i == 1 then 
    --         self:addEnemy("virovirokun", 504, 89)
    --     elseif i == 2 then  
    --         self:addEnemy("virovirokun", 504, 191)
    --     else 
    --         self:addEnemy("virovirokun", 504, 287)
    --     end 
    -- else 
    --     self:addEnemy("virovirokun")      
    -- end
    self:addEnemy("virovirokun")
end

function virovirokun:onStateChange(old, new, reason) 
   if old == "INTRO" and new == "ACTIONSELECT" then
    self.bg = SnowflakeBG()
    Game.battle:addChild(self.bg)
   elseif new == "TRANSITIONOUT" then 
    self.bg:remove()
   end 
    super.onStateChange(self, old, new, reason)
end 


return virovirokun
