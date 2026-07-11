---@class DynamicSavepoint : Savepoint
local DynamicSavepoint, super = Class(Savepoint)

function DynamicSavepoint:init(x, y, data)
    super.init(self, x, y, data.properties)
    local properties = data and data.properties or {}
    self.condition_flag = properties["flag"] or nil 

    self.normal_lines = {}
    self.flagged_lines = {}
    self.geno_lines = {}

    for i = 1, 20 do
        if properties["text" .. i] then table.insert(self.normal_lines, properties["text" .. i]) end
        if properties["flagged_text" .. i] then table.insert(self.flagged_lines, properties["flagged_text" .. i]) end
        if properties["geno_text" .. i] then table.insert(self.geno_lines, properties["geno_text" .. i]) end
    end
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
