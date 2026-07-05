local ChaserEnemy, super = HookSystem.hookScript(ChaserEnemy) 

function ChaserEnemy:chaseMovement()
    super.chaseMovement(self)
    if self.actor.id == "dusteer" then  
    local absolute_scale = math.abs(self.scale_x)
    if self.world.player.x < self.x then
        self.scale_x = absolute_scale
    else
        self.scale_x = -absolute_scale
    end
end 
end

return ChaserEnemy

