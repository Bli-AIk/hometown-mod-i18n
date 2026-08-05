return {
    ---@param cutscene WorldCutscene
    credits = function(cutscene) 
        Game.fader:fadeOut(nil, {speed = 0.5})

        local active_credits = {}

        local function ctext(str, x, y, color, sy, stop_at)
            local txt = DialogueText("[noskip][instant][voice:none]" .. str, x or 10, y or 60) 
            if color then txt:setColor(color) end 
            txt:setParallax(0, 0)
            txt.layer = 9999
            txt.physics.speed_y = sy or 4 
            Game.stage:addChild(txt)
            table.insert(active_credits, txt)
            if stop_at then
                local base_update = txt.update
                txt.update = function(self)
                    base_update(self)
                    local current_val = self[stop_at.axis]
                    local reached = false
                    if stop_at.comparison == ">=" and current_val >= stop_at.target then reached = true end
                    if stop_at.comparison == "<=" and current_val <= stop_at.target then reached = true end
                    if reached then
                        self:resetPhysics()
                    end
                end
            end
            return txt 
        end

        local text = ctext("Credits", 480, -50, COLORS.yellow, 2, {axis = "y", target = 40, comparison = ">="}) 
        cutscene:wait(1.7)

        local dev = ctext("Main Developer", -200, 118, COLORS.orange, 0)
        dev.physics.speed_x = 4 
        local base_dev_up = dev.update
        dev.update = function(self)
            base_dev_up(self)
            if self.x >= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(1.7)

        local fluff = ctext("fluffyboy", 700, 150, nil, 0)
        fluff.physics.speed_x = -18
        local base_fluff_up = fluff.update
        fluff.update = function(self)
            base_fluff_up(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.15)

        cutscene:wait(function() return fluff.physics.speed_x == 0 end)
        cutscene:wait(1.5)
        fluff.physics.speed_y = 6
        dev.physics.speed_y = 6

        local ideas = ctext("Ideas and Cutscenes", -270, 118, COLORS.orange, 0)
        ideas.physics.speed_x = 4 
        local base_ideas_up = ideas.update
        ideas.update = function(self)
            base_ideas_up(self)
            if self.x >= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(1.7)
        local i_fluff = ctext("fluffyboy", 700, 150, nil, 0)
        i_fluff.physics.speed_x = -18
        local base_i_fluff = i_fluff.update
        i_fluff.update = function(self)
            base_i_fluff(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        local i_golden = ctext("~Golden Flower Petals~", 700, 180, nil, 0)
        i_golden.physics.speed_x = -18
        local base_i_golden = i_golden.update
        i_golden.update = function(self)
            base_i_golden(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        local i_memory = ctext("Gamer12", 700, 210, nil, 0)
        i_memory.physics.speed_x = -18
        local base_i_memory = i_memory.update
        i_memory.update = function(self)
            base_i_memory(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        local i_zenore = ctext("Zenore", 700, 240, nil, 0)
        i_zenore.physics.speed_x = -18
        local base_i_zenore = i_zenore.update
        i_zenore.update = function(self)
            base_i_zenore(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        cutscene:wait(function() return i_zenore.physics.speed_x == 0 end)
        cutscene:wait(0.5)
        ideas.physics.speed_y = 6
        i_fluff.physics.speed_y = 6
        i_golden.physics.speed_y = 6
        i_memory.physics.speed_y = 6
        i_zenore.physics.speed_y = 6
        cutscene:wait(0.5)

        local map_designer = ctext("Map Designer", -200, 118, COLORS.orange, 0)
        map_designer.physics.speed_x = 4 
        local base_map_up = map_designer.update
        map_designer.update = function(self)
            base_map_up(self)
            if self.x >= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(1.7)
       local map_golden = ctext("~Golden Flower Petals~", 700, 150, nil, 0)
map_golden.physics.speed_x = -18
local base_map_golden = map_golden.update
map_golden.update = function(self)
    base_map_golden(self)
    if self.x <= 50 then self.physics.speed_x = 0 end
end
cutscene:wait(0.15)

local map_angello = ctext("Angello(potentially)", 700, 180, nil, 0)
map_angello.physics.speed_x = -18
local base_map_angello = map_angello.update
map_angello.update = function(self)
    base_map_angello(self)
    if self.x <= 50 then self.physics.speed_x = 0 end
end
cutscene:wait(0.15)

local map_other = ctext("other map designer :P", 700, 210, nil, 0)
map_other.physics.speed_x = -18
local base_map_other = map_other.update
map_other.update = function(self)
    base_map_other(self)
    if self.x <= 50 then self.physics.speed_x = 0 end
end

cutscene:wait(function() return map_other.physics.speed_x == 0 end)
cutscene:wait(1.5) 
        map_designer.physics.speed_y = 6
        map_golden.physics.speed_y = 6
        map_angello.physics.speed_y = 6
        map_other.physics.speed_y = 6
        cutscene:wait(1.5)
        local music = ctext("Composers", -200, 118, COLORS.orange, 0)
        music.physics.speed_x = 4 
        local base_music_up = music.update
        music.update = function(self)
            base_music_up(self)
            if self.x >= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(1.7)

        local music_charlie = ctext("Charlie Emily", 700, 150, nil, 0)
        music_charlie.physics.speed_x = -18
        local base_m_charlie = music_charlie.update
        music_charlie.update = function(self)
            base_m_charlie(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        local music_hybrid = ctext("hybridcenentri", 700, 180, nil, 0)
        music_hybrid.physics.speed_x = -18
        local base_m_hybrid = music_hybrid.update
        music_hybrid.update = function(self)
            base_m_hybrid(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        cutscene:wait(function() return music_hybrid.physics.speed_x == 0 end)
        cutscene:wait(0.5)
        music.physics.speed_y = 6
        music_charlie.physics.speed_y = 6
        music_hybrid.physics.speed_y = 6
        cutscene:wait(1.5)

        local testers = ctext("Playtesters", -200, 118, COLORS.orange, 0)
        testers.physics.speed_x = 4 
        local base_testers_up = testers.update
        testers.update = function(self)
            base_testers_up(self)
            if self.x >= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(1.7)

        local t_charlie = ctext("Charlie Emily", 700, 150, nil, 0)
        t_charlie.physics.speed_x = -18
        local base_t_charlie = t_charlie.update
        t_charlie.update = function(self)
            base_t_charlie(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        local t_gamer = ctext("Gamer12", 700, 180, nil, 0)
        t_gamer.physics.speed_x = -18
        local base_t_gamer = t_gamer.update
        t_gamer.update = function(self)
            base_t_gamer(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        local t_hybrid = ctext("hybridcenentri", 700, 210, nil, 0)
        t_hybrid.physics.speed_x = -18
        local base_t_hybrid = t_hybrid.update
        t_hybrid.update = function(self)
            base_t_hybrid(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        local t_jorge = ctext("jorge.95s", 700, 240, nil, 0)
        t_jorge.physics.speed_x = -18
        local base_t_jorge = t_jorge.update
        t_jorge.update = function(self)
            base_t_jorge(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        local t_starboy = ctext("Starboy", 700, 270, nil, 0)
        t_starboy.physics.speed_x = -18
        local base_t_starboy = t_starboy.update
        t_starboy.update = function(self)
            base_t_starboy(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        local t_terrius = ctext("terriustranquility", 700, 300, nil, 0)
        t_terrius.physics.speed_x = -18
        local base_t_terrius = t_terrius.update
        t_terrius.update = function(self)
            base_t_terrius(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        cutscene:wait(function() return t_terrius.physics.speed_x == 0 end)
        cutscene:wait(1.5)
        testers.physics.speed_y = 6
        t_charlie.physics.speed_y = 6
        t_gamer.physics.speed_y = 6
        t_hybrid.physics.speed_y = 6
        t_jorge.physics.speed_y = 6
        t_starboy.physics.speed_y = 6
        t_terrius.physics.speed_y = 6
        cutscene:wait(1.5)

        local sprite_art = ctext("Sprite Artists", -200, 118, COLORS.orange, 0)
        sprite_art.physics.speed_x = 4 
        local base_sprite_up = sprite_art.update
        sprite_art.update = function(self)
            base_sprite_up(self)
            if self.x >= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(1.7)

        local s_fluff = ctext("fluffyboy", 700, 150, nil, 0)
        s_fluff.physics.speed_x = -18
        local base_s_fluff = s_fluff.update
        s_fluff.update = function(self)
            base_s_fluff(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

        local s_golden = ctext("~Golden Flower Petals~", 700, 180, nil, 0)
        s_golden.physics.speed_x = -18
        local base_s_golden = s_golden.update
        s_golden.update = function(self)
            base_s_golden(self)
            if self.x <= 50 then self.physics.speed_x = 0 end
        end
        cutscene:wait(0.2)

local s_zenore = ctext("Zenore", 700, 210, nil, 0)
s_zenore.physics.speed_x = -18
local base_s_zenore = s_zenore.update
s_zenore.update = function(self)
    base_s_zenore(self)
    if self.x <= 50 then self.physics.speed_x = 0 end
end
cutscene:wait(0.2)

cutscene:wait(function() return s_zenore.physics.speed_x == 0 end)
cutscene:wait(0.5)

sprite_art.physics.speed_y = 6
s_fluff.physics.speed_y = 6
s_golden.physics.speed_y = 6
s_zenore.physics.speed_y = 6
cutscene:wait(1.5)

local tileset = ctext("Tileset Artist", -200, 118, COLORS.orange, 0)
tileset.physics.speed_x = 4
local base_tileset_up = tileset.update
tileset.update = function(self)
    base_tileset_up(self)
    if self.x >= 50 then self.physics.speed_x = 0 end
end
cutscene:wait(1.7)

local tileset_golden = ctext("~Golden Flower Petals~", 700, 150, nil, 0)
tileset_golden.physics.speed_x = -18
local base_golden_up = tileset_golden.update
tileset_golden.update = function(self)
    base_golden_up(self)
    if self.x <= 50 then self.physics.speed_x = 0 end
end
cutscene:wait(0.2)

cutscene:wait(function() return tileset_golden.physics.speed_x == 0 end)
cutscene:wait(0.5)

tileset.physics.speed_y = 6
tileset_golden.physics.speed_y = 6
cutscene:wait(2.5)

for _, text_instance in ipairs(active_credits) do
    text_instance:fadeOutSpeedAndRemove(0.5)
end 
cutscene:wait(0.5)
local ty = DialogueText("[font:plain][color:yellow]And thank you for\nplaying our game!")
ty:setPosition(233, 213)
Game.stage:addChild(ty)
ty:setLayer(9999)
cutscene:wait(function() return not ty:isTyping() end)
cutscene:wait(1)
Game.fader:fadeIn(nil, {speed = 0.5})
ty:fadeOutSpeedAndRemove(0.5)
end 

}