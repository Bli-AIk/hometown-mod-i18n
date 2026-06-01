local dusteer, super = Class(EnemyBattler)

function dusteer:init()
    super.init(self)

    self.name = "Dusteer"
    self:setActor("dusteer")

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
    -- Game.battle:registerXAction("N-Sweep", "Get\nMercy")
end

function dusteer:onAct(battler, name)
    if name == "Sweep" then    
        Game.battle:startActCutscene(function(cutscene)
            self:setSprite("sweep")
            battler:setAnimation("sweep")
            cutscene:text("* You pretend to clean the arena of all its dust!")
            self:addMercy(50)
            battler:setAnimation("battle/idle")
            cutscene:text("* Dusteer is flattered that you helped it be less messy!")
            self:resetSprite()
        end)
    end 
    return super.onAct(self, battler, name)
end

-- function dusteer:onXAct(battler, name)
--     if name == "N-Sweep" then
--         Game.battle:startActCutscene(function(cutscene)
--             set.animation = "sweep"
--             local noelle = Game.battle:getPartyBattler("noelle")
--             local x, y = Game.battle.enemies[1].x, Game.battle.enemies[1].y
--             noelle:slideTo(x, y, 0.5)
--             noelle:setAnimation("sweep")
--             cutscene:text("* Noelle cleans the arena of its dust!")
--             cutscene:text("* Dusteer feels happy your collecting parts of its... body...?")
--             self:addMercy(25)
            
--         end)
--     end 
--     return super.onXAct(self, battler, name)
-- end

return dusteer
