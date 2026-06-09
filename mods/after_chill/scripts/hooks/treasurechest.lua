local chest, super = HookSystem.hookScript(TreasureChest)

function chest:init(x, y, properties)
    super.init(self, x, y, properties)
    self.layer = properties["layer"] or 0.5
    self.properties = TableUtils.copy(properties)
    --  Kristal.Console:warn(self.layer)
end

function chest:update()
    super.update(self)
    self.layer = self.properties["layer"] or 0.5
end 


return chest
