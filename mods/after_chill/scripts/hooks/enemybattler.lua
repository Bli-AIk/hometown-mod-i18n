local EnemyBattler, super = HookSystem.hookScript(EnemyBattler)

function EnemyBattler:getCheckText()
    if Game:getFlag("geno") then 
        return "* " .. string.upper(self.name) .. " - AT ? DF ?\n* [color:red]KILL[color:reset] IT."
    else 
        return super.getCheckText(self)
    end
end

function EnemyBattler:init()
    super.init(self)
    -- make sure to change the value here when the time comes 
    if (Game:getFlag("enemies_killed") >= 10) and Game:getFlag("ralsei_flee") then
        local kills = Game:getFlag("enemies_killed", 0)
    local dynamic_tp = 0

    if kills >= 10 then
        local scaling_kills = kills - 5
        dynamic_tp = MathUtils.clamp(2 + (scaling_kills * 1.5), 10, 50)
    end

    self:registerAct("Rupture", "Bonus DMG\nwhen TIRED", {}, dynamic_tp) 
    end 
end 

function EnemyBattler:onDefeat(damage, number)
    -- so here be like, add it on IF rupture hasn't been unlocked yet, so, if its bigger than  like, the amount needed, then start counting the rupture kills. 
    Game:addFlag("enemies_killed", 1)
    super.onDefeat(self, damage, number)
end 

function EnemyBattler:onAct(battler, name)
    if name == "Rupture" then 
        Game.battle:powerAct("rupture", battler, "kris")
    end 
    return super.onAct(self, battler, name)
end 

return EnemyBattler