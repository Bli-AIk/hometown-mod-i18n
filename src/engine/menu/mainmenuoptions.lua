---@class (exact) MainMenuOptions : StateClass, StateManagedClass
---
---@field menu MainMenu
---
---@field state string
---@field state_manager StateManager
---
---@field options table<string, {id: string, name: string, options: {name: string, value: (fun(x:number, y:number):any)?, callback: fun()}[]}>
---@field pages string[]
---
---@field selected_option number
---@field selected_page number
---
---@field heart_x number
---@field scroll_target_y number
---@field scroll_y number
---@field page_scroll_direction string
---@field page_scroll_timer number
---
---@field noise_timer number
---
---@overload fun(menu:MainMenu) : MainMenuOptions
---@class MainMenuOptions : StateClass, StateManagedClass
local MainMenuOptions, super = Class(StateClass)

-- Initialize options with a restricted state manager (only general/graphics)
function MainMenuOptions:init(menu)
    self.menu = menu

    -- 1. Initialize ALL numeric variables to 0 immediately
    self.selected_option = 1
    self.selected_page = 1
    self.heart_x = 0
    self.scroll_target_y = 0
    self.scroll_y = 0
    self.page_scroll_timer = 0
    self.noise_timer = 0
    self.options = {}
    self.pages = {}

    -- 2. Set up the state manager
    self.state_manager = StateManager("MENU", self, true)
    self.state_manager:addState("MENU", { enter = self.onEnterMenu, keypressed = self.onKeyPressedMenu })
    self.state_manager:addState("VOLUME", { enter = self.onEnterSubOption, keypressed = self.onKeyPressedVolume, update = self.updateVolume })
    self.state_manager:addState("BORDER", { enter = self.onEnterSubOption, keypressed = self.onKeyPressedBorder })
    self.state_manager:addState("FPS", { enter = self.onEnterSubOption, keypressed = self.onKeyPressedFPS })
    self.state_manager:addState("WINDOWSCALE", { enter = self.onEnterSubOption, keypressed = self.onKeyPressedWindowScale })

    -- 3. Build the content last
    self:initializeOptions()
end

-- State handling, input, and basic UI setup
function MainMenuOptions:registerEvents()
    self:registerEvent("enter", self.onEnter)
    self:registerEvent("keypressed", self.onKeyPressed)
    self:registerEvent("update", self.update)
    self:registerEvent("draw", self.draw)
end

function MainMenuOptions:onEnter(old_state)
    self.selected_option, self.selected_page = 1, 1
    self.scroll_target_y, self.scroll_y = 0, 0
    self:setState("MENU")
end

function MainMenuOptions:onLeave() self:setState("NONE") end
function MainMenuOptions:onKeyPressed(key, is_repeat) self.state_manager:call("keypressed", key, is_repeat) end

-- dfh
function MainMenuOptions:update()
    local page_id = self.pages[self.selected_page]
    -- If there's no page yet, don't do any math!
    if not page_id or not self.options[page_id] then
        self.state_manager:update()
        return 
    end

    local options = self.options[page_id].options
    local max_option = #options + 1
    
    -- Ensure variables are numbers before comparing
    local target_y = self.scroll_target_y or 0 

    if self.selected_option < max_option then
        local y_off = (self.selected_option - 1) * 32

        if y_off + target_y < 0 then
            self.scroll_target_y = target_y + (0 - (y_off + target_y))
        end
        if y_off + self.scroll_target_y > (9 * 32) then
            self.scroll_target_y = self.scroll_target_y + ((9 * 32) - (y_off + self.scroll_target_y))
        end
    end

    -- Smooth scrolling math
    if (math.abs((self.scroll_target_y - self.scroll_y)) <= 2) then
        self.scroll_y = self.scroll_target_y
    end
    self.scroll_y = self.scroll_y + ((self.scroll_target_y - self.scroll_y) / 2) * (DTMULT or 1)

    if self.page_scroll_timer > 0 then
        self.page_scroll_timer = MathUtils.approach(self.page_scroll_timer, 0, DT)
    end

    -- Update heart position
    self.menu.heart_target_x, self.menu.heart_target_y = self:getHeartPos()

    self.state_manager:update()
end

