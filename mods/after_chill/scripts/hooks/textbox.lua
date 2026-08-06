local box, super = HookSystem.hookScript(Textbox)

function box:draw(...)
    -- 1. Correctly unpack Kristal's individual color channels
    local r, g, b, a = self:getDrawColor()
    
    -- 2. Pass them cleanly into your framework's Draw pipeline with the payload
    
    -- 3. Let the core code render the text elements safely
    Draw.setColor(r, g, b, 0.99)
    super.draw(self, ...)
    Draw.setColor(r, g, b, 0.99)
end 

return box
