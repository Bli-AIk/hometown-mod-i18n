local star_bomb, super = Class(Wave)

function star_bomb:init()
    super.init(self)
    self.time = 11
    self.bullet_table = {}
end

function star_bomb:onStart()
    self.timer:everyInstant(2, function()
    self:spawnBomb()
    end)
end 

function star_bomb:spawnBomb()
    local ralsei = Game.battle:getEnemyBattler("ralsei")
    if ralsei then ralsei:setAnimation("spell") end
    Assets.playSound("stardrop")
    
    local arena = Game.battle.arena
    local side = love.math.random(1, 4)
    local tx, ty

    if side == 1 then     -- Top
        tx, ty = love.math.random(arena.left, arena.right), arena.top - 20
    elseif side == 2 then -- Bottom
        tx, ty = love.math.random(arena.left, arena.right), arena.bottom + 20
    elseif side == 3 then -- Left
        tx, ty = arena.left - 20, love.math.random(arena.top, arena.bottom)
    else                  -- Right
        tx, ty = arena.right + 20, love.math.random(arena.top, arena.bottom)
    end
    
    local bullet = self:spawnBullet("star_bomb_bullet", 501, 202, tx, ty, side)
    bullet:setupMovement(tx, ty)
    
    table.insert(self.bullet_table, bullet)
end

function star_bomb:onEnd()
    for _, bullet in ipairs(self.bullet_table) do
        if bullet and bullet.parent then
            bullet:remove()
        end
    end
    self.bullet_table = {}
    super.onEnd(self)
end

return star_bomb
