local dusteer, super = Class(EnemyBattler)

function dusteer:init()
    super.init(self)

    self.name = "Dusteer"
    self:setActor("Dusteer")

    self.max_health = 340
    self.health = 340
    self.attack = 7  
    self.defense = 7
    self.money = 100

    self.spare_points = 10

    self.waves = {
    }
    self.dialogue = {} 
    self.check = "AT 8 DF 6\n* Get away from it before you sneeze!"
    self.ui_modified = false 

    self.text = {
        "* the wind blows through. You can see a chunk of Dusteer blow away along with it.", 
        "* It resembles a bunny. Just without the bunny features.", 
        "* Smells like deer.", 
    }
    self.low_health_percentage = 0.25
    self.spare_text = "* You sneeze. Dusteer seemed satisfied it did its job."
    self.low_health_text = "* You can see Peonie wilting slowly."

    self:registerAct("Sweep", "Get\nMercy")
    self:registerXAct("N-Sweep", "Get\nMercy")
end

function dusteer:onAct(battler, name)
    if name == "Sweep" then
        
        Game.battle:startActCutscene(function(cutscene)
            set.animation = "sweep"
            local kris = Game.battle:getPartyBattler("kris")
            local x, y = Game.battle.enemies[1].x, Game.battle.enemies[1].y
            kris:slideTo(x, y, 0.5)
            kris:setAnimation("sweep")
            cutscene:text("* You pretend to clean the arena of all its dust!")
            cutscene:text("* Dusteer feels happy your collecting parts of its... body...?")
            self:addMercy(50)
            
        end)
    end 
    return super.onAct(self, battler, name)
end
function dusteer:onXAct(battler, name)
    if name == "N-Sweep" then
        Game.battle:startActCutscene(function(cutscene)
            set.animation = "sweep"
            local noelle = Game.battle:getPartyBattler("noelle")
            local x, y = Game.battle.enemies[1].x, Game.battle.enemies[1].y
            noelle:slideTo(x, y, 0.5)
            noelle:setAnimation("sweep")
            cutscene:text("* Noelle cleans the arena of its dust!")
            cutscene:text("* Dusteer feels happy your collecting parts of its... body...?")
            self:addMercy(25)
            
        end)
    end 
    return super.onXAct(self, battler, name)
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

function peonie:onDefeat()
    if Game:getFlag("geno") then 
    self:statusMessage("msg", "lost", {1, 1, 1})
    self:onDefeatFatal()
    else 
    return super.onDefeat(self)
    end 
end 



return peonie
