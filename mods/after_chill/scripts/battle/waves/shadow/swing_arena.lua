local swing_arena, super = Class(Wave)

function swing_arena:init()
    super.init(self)
    self.time = -1 
    self.arenas = {}
   -- self:setArenaPosition(320, 230)
end

function swing_arena:onStart()
    self.width = Game.battle.arena.height
    local shadow = self:getAttackers()[1]
    self:swing(shadow)
end 

function swing_arena:swing(shadow)
    local options = {"horizontal"}
    local hv = TableUtils.pick(options)
    shadow:setAnimation("swing", function()
        self.timer:after(0.2, function()
        Assets.playSound("wing")
        shadow:shake(2)
        shadow:resetSprite()
        end)
    end)
    self.timer:after(0.1, function()
        Assets.playSound("scytheburst", 2, 1.4)
        self.timer:after(0.1, function()
        self:drawLineToSplit(hv, 229, 174)
        end)
    end)
end 

function swing_arena:drawLineToSplit(hv, rx, ry)
    local length = Game.battle.arena.width + 48
    if hv == "horizontal" then 
    local rect = Rectangle(rx, ry, length, 7)
    rect:setColor(COLORS.white)
    Game.battle:addChild(rect)
    rect.layer = 9999
    rect.alpha = 0 
    rect.height = 0
    local snd = Assets.playSound("flower", 0.6, 2)
    self.timer:tween(0.3, rect, {alpha = 1, height = 7}, "out-cubic", function()
        self:startSplit(hv, rect)
    end)
    else 
    local rect = Rectangle(rx, ry, 7, Game.battle.arena.height + 48)
    rect:setColor(COLORS.white)
    Game.battle:addChild(rect)
    rect.layer = 9999
    rect.rotation = math.rad(90)
    rect:setPosition(235, 227) -- change depending on where it is
    rect.alpha = 0 
    rect.width = 0
    Assets.playSound("appear", 0.6, 1.4)
    self.timer:tween(0.2, rect, {alpha = 1, width = 7}, "out-cubic", function()
        self:startSplit(hv, rect)
    end)
    end 
end 

function swing_arena:startSplit(hv, rect)
    if hv == "horizontal" then 
        rect:fadeOutAndRemove(0.2)
        self.timer:after(0.1, function()
        local amount = TableUtils.pick({10, 12})
        self:spawnStars(hv, amount)
        local arena = Game.battle.arena
        Game.stage:shake(4, 4) 
        arena:setSize(arena.width, arena.height / 2)
        self.timer:tween(0.5, arena, {y = arena.y - 50}, "out-expo")
        self:spawnArenaDir(hv)
        end)
    else 
    end 
end

function swing_arena:spawnArenaDir(dir)
    if dir == "horizontal" then 
        local arena2 = Arena()
        table.insert(self.arenas, arena2)
        arena2.height = self.width / 2
        arena2.onAdd = function()
            arena2.sprite:setScale(1)
            arena2.sprite.alpha = 1
        end
        arena2.onRemove = function()
            arena2.sprite:remove()
        end
        arena2:setPosition(Game.battle.arena.x, Game.battle.arena.y + Game.battle.arena.height/2)
        Game.battle:addChild(arena2)
        arena2.motion = true
        self.timer:tween(0.5, arena2, {y = arena2.y + 50}, "out-expo")
        self:callWait(1, Game.battle.arena, arena2)
    end 
end 

function swing_arena:spawnStars(hv, amount)
    local stars = amount / 2 
    -- spawn stars here 
end 

function swing_arena:callWait(time, arena, arena2)
    if time then  
        self.timer:after(time, function()
             self:combine(arena, arena2)
        end)
    end 
end 

function swing_arena:combine(fir, sec)
    local target_x = 320
    local target_y = 172
    local half_height = fir.height
    fir.visible = false 
    local third = Arena(fir.x, fir.y)
    third.width = fir.width 
    third.height = half_height 
    third.onAdd = function()
        third.sprite:setScale(1)
        third.sprite.alpha = 1
    end
    third.onRemove = function()
        third.sprite:remove()
    end
    table.insert(self.arenas, third)
    Game.battle:addChild(third)
    self.timer:tween(0.5, third, {y = target_y - half_height/2}, "in-cubic")
    self.timer:tween(0.5, sec, {y = target_y + half_height/2}, "in-cubic", function()
        Assets.playSound("impact", 1, love.math.random(90, 110) / 100)
        Game.stage:shake(4)
        for _, arena in ipairs(self.arenas) do 
            if arena then arena:remove() end
        end 
        self.arenas = {} 
        local main_arena = Game.battle.arena
        main_arena:setSize(main_arena.width, self.width)    
        main_arena:setPosition(target_x, target_y)
        main_arena.visible = true
        local shadow = self:getAttackers()[1]
        if shadow then
            self:swing(shadow)
        end
    end)
end


function swing_arena:beforeEnd()
    for _, arena in ipairs(self.arenas) do 
        arena:remove()
    end 
end 

return swing_arena
