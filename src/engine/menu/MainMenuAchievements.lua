local MainMenuAchievements, super = Class(StateClass)

function MainMenuAchievements:init(menu)
    self.menu = menu

    self.font = Assets.getFont("main")
    self.font_2 = Assets.getFont("main", 16)
    
    self.offset = 0 -- 1. Initialize offset

    -- Using a simple list here for easier scrolling math
    local all_data = {
        {
            id = "prophecy_wrath",
            name = "Prophecy's Wrath",
            desc = "Defeat Ralsei, allowing the angel to unleash her\ndetermination and full power.",
            icon = "wrath",
            border = "Legendary"
        },
        {
            id = "noelle_dead",
            name = "Lost Angel",
            desc = "Defeat Noelle, leaving the dark hero in his\nown sorrow and tears.",
            icon = "lost",
            border = "Legendary"
        }, 
        { 
            id = "proceed", 
            name = "Frozen Betrayal", 
            desc = "Tell Noelle to PROCEED multiple times,\nresulting in her using her ice magic against you.", 
            icon = "proceed", 
            border = "Legendary"
        },
        -- ADD MORE HERE LATER: The scrolling will handle them automatically!
    }

    self.achievements = all_data
end

function MainMenuAchievements:onKeyPressed(key)
    if Input.isCancel(key) or Input.isConfirm(key) then
        Assets.stopAndPlaySound("ui_select")
        self.menu:setState("TITLE")
        return
    end

    -- 2. Scrolling Logic
    if Input.is("up", key) and self.offset > 0 then
        self.offset = self.offset - 1
        Assets.stopAndPlaySound("ui_move")
    elseif Input.is("down", key) and self.offset < #self.achievements - 3 then
        self.offset = self.offset + 1
        Assets.stopAndPlaySound("ui_move")
    end
end


function MainMenuAchievements:registerEvents(master)
    self:registerEvent("enter", self.onEnter)
    self:registerEvent("keypressed", self.onKeyPressed)
    self:registerEvent("draw", self.draw)
end

function MainMenuAchievements:onEnter()
    self.menu.heart_target_x = 320 - 40
    self.menu.heart_target_y = 454
end

function MainMenuAchievements:onKeyPressed(key)
    if Input.isCancel(key) or Input.isConfirm(key) then
        Assets.stopAndPlaySound("ui_select")
        self.menu:setState("TITLE")
    end
end

function MainMenuAchievements:draw()
    -- 1. Header & Background Box
    Draw.setColor(COLORS.silver)
    Draw.printShadow("( ACHIEVEMENTS )", 0, 20, 2, "center", 640)
    
    Draw.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle("fill", 40, 80, 560, 320, 10, 10)
    Draw.setColor(1, 0.8, 0)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 40, 80, 560, 320, 10, 10)
    love.graphics.setLineWidth(1)
    
    love.graphics.setFont(self.font_2)
    
    -- 2. Achievement List Loop (Shows 3 slots at a time)
    for i = 1, 3 do
        -- 'index' is the actual achievement position in your table
        local index = i + self.offset
        local ach = self.achievements[index]
        
        -- 'y' is the screen position for the current slot
        local y = 115 + 95 * (i - 1)
        
        if ach then 
            -- Check if this specific ID has been marked as earned in Config
            local earned = Kristal.Config["ach_" .. ach.id]
            
            if earned then
                -- EARNED STATE: Full color, show name and description
                Draw.setColor(1, 1, 1)
                local rarity = Assets.getTexture("achievements/frames/"..ach.border)
                if rarity then love.graphics.draw(rarity, 60, y, 0, 2, 2) end
                
                local icon = Assets.getTexture("achievements/"..ach.icon)
                if icon then love.graphics.draw(icon, 60 + 8, y + 8, 0, 2, 2) end
                
                love.graphics.print(ach.name, 150, y + 5)
                Draw.setColor(0.7, 0.7, 0.7)
                love.graphics.printf(ach.desc, 150, y + 25, 430)
            else 
                -- LOCKED STATE: Dimmed, show "Locked" text
                Draw.setColor(0.3, 0.3, 0.3) 
                local locked_icon = Assets.getTexture("achievements/locked")
                if locked_icon then love.graphics.draw(locked_icon, 60 + 8, y + 8, 0, 2, 2) end
                
                love.graphics.print("LOCKED", 150, y + 5)
                Draw.setColor(0.4, 0.4, 0.4)
                love.graphics.print("You haven't unlocked this achievement yet.", 150, y + 25)
            end
        end
    end
    
    -- 3. Scrolling Indicators (Optional: Shows arrows if you can scroll)
    Draw.setColor(1, 1, 1)
    if self.offset > 0 then
        Draw.printShadow("^", 570, 90, 2) -- Up arrow
    end
    if self.offset < #self.achievements - 3 then
        Draw.printShadow("v", 570, 360, 2) -- Down arrow
    end
    love.graphics.setFont(self.font)
    Draw.setColor(1, 1, 1)
    Draw.printShadow("Back", 0, 446 - 8, 2, "center", 640)
end

return MainMenuAchievements
