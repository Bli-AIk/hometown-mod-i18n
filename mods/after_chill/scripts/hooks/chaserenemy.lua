local ChaserEnemy, super = HookSystem.hookScript(ChaserEnemy) 

function ChaserEnemy:onEncounterStart(primary, encounter) -- idk why this is here but if u'd like to do stuff 
    super.onEncounterStart(self, primary, encounter)   
end 

function ChaserEnemy:onAlerted()
    if self.actor.id == "dummy" then -- replace "dummy" with what ur actor was 
    local music = Music("archangel") -- replace this with whatever. 
    -- Kristal.Console:warn(ten) 
    -- music:play() (this isnt needed iirc but its here for Reasons.)
    end 
    super.onAlerted(self)
end 
local step_timer = 0  

function ChaserEnemy:chaseMovement()
    super.chaseMovement(self)
    if self.actor.id == "dummy" then  -- here as well
    local player = Game.world.player
    step_timer = step_timer + DT
    local last_step = 1
    if step_timer >= 0.25 then
        Assets.playSound("step" .. last_step)
        if last_step == 1 then last_step = 2 else last_step = 1 end    
        step_timer = 0
    end
    local dx = player.x - self.x
    local dy = player.y - self.y
    if math.abs(dx) > math.abs(dy) then
        if dx > 0 then self:setAnimation("walk/right") else self:setAnimation("walk/left") end
    else
        if dy > 0 then self:setAnimation("walk/down") else self:setAnimation("walk/up") end
    end
end 
end

return ChaserEnemy

