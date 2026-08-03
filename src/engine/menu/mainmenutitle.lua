local MainMenuTitle, super = Class(StateClass)

function MainMenuTitle:init(menu)
    self.menu = menu
    self.logo = Assets.getTexture("kristal/title_logo_shadow")
    self.selected_option = 1
    self.x_offset = 248 + 35  
    self.y_offset = 219       
    self.menu_timer = 0
end

function MainMenuTitle:registerEvents()
    self:registerEvent("enter", self.onEnter)
    self:registerEvent("keypressed", self.onKeyPressed)
    self:registerEvent("update", function() self.menu_timer = self.menu_timer + DT end)
    self:registerEvent("draw", self.draw)
end

function MainMenuTitle:onEnter(old_state)
    self.has_target_saves = TARGET_MOD and Kristal.hasAnySaves(TARGET_MOD) or false
    if TARGET_MOD then
        self.options = {
            { "play", self.has_target_saves and "Load game" or "Start game" },
            { "options", "Options" },
            { "credits", "Credits" },
            { "quit", "Quit" },
        }
    else
        self.options = {
            { "play", "Play" },
            { "modfolder", "Open folder" },
            { "options", "Options" },
            { "credits", "Credits" },
            { "wiki", "Open wiki" },
            { "quit", "Quit" },
        }
    end

    if not TARGET_MOD then
        self.menu.selected_mod = nil
        self.menu.selected_mod_button = nil
    else
        local mod = Kristal.Mods.getMod(TARGET_MOD)
        if mod and mod.soulColor then self.menu.heart:setColor(mod.soulColor) end
    end
    
    self.menu.heart_target_x = self.x_offset - 19
    self.menu.heart_target_y = (self.y_offset + 18) + 32 * (self.selected_option - 1)
end

function MainMenuTitle:onKeyPressed(key, is_repeat)
    if Input.isConfirm(key) then
        Assets.stopAndPlaySound("ui_select")
        local option = self.options[self.selected_option][1]
        if option == "play" then
            if not TARGET_MOD then self.menu:setState("MODSELECT")
            else
                local mod = Kristal.Mods.getMod(TARGET_MOD)
                if (mod["useSaves"] == true) or (mod["useSaves"] == nil and self.has_target_saves) then self.menu:setState("FILESELECT")
                elseif (mod["useSaves"] == false) or (mod["useSaves"] == nil and not self.has_target_saves) then
                    if not Kristal.loadMod(TARGET_MOD, 1) then error("Failed to load mod: " .. TARGET_MOD) end
                end
            end
        elseif option == "modfolder" then
            if (love.system.getOS() == "Windows") then os.execute('start /B \"\" \"' .. love.filesystem.getSaveDirectory() .. '/mods\"')
            else love.system.openURL("file://" .. love.filesystem.getSaveDirectory() .. "/mods") end
        elseif option == "options" then self.menu:setState("OPTIONS")
        elseif option == "credits" then self.menu:setState("CREDITS")
        elseif option == "wiki" then love.system.openURL("https://kristal.cc")
        elseif option == "quit" then love.event.quit() end
        return true
    end

    local old = self.selected_option
    if Input.is("up", key) then self.selected_option = self.selected_option - 1 end
    if Input.is("down", key) then self.selected_option = self.selected_option + 1 end
    if self.selected_option > #self.options then self.selected_option = 1 end
    if self.selected_option < 1 then self.selected_option = #self.options end

    if old ~= self.selected_option then Assets.stopAndPlaySound("ui_move") end

    self.menu.heart_target_x = self.x_offset - 19
    self.menu.heart_target_y = (self.y_offset + 18) + 32 * (self.selected_option - 1)
end

function MainMenuTitle:draw()
    local logo_img = self.menu.selected_mod and self.menu.selected_mod.logo or self.logo
    Draw.setColor(1, 1, 1, 1)
    Draw.draw(logo_img, SCREEN_WIDTH / 2, 105, 0, 1.7, 1.7, logo_img:getWidth() / 2, logo_img:getHeight() / 2)
    for i, option in ipairs(self.options) do
        local current_x = self.x_offset
        local current_y = self.y_offset + 32 * (i - 1)
        
        if i == self.selected_option then
            Draw.setColor(0.18, 0.54, 0.94, 1) 
            current_x = current_x + (math.sin(self.menu_timer * 12.0) * 1.5)
        else
            Draw.setColor(0.45, 0.60, 0.75, 1) 
        end
        Draw.printShadow(option[2], current_x, current_y)
    end
end

function MainMenuTitle:selectOption(id)
    for i, options in ipairs(self.options) do
        if options[1] == id then
            self.selected_option = i
            self.menu.heart_target_x = self.x_offset - 19
            self.menu.heart_target_y = (self.y_offset + 18) + 32 * (self.selected_option - 1)
            return true
        end
    end
    return false
end

return MainMenuTitle
