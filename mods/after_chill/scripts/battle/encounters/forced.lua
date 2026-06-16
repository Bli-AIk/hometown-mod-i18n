local forced, super = Class(Encounter)

function forced:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Noelle can't stop attacking.\n* (Tension is high.)"

    -- Battle music ("battle" is rude buster)
    self.music = "scary"
    -- Enables the purple grid battle background
    self.background = true 
    self.dialogue_lines = {
    [1] = {
        {"What's going on...?"},
        {"Calm down\n[wait:5] please!"},
    },
    [2] = {
        {"(Why is she attacking me?)"},
        {"I.. have\nto survive."},
        {"I[wait:2]-I could use\nmy fire magic..."},
        {"If you can hear me,\nthen..."},
        {"Respond,[wait:10] please."},
        {"F[wait:2]-fine. Guess I'm forced\nto use my own magic."}
    }
}
    self:addEnemy("ralsei_forced", 549, 219)
end

function forced:onBattleStart()
    Game:setTension(32)
    Game.battle.music:setVolume(0.8)
    return super.onBattleStart(self)
end

function forced:getDialogueCutscene()
    local turn = Game.battle.turn_count
    local lines = self.dialogue_lines[turn]
    if lines then
        return function(cutscene)
            for _, data in ipairs(lines) do
                local text = data[1]     
                    cutscene:wait(cutscene:battlerText("ralsei_forced", text))
            end
        end 
    end 
end

return forced
