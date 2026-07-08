local Aiming, super = Class(Wave)

function Aiming:onStart()
    -- Every 0.5 seconds...
    Game.battle.arena:setFire(true, true)
    self.time = 20
    self.aim = false

    self.timer:everyInstant(0.35, function()
        ice = self:spawnBullet("fireshock", x, y, angle, 0)
        ice:setScale(10)
    end)
end
function Aiming:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
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