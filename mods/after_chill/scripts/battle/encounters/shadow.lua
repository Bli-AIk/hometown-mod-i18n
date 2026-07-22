local shadow, super = Class(Encounter)

function shadow:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.reduced_tension = true 
    self.text = "* [color:yellow]TP[color:reset] restricted outside of [color:green]???[color:reset]\n* (...)"

    self.music = "alarm"
    -- Enables the purple grid battle background
    self.background = false 
    self.hide_world = false 
    self:addEnemy("shadow", 516, 272)
end

function shadow:getPartyPosition(index) 
    if index == 1 then 
        return 137, 273
    end 
    return super.getPartyPosition(self, index)
end 

function shadow:onWavesDone()
    super.onWavesDone(self)
      local shadow = Game.battle:getEnemyBattler("shadow")
      shadow:resetSprite()
end
function shadow:onBattleStart()
    super.onBattleStart(self)  
    local ralsei = Game.battle:getPartyBattler("ralsei")
    local shadow = Game.battle:getEnemyBattler("shadow")
    local function makeFloat(battler, linked_star, speed, height)
    local old_update = battler.update
    local wave_offset = love.math.random() * math.pi * 2
    local start_y = nil
    local star_start_y = nil
    local last_x = nil
    local timealive = 0

    battler.update = function(spelf)
        old_update(spelf)
        if not start_y then
            start_y = spelf.y
            last_x = spelf.x
            if linked_star then star_start_y = linked_star.y end
        end
        if linked_star and last_x then
            local current_x = spelf.x
            local x_diff = current_x - last_x         
            linked_star.x = linked_star.x + x_diff
            last_x = current_x
        end
        timealive = timealive + DT
        local wave_movement = math.sin((timealive * speed) + wave_offset) * height
        
        spelf.y = start_y + wave_movement
        if linked_star and star_start_y then
            linked_star.y = star_start_y + wave_movement
        end
    end
end
    for i = 1, 2 do 
        local star = Sprite("effects/star")
        star:play(0.1, true)
        star:setScale(2.6)
        
        local target = ralsei
        if i == 1 then 
            target = shadow
            star = Sprite("effects/starblue") 
            star:play(0.1, true)
            star:setScale(2.6)
        end 
        
        local x, y = target:getRelativePos(target.width/2, target.height, target.parent)
        if i == 1 then x = x - 8 end 
        if i == 2 then x = x - 4 end 
        
        star:setPosition(x, y)
        star:setOrigin(0.3, 0.6)
        star.layer = target.layer - 0.0001
        target.parent:addChild(star)
        makeFloat(target, star, 3, 12)
    end 
    local start_x, end_x = -100, 780
    local start_y, end_y = -50, 160
    local spacing = 56
    local star_table = {}

    for x = start_x, end_x, spacing do
        for y = start_y, end_y, spacing do
            local star = Sprite("effects/sparkle_1")
            star:setScale(2)
            table.insert(star_table, star)
            
            local rand_x = x + love.math.random(-4, 4)
            local rand_y = y + love.math.random(-4, 4)
            star:setPosition(rand_x, rand_y)  
            Game.battle:addChild(star) 
            star.alpha = 0         
            local random_speed = love.math.random(40, 160) / 200   
            Game.world.timer:every(random_speed, function()
                if star.texture_path == "effects/sparkle_1" then
                    star:setSprite("effects/sparkle_2")
                else
                    star:setSprite("effects/sparkle_1")
                end
            end)
        end
    end
    Game.battle.timer:afterCond(function()
        if Game.battle.music and Game.battle.music:isPlaying() then
            return Game.battle.music:tell() >= 5
        end
        return false
    end, function()
        for _, star in ipairs(star_table) do 
            star:fadeTo(1, 0.5)
        end 
    end)
end 


return shadow
