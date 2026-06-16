local dusteer, super = Class(EnemyBattler)

function dusteer:init()
    super.init(self)

    self.name = "Reinfrost"
    self:setActor("dusteer")

    self.max_health = 340
    self.health = 340
    self.attack = 7  
    self.defense = 7
    self.money = 100

    self.spare_points = 10

    self.waves = { 
        "reinfrost/gallop"
    }
    self.dialogue = {} 
    self.check = "AT 8 DF 6\n* Get away from it before you sneeze!"
    self.ui_modified = false 

    self.text = {
        "* A cold breeze runs through.\n* Reinfrost shakes a little.", 
        "* Smells like trampled snow.", 
        "* Reinfrost trots and kicks some snow.", 
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
            battler:setAnimation("sweep")
            cutscene:text("* You pick up some snowflakes that drifted into the arena.")
            battler:setAnimation("battle/idle")
            cutscene:text("* Reinfrost is embarassed that they left snow tracks![wait:5]\n* They appreciate the gesture!")
            self:addMercy(50)
        end)
    end 
    return super.onAct(self, battler, name)
end

return dusteer
