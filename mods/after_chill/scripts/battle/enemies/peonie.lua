local peonie, super = Class(EnemyBattler)

function peonie:init()
    super.init(self)

    self.name = "Peonie"
    self:setActor("peonie")

    self.max_health = 340
    self.health = 340
    self.attack = 7  
    self.defense = 7
    self.money = 54

    self.spare_points = 20

    self.waves = {
        "peonie/flowerspin",
        "peonie/petal"
    }

    self.experience = 34 

    self.dialogue = {} 
    self.check = {
        "AT 9 DF 10\n* Once part of a bouquet.\n* It fell off a flower.", 
        "It has lost the path it was meant\nto follow,[wait:5] and has now found its\nway into the arena."
    }

    self.text = {
        "* The wind sways Peonie around.",
        "* Smells like pollen.", 
        "* A cold draft passess through.", 
    }
    self.low_health_percentage = 0.25
    self.low_health_text = "* You can see Peonie wilting slowly."
    self:registerAct("Prune", "Lower\nDF", {}, 12)
    self:registerAct("Bloom", "Get\nMercy")
    self:registerAct("BloomX", "Spare\nEnemy", {"ralsei"}, 18)
end

function peonie:onAct(battler, name)
    if name == "Bloom" then
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* You tell Peonie that just because\nit left its own flower...")
            cutscene:text("* Doesn't mean it can't bloom into a new, even more wonderful one!")
            self:addMercy(100)
            for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
            if enemy ~= self and enemy.id == "peonie" then
            enemy:addMercy(25)
            end
            end
            cutscene:text("* It and its friends feel happier!")
        end)
    elseif name == "Prune" then 
        self.defense = self.defense - 1
        return "* You ripped off a few dirty petals\nfrom the enemy.[wait:10]\n* It's [color:yellow]defense[color:reset] lowered!"
    elseif name == "BloomX" then 
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* You and Ralsei encourage the enemy to bloom once again into a\nbeautiful flower!")
            self:addMercy(100)
            self:spare()
            cutscene:wait(0.5)
            cutscene:text("* The enemy seemed to leave in a joyful rush!")
        end)
    elseif name == "Standard" then 
        if battler.chara.id == "ralsei" then 
            self:addMercy(50)
            return {
            "* Ralsei tried to gently brush dirt off the enemy!", 
            "* The enemy feels cared for\nand happy!", 
            }
        end 
    end 
    return super.onAct(self, battler, name)
end

function peonie:onSpared(pacified)
    local spawn_x, spawn_y = self:getRelativePos(self.width/2, self.height/2, Game.battle)
    local line_x = spawn_x - 50

    for i = 1, 8 do
        local stacked_y = (spawn_y - 48) + ((i - 1) * 12)
        local addon = MathUtils.round(MathUtils.random(1, 2))
        local sprite = Sprite("effects/petal_" .. addon, line_x, stacked_y)     
        sprite:setScale(2)
        sprite:setOrigin(0.5)
        sprite:setLayer(self.layer + 0.001)
        sprite.start_x = line_x
        sprite.wave_time = love.math.random() * 10
        sprite.fall_progress = 0
        sprite.fall_speed = 120    
        sprite.sway_speed = 5.0    
        sprite.sway_width = 15     
        Game.battle:addChild(sprite)
        Game.battle.timer:every(0, function()
            if not sprite or not sprite.stage then return false end

            sprite.wave_time = sprite.wave_time + (DT * sprite.sway_speed)
            sprite.fall_progress = sprite.fall_progress + (DT * sprite.fall_speed)

            sprite.x = sprite.start_x + (math.sin(sprite.wave_time) * sprite.sway_width)
            sprite.y = stacked_y + sprite.fall_progress
            sprite.rotation = math.cos(sprite.wave_time) * 0.4
            sprite.alpha = sprite.alpha - (DT * 1.5)

            if sprite.x < 100 then
                sprite:remove()
                return false
            end
        end)
    end

    return super.onSpared(self, pacified)
end

return peonie
