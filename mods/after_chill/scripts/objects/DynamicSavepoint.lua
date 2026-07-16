---@class DynamicSavepoint : Savepoint
local DynamicSavepoint, super = Class(Savepoint)

function DynamicSavepoint:init(x, y, data)
    super.init(self, x, y, data.properties)
    local properties = data and data.properties or {}
    self.condition_flag = properties["flag"]
    self.normal_lines = TiledUtils.parsePropertyList("text", properties)
    self.flagged_lines = TiledUtils.parsePropertyList("flagged_text", properties)
    self.geno_lines = TiledUtils.parsePropertyList("geno_text", properties)
    table.insert(self.geno_lines, "* You are filled with a certain power.")
end

function DynamicSavepoint:onInteract(player, dir)
    if Game:getFlag("geno") then
        self.text = self.geno_lines
    elseif Game:getFlag(self.condition_flag) then
        self.text = self.flagged_lines
    else 
        self.text = self.normal_lines
    end
    return super.onInteract(self, player, dir)
end

return DynamicSavepoint
