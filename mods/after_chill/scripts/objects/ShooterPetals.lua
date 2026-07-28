---@class ShooterPetals : Object
local ShooterPetals, super = Class(Object)

function ShooterPetals:init(x, y, data)
    super.init(self, x, y, data.width, data.height, data)
    self.stem = Sprite("enemies/shooters/stem")
    self.stem:setOrigin(0.5, 1.0)
    self.stem:setScale(2)
    self:addChild(self.stem)
    
    self.sprite = Sprite("enemies/shooters/idle")
    self.sprite:setOrigin(0.6, 1.0)
    self.sprite:setScale(2)
    self.sprite:play(0.25, true)
    self:addChild(self.sprite)
    
    self.bleh = false
    self.sprite.y = -self.stem.height - 24
    self.shoot_timer = nil 
    local flower_amount = data.properties["flowers"]
end

function ShooterPetals:update()
    super.update(self)
    if Game.world.in_battle_area and not self.bleh then 
        self.bleh = true 
        self.shoot_timer = Game.stage.timer:after(0.3, function() 
            self:startShootLoop() 
        end)
    elseif not Game.world.in_battle_area and self.bleh then
        self.bleh = false
        if self.shoot_timer then
            Game.stage.timer:cancel(self.shoot_timer)
            self.shoot_timer = nil
        end
        self.sprite:setSprite("enemies/shooters/idle")
        self.sprite:play(0.25, true)
    end 
end

function ShooterPetals:startShootLoop()
    if not self.stage or not self.bleh then return end
    self.sprite:setSprite("enemies/shooters/shoot")
    Assets.playSound("flower", 1.3)
    self.sprite:flash()
    self.sprite:play(0.05, false, function()
        if self.bleh then
            self:shootUp(3)
        end  
        self.sprite:setSprite("enemies/shooters/idle")
        self.sprite:play(0.25, true)
        self.shoot_timer = Game.stage.timer:after(1.0, function() 
            self:startShootLoop() 
        end)
    end)
end

function ShooterPetals:shootUp(amount)
    if not Game.world.soul then return end
    local local_bx, local_by = self.sprite:getRelativePos(self.sprite.width / 2, self.sprite.height / 2)
    local map_x, map_y = self:getRelativePos(local_bx, local_by)
    local base_angle = MathUtils.angle(map_x, map_y, Game.world.soul.x, Game.world.soul.y)
    
    for i = 1, amount do
        local bullet = Game.world:spawnBullet("bullets/smallbullet", map_x, map_y)
        if bullet then
            bullet.damage = bullet:getDamage() * 3.5
            bullet:setColor(ColorUtils.hexToRGB("#CECFAC"))
            bullet.alpha = 0
            bullet:setScale(2.4)
            
            local spread_offset = (i - (amount + 1) / 2) * 0.2
            bullet.physics.direction = base_angle + spread_offset
            bullet.physics.speed = 7
            bullet.physics.gravity = 0.3
            bullet.physics.gravity_direction = bullet.physics.direction
            bullet.remove_offscreen = true
            bullet:fadeTo(1, 0.3)
        end
    end
end

return ShooterPetals