function MainMenuOptions:draw()
    local menu_font = Assets.getFont("main")

    local page = self.pages[self.selected_page]
    local options = self.options[page].options

    local title = self.options[page].name
    local title_width = menu_font:getWidth(title)

    Draw.setColor(COLORS.silver)
    Draw.printShadow("( OPTIONS )", 0, 0, 2, "center", 640)

    Draw.setColor(1, 1, 1)
    Draw.printShadow(title, 0, 48, 2, "center", 640)

    if self.state == "MENU" and #self.pages > 1 then
        love.graphics.setColor(COLORS.white)

        local l_offset, r_offset = 0, 0

        if self.page_scroll_timer > 0 then
            if self.page_scroll_direction == "left" then
                l_offset = -4
            elseif self.page_scroll_direction == "right" then
                r_offset = 4
            end
        end

        if self.selected_page >= #self.pages then
            Draw.setColor(COLORS.silver, 0.5)
        else
            Draw.setColor(COLORS.white)
        end
        Draw.draw(Assets.getTexture("kristal/menu_arrow_right"), 320 + (title_width / 2) + 8 + r_offset, 52, 0, 2, 2)

        if self.selected_page == 1 then
            Draw.setColor(COLORS.silver, 0.5)
        else
            Draw.setColor(COLORS.white)
        end
        Draw.draw(Assets.getTexture("kristal/menu_arrow_left"), 320 - (title_width / 2) - 26 + l_offset, 52, 0, 2, 2)

        Draw.setColor(COLORS.white)
    end

    local menu_x = 185 - 14
    local menu_y = 110

    local width = 360
    local height = 32 * 10
    local total_height = 32 * #options

    Draw.pushScissor()
    Draw.scissor(menu_x, menu_y, width + 10, height + 10)

    menu_y = menu_y + self.scroll_y

    for i, option in ipairs(options) do
        local y = menu_y + 32 * (i - 1)

        Draw.printShadow(option.name, menu_x, y)

        local value_x = menu_x + (32 * 8)
        local value = option.value and option.value(value_x, y) or nil

        if value then
            Draw.printShadow(tostring(value), value_x, y)
        end
    end

    -- Draw the scrollbar background if the menu scrolls
    if total_height > height then
        Draw.setColor({ 0, 0, 0, 0.5 })
        love.graphics.rectangle("fill", menu_x + width, 0, 4, menu_y + height - self.scroll_y)

        local scrollbar_height = (height / total_height) * height
        local scrollbar_y = (-self.scroll_y / (total_height - height)) * (height - scrollbar_height)

        Draw.popScissor()
        Draw.setColor(1, 1, 1, 1)
        love.graphics.rectangle("fill", menu_x + width, menu_y + scrollbar_y - self.scroll_y, 4, scrollbar_height)
    else
        Draw.popScissor()
    end

    Draw.printShadow("Back", 0, 454 - 8, 2, "center", 640)

    self.state_manager:draw()
end

-------------------------------------------------------------------------------
-- Substate Callbacks
-------------------------------------------------------------------------------

function MainMenuOptions:onEnterMenu()
    self.heart_x = 0
end

function MainMenuOptions:onEnterSubOption()
    self.heart_x = 256
end

