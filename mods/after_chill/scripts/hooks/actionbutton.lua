local ActionButton, super = HookSystem.hookScript(ActionButton)

function ActionButton:init(type, battler, x, y)
    super.init(self, type, battler, x, y)
    if self.type == "spare" and (Game:getFlag("geno") or Game.battle.encounter.id == "bleh") then
        self.disabled = true
        self.selectable = false
    end
end

function ActionButton:select()
    if self.type == "spare" and Game:getFlag("geno") then
        Assets.stopAndPlaySound("error") 
        return
    end
    return super.select(self)
end

return ActionButton
