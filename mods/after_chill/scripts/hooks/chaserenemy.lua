local ChaserEnemy, super = HookSystem.hookScript(ChaserEnemy) 

function ChaserEnemy:chaseMovement()
    super.chaseMovement(self)
    local absolute_scale = math.abs(self.scale_x)
    if self.world.player.x < self.x then
        self.scale_x = absolute_scale
    else
        self.scale_x = -absolute_scale
    end
end

return ChaserEnemy

