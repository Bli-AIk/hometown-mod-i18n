local shadow, super = Class(Encounter)

function shadow:init()
    super.init(self)

    self.reduced_tension = true 
    self.text = "* [color:yellow]TP[color:reset] restricted outside of [color:green]???[color:reset]\n* (...)"

    self.music = "alarm"
    self.background = false 
    self.hide_world = false 
    self:addEnemy("shadow", 516, 265)
    self.star1 = Sprite("effects/star", -100, 190)
    self.star2 = Sprite("effects/starblue", 740, 190)
    Game.battle.timer:during(3, function()
    for _, after in ipairs(Game.stage:getObjects(AfterImage)) do 
        if not after.custom_fx_applied then 
            after:addFX(ColorMaskFX(COLORS.black), "black_mask")
            after:addFX(OutlineFX(Game:getPartyMember("ralsei").color), "green_outline")
            after.custom_fx_applied = true 
        end 
    end 
end)
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

    -- 2. Grab your pre-existing stars array and cycle them
    local stars = {self.star2, self.star1} -- star2 matches shadow (i=1), star1 matches ralsei (i=2)
    
    for i = 1, 2 do 
        local star = stars[i]
        star:play(0.1, true)
        star:setScale(2.6)
        
        local target = ralsei
        if i == 1 then target = shadow end 
        local dest_x, dest_y = target:getRelativePos(target.width/2, target.height, target.parent)
        if i == 1 then dest_x = dest_x - 8 end 
        if i == 2 then dest_x = dest_x - 4 end 
        
        star:setOrigin(0.3, 0.6)
        star.layer = target.layer - 0.0001
        target.parent:addChild(star)
        Game.battle.timer:tween(0.6, star, {x = dest_x, y = dest_y}, "out-sine", function()
            makeFloat(target, star, 3, 12)
        end)
    end 
    local max_stars = 45 
    local star_table = {}

    for i = 1, max_stars do
        local star = Sprite("effects/sparkle_1")
        
        local rand_x = love.math.random(-100, 780)
        local rand_y = love.math.random(-50, 160)
        star:setPosition(rand_x, rand_y)  
        
        local rand_scale = love.math.random(10, 25) / 10 
        star:setScale(rand_scale)
        
        table.insert(star_table, star)
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
    Game.battle.timer:afterCond(function()
        if Game.battle.music and Game.battle.music:isPlaying() then
            return Game.battle.music:tell() >= 5
        end
        return false
    end, function()
        for _, star in ipairs(star_table) do 
            star.layer = shadow.layer - 0.00001
            star:fadeTo(1, 0.5)
        end 
    end)
end

return shadow
