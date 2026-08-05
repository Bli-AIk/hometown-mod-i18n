local Encounter, super = HookSystem.hookScript(Encounter)

function Encounter:init(...)
    super.init(self, ...)
end 

function Encounter:onStateChange(old, new, reason) 
   if old == "INTRO" and new == "ACTIONSELECT" then
    if Game:getFlag("geno") then 
    local mus = Game.battle.music:tell()
    Game.battle.music:play("snowstorm_g")
    Game.battle.music:seek(mus)
    self.music = "snowstorm_g"
    end 
    self.bg = SnowflakeBG()
    Game.battle:addChild(self.bg)
    elseif new == "TRANSITIONOUT" then 
    self.bg:remove()
    end 
    super.onStateChange(self, old, new, reason)
end 

return Encounter