function MainMenuOptions:onKeyPressedMenu(key, is_repeat)
    if Input.isCancel(key) then
        Assets.stopAndPlaySound("ui_move")

        Kristal.saveConfig()

        self.menu:setState("TITLE")
        self.menu.title_screen:selectOption("options")
        return
    end

    local move_noise = false

    local page_dir = "right"
    local old_page = self.selected_page
    if Input.is("left", key) then
        self.selected_page = self.selected_page - 1
        page_dir = "left"
    end
    if Input.is("right", key) then
        self.selected_page = self.selected_page + 1
        page_dir = "right"
    end
    self.selected_page = MathUtils.clamp(self.selected_page, 1, #self.pages)

    if self.selected_page ~= old_page then
        move_noise = true
        self.selected_option = 1
        self.scroll_target_y = 0
        self.scroll_y = 0
        self.page_scroll_direction = page_dir
        self.page_scroll_timer = 0.1
    end

    local page = self.pages[self.selected_page]
    local options = self.options[page].options
    local max_option = #options + 1

    local old_option = self.selected_option
    if Input.is("up", key) then self.selected_option = self.selected_option - 1 end
    if Input.is("down", key) then self.selected_option = self.selected_option + 1 end
    if self.selected_option > max_option then self.selected_option = is_repeat and max_option or 1 end
    if self.selected_option < 1 then self.selected_option = is_repeat and 1 or max_option end

    if old_option ~= self.selected_option then
        move_noise = true
    end

    if move_noise then
        Assets.stopAndPlaySound("ui_move")
    end

    if Input.isConfirm(key) then
        Assets.stopAndPlaySound("ui_select")

        if self.selected_option == max_option then
            -- "Back" button
            Kristal.saveConfig()

            self.menu:setState("TITLE")
            self.menu.title_screen:selectOption("options")
        else
            options[self.selected_option].callback()
        end
    end
end

function MainMenuOptions:onKeyPressedVolume(key, is_repeat)
    if Input.isCancel(key) or Input.isConfirm(key) then
        Kristal.setVolume(MathUtils.round(Kristal.getVolume() * 100) / 100)

        Assets.stopAndPlaySound("ui_select")
        self:setState("MENU")
    end
end

function MainMenuOptions:onKeyPressedBorder(key, is_repeat)
    if Input.isCancel(key) or Input.isConfirm(key) then
        Assets.stopAndPlaySound("ui_select")
        self:setState("MENU")
    end

    local types = Kristal.getBorderTypes()

    local border_index = -1
    for current_index, border in ipairs(types) do
        if border[1] == Kristal.Config["borders"] then
            border_index = current_index
        end
    end
    if border_index == -1 then
        border_index = 1
    end

    local old_index = border_index
    if Input.is("left", key) then
        border_index = math.max(border_index - 1, 1)
    end
    if Input.is("right", key) then
        border_index = math.min(border_index + 1, #types)
    end

    if old_index ~= border_index then
        Assets.stopAndPlaySound("ui_move")

        Kristal.Config["borders"] = types[border_index][1]

        if types[border_index][1] == "off" then
            Kristal.resetWindow()
        elseif types[old_index][1] == "off" then
            Kristal.resetWindow()
        end
    end
end

function MainMenuOptions:onKeyPressedFPS(key, is_repeat)
    if Input.isCancel(key) or Input.isConfirm(key) then
        FRAMERATE = Kristal.Config["fps"]

        Assets.stopAndPlaySound("ui_select")
        self:setState("MENU")
    end

    if Input.is("left", key) then
        Assets.stopAndPlaySound("ui_move")

        if FRAMERATE == 0 or FRAMERATE > 240 then
            FRAMERATE = 240
        elseif FRAMERATE > 144 then
            FRAMERATE = 144
        elseif FRAMERATE > 120 then
            FRAMERATE = 120
        elseif FRAMERATE > 60 then
            FRAMERATE = 60
        elseif FRAMERATE > 30 then
            FRAMERATE = 30
        else
            FRAMERATE = 0
        end

        Kristal.Config["fps"] = FRAMERATE
    elseif Input.is("right", key) then
        Assets.stopAndPlaySound("ui_move")

        if FRAMERATE < 30 then
            FRAMERATE = 30
        elseif FRAMERATE < 60 then
            FRAMERATE = 60
        elseif FRAMERATE < 120 then
            FRAMERATE = 120
        elseif FRAMERATE < 144 then
            FRAMERATE = 144
        elseif FRAMERATE < 240 then
            FRAMERATE = 240
        else
            FRAMERATE = 0
        end

        Kristal.Config["fps"] = FRAMERATE
    end
end

function MainMenuOptions:onKeyPressedVolume(key, is_repeat)
    if Input.isCancel(key) or Input.isConfirm(key) then
        Kristal.setVolume(MathUtils.round(Kristal.getVolume() * 100) / 100)
        Assets.stopAndPlaySound("ui_select")
        self:setState("MENU")
    end
end

function MainMenuOptions:updateVolume()
    self.noise_timer = self.noise_timer + DTMULT

    if Input.down("left") then
        Kristal.setVolume(Kristal.getVolume() - ((2 * DTMULT) / 100))
        if self.noise_timer >= 3 then
            self.noise_timer = self.noise_timer - 3
            Assets.stopAndPlaySound("noise")
        end
    end

    if Input.down("right") then
        Kristal.setVolume(Kristal.getVolume() + ((2 * DTMULT) / 100))
        if self.noise_timer >= 3 then
            self.noise_timer = self.noise_timer - 3
            Assets.stopAndPlaySound("noise")
        end
    end

    if (not Input.down("right")) and (not Input.down("left")) then
        self.noise_timer = 3
    end
end

-------------------------------------------------------------------------------
-- Class Methods
-------------------------------------------------------------------------------

function MainMenuOptions:setState(state, ...)
    self.state_manager:setState(state, ...)
end

function MainMenuOptions:getHeartPos()
    local page = self.pages[self.selected_page]
    local options = self.options[page].options
    local max_option = #options + 1

    local x, y = 152, 129

    if self.selected_option < max_option then
        x = 152
        y = 129 + (self.selected_option - 1) * 32 + self.scroll_target_y
    else
        -- "Back" button
        x = 320 - 32 - 16 + 1
        y = 480 - 16 + 1
    end

    return x + self.heart_x, y
end

--- Adds a page to the options menu.
---@param id   string # The id of the page, referred to when adding options.
---@param name string # The name of the page, displayed in the options menu.
function MainMenuOptions:registerOptionsPage(id, name)
    if TableUtils.contains(self.pages, id) then
        return
    end

    table.insert(self.pages, id)

    self.options[id] = {
        id = id,
        name = name,
        options = {}
    }
end

--- Adds an option to the menu's options list.
---@param page     string|string[]             # The page (or pages) the option should be added to. Must be registered with `registerOptionsPage` first.
---@param name     string                      # The name of the option, displayed in the options list.
---@param value?   fun(x:number, y:number):any # A function which is called to get the value displayed for the option.
---@param callback fun()                       # A function called when the user selects this option.
function MainMenuOptions:registerOption(page, name, value, callback)
    local pages = type(page) == "table" and page or { page }

    for _, page_id in ipairs(pages) do
        table.insert(self.options[page_id].options, {
            name = name,
            value = value,
            callback = callback
        })
    end
end

--- *(Called internally)*
--- Convenience method to add a menu option based on a config option which is toggled on and off.
---@param page   string|string[]         # The page (or pages) the option should be added to. Must be registered with `registerOptionsPage` first.
---@param name   string                  # The name of the option, displayed in the options list.
---@param config string                  # The config option to toggle.
---@param callback? fun(toggled:boolean) # Additional callback for when the option is toggled.
function MainMenuOptions:registerConfigOption(page, name, config, callback)
    self:registerOption(
        page,
        name,
        function()
            return Kristal.Config[config] and "ON" or "OFF"
        end, function()
            Kristal.Config[config] = not Kristal.Config[config]
            if callback then
                callback(Kristal.Config[config])
            end
        end
    )
end

function MainMenuOptions:initializeOptions()
    self:registerOptionsPage("general", "GENERAL")
    self:registerOptionsPage("graphics", "GRAPHICS")

    ---------------------
    -- General Options
    ---------------------

    self:registerOption(
        "general",
        "Master Volume",
        function()
            return MathUtils.round(Kristal.getVolume() * 100) .. "%"
        end,
        function()
            self:setState("VOLUME")
        end
    )

    local function enterControls(type)
        self.menu:pushState("CONTROLS", type)
    end
    self:registerOption("general", "Keyboard Controls", nil, function() enterControls("keyboard") end)
    self:registerOption("general", "Gamepad Controls", nil, function() enterControls("gamepad") end)

    self:registerConfigOption("general", "Auto-Run", "autoRun")

    self:registerConfigOption("general", "Discord RPC", "discordRPC", function(toggled)
        if DISCORD_RPC_AVAILABLE then
            if toggled then
                DiscordRPC.initialize(DISCORD_RPC_ID, true)
                DiscordRPC.updatePresence(Kristal.getPresence())
            else
                DiscordRPC.shutdown()
            end
        end
    end)
    self:registerConfigOption({"graphics" }, "Simplify VFX", "simplifyVFX")

    self:registerOption(
        "graphics",
        "Target FPS",
        function(x, y)
            if Kristal.Config["fps"] > 0 then
                return Kristal.Config["fps"]
            else
                -- Drawing the infinity symbol for uncapped FPS
                Draw.setColor(0, 0, 0)
                Draw.draw(Assets.getTexture("kristal/menu_infinity"), x + 2, y + 11, 0, 2, 2)
                Draw.setColor(1, 1, 1)
                Draw.draw(Assets.getTexture("kristal/menu_infinity"), x, y + 9, 0, 2, 2)
            end
        end, function()
            self:setState("FPS")
        end
    )

    self:registerConfigOption(
        "graphics",
        "VSync",
        "vSync",
        function(toggled)
            love.window.setVSync(toggled and 1 or 0)
        end)
    end

return MainMenuOptions
