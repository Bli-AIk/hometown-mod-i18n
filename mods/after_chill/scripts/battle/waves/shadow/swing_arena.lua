local swing_arena, super = Class(Wave)

function swing_arena:init()
    super.init(self)
    self.time = -1 
    self:setArenaPosition(320, 230)
end

function swing_arena:onStart()
    local shadow = self:getAttackers()[1]
    self:swing(shadow)
end 

function swing_arena:swing(shadow)
    Assets.playSound("scytheburst", 2, 1.4)
    local options = {"horizontal", "vertical"}
    local hv = TableUtils.pick(options)
    shadow:setAnimation("swing", function()
        self:drawLineToSplit(hv)
    end)
end 

function swing_arena:drawLineToSplit(hv)
    local length = Game.battle.arena.width + 48
    local rx, ry = Game.battle.arena:getCenter()
    if hv == "horizontal" then 
    local rect = Rectangle(rx, ry, length, 7)
    rect:setColor(COLORS.white)
    Game.battle:addChild(rect)
    rect.layer = 9999
    rect:setPosition(235, 227)
    rect.alpha = 0 
    rect.height = 0
    self:startSplit()
    Assets.playSound("appear", 0.6, 1.4)
    self.timer:tween(0.2, rect, {alpha = 1, height = 7})
    else 
    local rect = Rectangle(rx, ry, 7, Game.battle.arena.height + 48)
    rect:setColor(COLORS.white)
    Game.battle:addChild(rect)
    rect.layer = 9999
    rect.rotation = math.rad(90)
    rect:setPosition(235, 227) -- change depending on where it is
    rect.alpha = 0 
    rect.width = 0
    self:startSplit()
    Assets.playSound("appear", 0.6, 1.4)
    self.timer:tween(0.2, rect, {alpha = 1, width = 7})
    end 
end 

function swing_arena:startSplit()
      -- arena split code 
end 

return swing_arena
