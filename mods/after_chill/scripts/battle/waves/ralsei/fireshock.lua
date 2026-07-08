local Aiming, super = Class(Wave)

function Aiming:onStart()
    -- Every 0.5 seconds...
    self.time = 20
    self.aim = false

    self.timer:every(2.5, function()
        ice = self:spawnBullet("fireshock", x, y, angle, 0)
        ice:setScale(20)
    end)
end

function Aiming:update()
    -- Code here gets called every frame
    super.update(self)
end

function Aiming:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setAnimation("battle/idle", nil, true)
	end
end

return Aiming