local character, super = Class(PartyMember, "kris")

function character:init()
    super.init(self)

    self.name = "Kris"

    self:setActor("kris")
    self:setLightActor("kris_lw")
    self:setDarkTransitionActor("kris_dark_transition")

    self.level = 2
    if Game.chapter == 1 then
        self.title = "Leader\nCommands the party\nwith various ACTs."
    elseif Game.chapter == 2 or Game.chapter == 5 then
        self.title = "Tactician\nCommands their\nfriends by ACTs."
    elseif Game.chapter == 3 then
        self.title = "Tactician\nCommands the party\nby ACTs."
    else
        self.title = "Dark Hero\nCarries out fate\nwith the blade."
    end

    self.soul_priority = 2
    self.soul_color = {1, 0, 0}

    self.has_act = true
    self.has_spells = false
    self.has_xact = false 
    self.xact_name = "K-Action"
    if Game.chapter == 1 then
        self.health = 90
    elseif Game.chapter == 2 or Game.chapter == 5 then
        self.health = 160
    elseif Game.chapter == 3 then
        self.health = 160
    else
        self.health = 200
    end
    if Game.chapter == 1 then
        self.stats = {
            health = 90,
            attack = 10,
            defense = 2,
            magic = 0
        }
    elseif Game.chapter == 2 or Game.chapter == 5 then
        self.stats = {
            health = 160,
            attack = 13,
            defense = 4,
            magic = 0
        }
    elseif Game.chapter == 3 then
        self.stats = {
            health = 160,
            attack = 14,
            defense = 2,
            magic = 0
        }
    else
        self.stats = {
            health = 200,
            attack = 17,
            defense = 2,
            magic = 0
        }
    end
    if Game.chapter == 1 then
        self.max_stats = { health = 120 }
    elseif Game.chapter == 2 or Game.chapter == 5 then
        self.max_stats = { health = 240 }
    elseif Game.chapter == 3 then
        self.max_stats = { health = 200 }
    else
        self.max_stats = { health = 240 }
    end
    
    self.stronger_absent = {"kris","susie","ralsei"}
    self.weapon_icon = "ui/menu/equip/sword"

    self:setWeapon("bounceblade")
    self:setArmor(1, "ironshackle")
    self:setArmor(2, "royalpin")
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    self.color = {0, 1, 1}
    self.dmg_color = {0.5, 1, 1}
    self.attack_bar_color = {0, 162/255, 232/255}
    self.attack_box_color = {0, 0, 1}
    self.xact_color = {0.5, 1, 1}

    self.menu_icon = "party/kris/head"
    self.head_icons = "party/kris/icon"
    self.name_sprite = "party/kris/name"
    self.attack_sound = "laz_c"
    self.attack_pitch = 1
    self.battle_offset = {2, 1}

    self.gameover_message = nil
end

function character:getTitle(...)
    if Game:getFlag("geno") then 
        return "LV ? Vessel\nHelpless against\nyour will."
    else 
        return super.getTitle(self, ...)
    end 
end 

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
    end
end

return character
