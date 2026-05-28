local shadow, super = Class(Encounter)

function shadow:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* IT blocks your path."

    -- Battle music ("battle" is rude buster)
    if Game.world.music:isPlaying() then 
    self.music = nil
    else 
        self.music = "shadow"
    end 
    -- Enables the purple grid battle background
    self.background = false 
    self.hide_world = false 

    -- Add the dummy enemy to the encounter
    self.enemy = self:addEnemy("shadow", 516, 292)
    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

function shadow:getPartyPosition(index) 
    if index == 1 then 
        return 137, 293
    end 
    super.getPartyPosition(self, index)
end 

return shadow
