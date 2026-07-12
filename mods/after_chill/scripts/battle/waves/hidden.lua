local Basic, super = Class(Wave)


function Basic:init()
    super.init(self)
    self.base_w = 1
    self.base_h = 1 
    self.my_clock = 0
    self.time = 0
    self.spawn_soul = false
    self.has_arena = false
end 
function Basic:onStart()
        Game.battle:undarken()
end


return Basic
