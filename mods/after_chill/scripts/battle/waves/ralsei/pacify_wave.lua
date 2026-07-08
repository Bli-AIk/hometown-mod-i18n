local pacify_wave, super = Class(Wave)

function pacify_wave:init()
    super.init(self)
    self.time = 11.5
    self.pacify = {}
end
function pacify_wave:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
end

function pacify_wave:onStart()
    Game.battle.arena:setFire(true, true)
    local ralsei = self:getAttackers()[1]
    self.timer:everyInstant(1.5, function()
        ralsei:setAnimation("spell", function()
        Assets.playSound("spell_pacify") 
        local cx, cy = SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2
        if ralsei then
            cx, cy = ralsei:getRelativePos(ralsei.width / 2 - 20, ralsei.height / 2 - 10)
        end
        self.timer:script(function(wait)
            for i = 1, love.math.random(4, 7) do
                local z_bullet = self:spawnBullet("pacify_z_bullet", cx, cy)
                table.insert(self.pacify, z_bullet)
                wait(0.08) 
            end
        end)
    end)
end)
end

return pacify_wave
