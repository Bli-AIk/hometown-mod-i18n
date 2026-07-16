local Basic, super = Class(Wave)


function Basic:init()
    super.init(self)
    self.time = 0
    self.spawn_soul = false
    self.has_arena = false
end 

function Basic:onStart()
    Game.battle:undarken()
end

return Basic
