local dusteer, super = Class(EnemyBattler)

function dusteer:init()
    super.init(self)

    self.name = "Reinfrost"
    self:setActor("dusteer")

    self.max_health = 340
    self.health = 340
    self.attack = 10 
    self.defense = 7
    self.money = 100

    self.spare_points = 10

    self.waves = { 
        "reinfrost/gallop", 
        "reinfrost/snow_graze"
    }
    self.dialogue = {} 
    self.check = "AT 10 DF 7\n* A deer that likes the way you smell.\n* Tramples snow, try [color:yellow]sweeping[color:reset] it!"

    self.text = {
        "* A cold breeze runs through.\n* Reinfrost shakes a little.", 
        "* Smells like trampled snow.", 
        "* Reinfrost trots and kicks some\nsnow.", 
    }
    self.low_health_percentage = 0.2
    self.low_health_text = "* Reinfrost's antlers look slightly cracked."
    self:registerAct("Sweep", "Get\nMercy")
    self:registerAct("HeatUp", "Lower\nAttack", {"ralsei"}, 8)
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
    elseif name == "HeatUp" then 
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* You and Ralsei gave warm smiles to the enemy!")
            local ralsei = Game.battle:getPartyBattler("ralsei")
            cutscene:wait(cutscene:setAnimation(ralsei, "battle/spell"))
            cutscene:text("* Ralsei also made the arena warmer,[wait:5] and the cold air feels refreshing!")
            self.attack = self.attack - 2 
            self:addMercy(75)
            cutscene:text("* The enemy feels flattered, and\nit's powers were slightly weakened!")
        end)
    elseif name == "Standard" then 
        if battler.chara.id == "ralsei" then 
            battler:setAnimation("battle/spell")
            Assets.playSound("spellcast")
            for _, enemy in ipairs(Game.battle:getActiveEnemies()) do 
                if enemy.id == "dusteer" then  
                    enemy:addMercy(50)
                else 
                    enemy:addMercy(25)
                end 
            end 
            return "* Ralsei tried to heat up the arena![wait:5]\n* The enemies felt comforted!"
        end 
    end 
    return super.onAct(self, battler, name)
end

return dusteer
