local MainMenuTitle, super = Class(StateClass)

function MainMenuTitle:init(menu)
    self.menu = menu

    self.logo = Assets.getTexture("kristal/title_logo_shadow")

    self.selected_option = 1
    self.x_offset = 248 + 35
    self.y_offset = 219  
    self.particles = {}
    self.particle_timer = 0
    self.menu_timer = 0
end

function MainMenuTitle:registerEvents()
    self:registerEvent("enter", self.onEnter)
    self:registerEvent("keypressed", self.onKeyPressed)
    self:registerEvent("update", self.update)
    self:registerEvent("draw", self.draw)
end

-------------------------------------------------------------------------------
-- Callbacks
-------------------------------------------------------------------------------

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
        if mod and mod.soulColor then
            self.menu.heart:setColor(mod.soulColor)
        end
    end
    self.menu.heart_target_x = self.x_offset - 19
    self.menu.heart_target_y = (self.y_offset + 18) + 32 * (self.selected_option - 1)
end

function MainMenuTitle:update()
    self.menu_timer = self.menu_timer + DT

    local to_remove = {}
    for _, p in ipairs(self.particles) do
        p.timer = (p.timer or 0) + DT
        
        p.speed_y = p.speed_y + p.gravity * DT
        p.speed_x = p.speed_x * math.exp(-p.friction * DT)
        
        local sine_wave = math.sin(p.timer * p.wave_speed + p.wave_offset)
        local drift_x = sine_wave * p.wave_amplitude
        
        p.y = p.y + p.speed_y * DT
        p.x = p.x + (p.speed_x + drift_x) * DT
        p.rotation = p.rotation + p.spin * DT
        
        if p.y > SCREEN_HEIGHT + 20 or p.x < -40 or p.x > SCREEN_WIDTH + 400 then 
            table.insert(to_remove, p) 
        end
    end
    for _, p in ipairs(to_remove) do 
        Utils.removeFromTable(self.particles, p)
    end

    self.particle_timer = self.particle_timer + DT
    if self.particle_timer >= 0.04 then 
        self.particle_timer = 0
        
        local size_mult = math.random() * 0.5 + 0.5
        local spawn_x = math.random(-40, SCREEN_WIDTH + 350)
        local spawn_y = -40
        
        if spawn_x > SCREEN_WIDTH then
            spawn_y = math.random(-40, SCREEN_HEIGHT / 2)
        end
        
        table.insert(self.particles, {
            x = spawn_x,
            y = spawn_y,
            size = size_mult * 3,
            timer = 0,
            speed_y = math.random(140, 240) * (size_mult * 1.5),
            speed_x = math.random(-260, -140), 
            gravity = math.random(30, 60),
            friction = math.random() * 0.4 + 0.1,
            wave_speed = math.random(2, 5),
            wave_amplitude = math.random(20, 60),
            wave_offset = math.random() * math.pi * 2,
            rotation = math.random() * math.pi,
            spin = math.random(-2, 2) * (1 - size_mult)
        })
    end
end

function MainMenuTitle:onKeyPressed(key, is_repeat)
    if Input.isConfirm(key) then
        Assets.stopAndPlaySound("ui_select")

        local option = self.options[self.selected_option][1]

        if option == "play" then
            if not TARGET_MOD then
                self.menu:setState("MODSELECT")
            else
                local mod = Kristal.Mods.getMod(TARGET_MOD)

                if (mod["useSaves"] == true) or (mod["useSaves"] == nil and self.has_target_saves) then
                    self.menu:setState("FILESELECT")
                elseif (mod["useSaves"] == false) or (mod["useSaves"] == nil and not self.has_target_saves) then
                    if not Kristal.loadMod(TARGET_MOD, 1) then
                        error("Failed to load mod: " .. TARGET_MOD)
                    end
                end
            end

        elseif option == "modfolder" then
            if (love.system.getOS() == "Windows") then
                os.execute('start /B \"\" \"' .. love.filesystem.getSaveDirectory() .. '/mods\"')
            else
                love.system.openURL("file://" .. love.filesystem.getSaveDirectory() .. "/mods")
            end

        elseif option == "options" then
            self.menu:setState("OPTIONS")

        elseif option == "credits" then
            self.menu:setState("CREDITS")

        elseif option == "wiki" then
            love.system.openURL("https://kristal.cc/wiki")

        elseif option == "quit" then
            love.event.quit()
        end

        return true
    end

    local old = self.selected_option
    if Input.is("up", key) then self.selected_option = self.selected_option - 1 end
    if Input.is("down", key) then self.selected_option = self.selected_option + 1 end
    if Input.is("left", key) and not Input.usingGamepad() then self.selected_option = self.selected_option - 1 end
    if Input.is("right", key) and not Input.usingGamepad() then self.selected_option = self.selected_option + 1 end
    if self.selected_option > #self.options then self.selected_option = is_repeat and #self.options or 1 end
    if self.selected_option < 1 then self.selected_option = is_repeat and 1 or #self.options end

    if old ~= self.selected_option then
        Assets.stopAndPlaySound("ui_move")
    end
    self.menu.heart_target_x = self.x_offset - 19
    self.menu.heart_target_y = (self.y_offset + 18) + 32 * (self.selected_option - 1)
end

function MainMenuTitle:draw()
    local logo_img = self.menu.selected_mod and self.menu.selected_mod.logo or self.logo
    Draw.setColor(1, 1, 1, 1)
    Draw.draw(logo_img, SCREEN_WIDTH / 2, 105, 0, 1.7, 1.7, logo_img:getWidth() / 2, logo_img:getHeight() / 2)
    for _, p in ipairs(self.particles) do
        Draw.setColor(0.7, 0.9, 1.0, 0.6)
        love.graphics.push()
        love.graphics.translate(p.x, p.y)
        love.graphics.rotate(p.rotation)
        love.graphics.rectangle("fill", -p.size/2, -p.size/2, p.size, p.size)
        love.graphics.pop()
    end
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
