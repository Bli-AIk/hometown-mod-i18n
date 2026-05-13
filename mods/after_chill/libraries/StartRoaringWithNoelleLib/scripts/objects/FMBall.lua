---@class FMBall : Sprite
---@overload fun(...) : FMBall
local FMBall, super = Class(Sprite)

---@enum FMBall.types
-- I hate my life
FMBall.TYPES = {
    fore = 1,
    back = 2,
}

function FMBall:init(x, y, type)
    super.init(self, "effects/make_fountain/ball", x, y, nil, nil, nil)

    self:setOriginExact(24, 24)
    --depth = 12

    self._create_back = false
    if type == nil then
        type = FMBall.TYPES.fore
        self._create_back = true
    end
    self.back = nil
    self.type = type

    local scale = 2
    if self.type == FMBall.TYPES.fore then
        self.scale_x = 0.05 * scale
        self.scale_y = 0.05 * scale
        self.color = COLORS["black"]
        self.physics.gravity = (0.07 + Utils.random(0.02)) * scale
        local angle_w = 30
        self.physics.gravity_direction = math.rad(270 + (Utils.random(-angle_w,angle_w)))
        self.physics.friction = 0.05 * scale
        self.physics.speed_x = (Utils.random(-1.5,1.5)) * scale
        self.physics.speed_y = (-0.5 + Utils.random(-1)) * scale
        self:setHitbox(0, 0, self.width, self.height)
    else
        -- accuracy !!
        self.scale_x = 0.05 * scale + 0.07
        self.scale_y = 0.05 * scale + 0.07
        self.color = COLORS["white"]
        self.collidable = false
    end

    self.size = 0
    self.graphics.grow = 0.01 * scale
end

function FMBall:onAdd(parent)
    if self._create_back and not self.back then
        self.back = FMBall(self.x, self.y, FMBall.TYPES.back)
        self.back.layer = self.layer - 1
        self.back.physics.gravity = self.physics.gravity
        self.back.physics.gravity_direction = self.physics.gravity_direction
        self.back.physics.friction = self.physics.friction
        self.back.physics.speed_x = self.physics.speed_x
        self.back.physics.speed_y = self.physics.speed_y
        parent:addChild(self.back)
    end
end

function FMBall:update()
    super.update(self)

    self.size = self.size + 0.5 * DTMULT
    local _, y = self:localToScreenPos()
    if y <= -20 - self.size then
        self:remove()
        return
    end
end

function FMBall:draw()
    super.draw(self)

    if DEBUG_RENDER and self.collider then
        self.collider:draw(1, 0, 0)
    end
    
end
--function FMBall:onAdd(parent)
  --  local NoelleSilhouetteFX = noelle_silhouette_fx()

  --  if self._create_back and not self.back then
   --     self.back = FMBall(self.x, self.y, FMBall.TYPES.back)
   --     self.back.layer = self.layer - 1
  --      parent:addChild(self.back)
--    end

  --  if self.type == FMBall.TYPES.fore then
      --  local noelle = Game.world and Game.world:getCharacter("noelle")
  --      if noelle then
       --     self:addFX(NoelleSilhouetteFX(noelle), "noelle_outline")
      --  end
   -- end
--end

return FMBall