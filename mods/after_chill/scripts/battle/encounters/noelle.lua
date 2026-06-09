local noelle, super = Class(Encounter)

function noelle:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Noelle enters the fray."

    self.music = "noelle"
    -- Enables the purple grid battle background
    self.background = false 
    self.hide_world = false 
    self:addEnemy("noelle", 531, 269)
end

function noelle:onBattleStart()
    Game.fader:fadeOut(function()
        super.onBattleStart(self) 
        Game.fader:fadeIn(nil, {speed = 0.2}) 
    end, {speed = 0.4, color = {204/255, 255/255, 255/255}})
end

function noelle:getPartyPosition(index)
    if index == 1 then 
        return 118, 263 
    else 
        return super.getPartyPosition(self, index)
    end 
end 


return noelle
