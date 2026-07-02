local character, super = Class(PartyMember, "noelle")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Noelle"

    -- Actor (handles sprites)
    self:setActor("noelle")
    self:setLightActor("noelle_lw")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "Snowcaster\nMight be able to\nuse some cool moves."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "N-Action"

    -- Spells
    self:addSpell("heal_prayer")
    self:addSpell("sleep_mist")
    self:addSpell("ice_shock")

    -- Current health (saved to the save file)
    self.health = 166

    -- Base stats (saved to the save file)
    self.stats = {
        health = 166,
        attack = 3,
        defense = 1,
        magic = 11
    }

    -- Max stats from level-ups
    self.max_stats = {
        health = 999
    }
    
    -- Party members which will also get stronger when this character gets stronger, even if they're not in the party
    self.stronger_absent = {}

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/ring"

    -- Equipment (saved to the save file)
    self:setWeapon("thornring")
    self:setArmor(1, "silver_watch")
    if Game.chapter >= 2 then
        self:setArmor(2, "royalpin")
    end

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {1, 1, 0}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {1, 1, 0.3}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {1, 1, 153/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {1, 1, 0}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {1, 1, 0.5}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/noelle/head"
    -- Path to head icons used in battle
    self.head_icons = "party/noelle/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/noelle/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slap_n"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1.5

    -- Battle position offset (optional)
    self.battle_offset = {0, 0}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil

    -- Character flags (saved to the save file)
    self.flags = {
        ["iceshocks_used"] = 0,
        ["boldness"] = (Game.chapter >= 2 and 100 or -12),
        ["weird"] = true
    }
end

function character:getTitle()
    if self:checkWeapon("thornring") then
        return "LV" .. self:getLevel() .. " Ice Trancer\nReceives pain to\nbecome stronger."
    elseif self:getFlag("iceshocks_used", 0) > 0 then
        return "LV" .. self:getLevel() .. " Frostmancer\nFreezes the enemy."
    else
        return super.getTitle(self)
    end
end

function character:onTurnStart(battler)
    if Game.battle.encounter.id == "forced" then 
        Game.battle.timer:afterCond(function() 
            return Game.battle.state == "ACTIONSELECT" and not Game.battle:hasCutscene()
        end, function() 
            if Game.battle.turn_count == 1 then
            Game.battle:nextParty() 
            Game.battle:startCutscene(function(cutscene)
            local noelle = Game.battle:getPartyBattler("noelle")
            noelle:setAnimation({"battle_alt/defend", 0.1, false})
            Assets.playSound("ice_impact")
            cutscene:wait(1)
            local ralsei = Game.battle:getEnemyBattler("ralsei_forced")
            cutscene:battlerText(ralsei, "Why...[wait:5] why did you\ninitiate a battle?") 
            ralsei:setAnimation("attack", function() ralsei:resetSprite() end)
            cutscene:wait(cutscene:playSound("laz_c"))
            noelle:statusMessage("msg", "miss", {0.5, 1, 0.5})
            cutscene:wait(1)
            cutscene:battlerText("* That shield...")
            ralsei:setAnimation("attack", function() ralsei:resetSprite() end)
            cutscene:wait(cutscene:playSound("laz_c"))
            noelle.hit_count = 0 
            noelle:statusMessage("msg", "miss", {0.5, 1, 0.5})
            cutscene:wait(0.5)
            Game.fader:fadeOut(nil, {speed = 1})
            ralsei:setAnimation("attack", function() ralsei:resetSprite() end)
            noelle.hit_count = 0 
            cutscene:wait(cutscene:playSound("laz_c"))
            noelle:statusMessage("msg", "miss", {0.5, 1, 0.5})
            cutscene:wait(0.5)   
            ralsei:setAnimation("attack", function() ralsei:resetSprite() end)
            noelle.hit_count = 0 
            cutscene:wait(cutscene:playSound("laz_c"))
            noelle:statusMessage("msg", "miss", {0.5, 1, 0.5})
            cutscene:wait(1.5)
            cutscene:after(function()
                Game.battle:setState("TRANSITIONOUT")
            end)
            end)
        end
        end)
    end
end

-- function character:onTurnStart(battler)
-- if Game.battle.encounter.id == "forced" then 
--     Game.battle.timer:afterCond(function() 
--         return Game.battle.state == "ACTIONSELECT" and not Game.battle:hasCutscene()
--     end, 
--     function()  
--         local spell = Registry.createSpell("ice_shock")
--         Game.battle:pushForcedAction(battler, "SPELL", Game.battle:getActiveEnemies()[1], nil, {
--             name = spell:getName(),
--             tp = -8, 
--             data = spell
--         })
--     end) 
-- else 
--     Game.battle.timer:afterCond(function() 
--     return Game.battle.state == "ACTIONSELECT" and not Game.battle:hasCutscene()
-- end, function()
--     Game.battle:startCutscene(function(cutscene)
--         Game.battle.battle_ui:clearEncounterText()
--         Game.battle.seen_encounter_text = false
--         Game.battle.current_selecting = 0      
--         local noelle = Game.battle:getPartyBattler("noelle")
--         noelle:resetSprite()
--         noelle:setAnimation("battle/spell", function()
--             noelle:setSprite("battle/spell_9")
--         end)
--         cutscene:wait(cutscene:playSound("error"))  
--         Game.battle.music:fade(0, 0.4)
--         cutscene:wait(0.4)
--         noelle:setAnimation("battle/idle")
--         cutscene:battlerText("noelle", "W-whuh?", {right = true})
--         cutscene:battlerText("noelle", "W-why can't[wait:2] I...", {right = true})
--         cutscene:battlerText("noelle", "...g-get stronger?", {right = true})
--         noelle:resetSprite()
--         noelle:setAnimation("battle/spell", function()
--             noelle:setSprite("battle/spell_9")
--             Assets.playSound("error")
--         end)
--         cutscene:wait(0.9)
--         noelle:setAnimation("battle/idle")
--         cutscene:battlerText("noelle", "N-no,\nthis can't be!", {right = true})
--         cutscene:battlerText("ralsei_forced", "A-are you okay?")
--         -- Game.battle:startCutscene(function(cutscene)
--         cutscene:battlerText("ralsei_forced", "Get stronger...?\nWhat are you talking about?")
--         cutscene:battlerText("noelle", "[speed:2][noskip]Have to [shake:1]PROCEED[shake:0]...", {right = true})
--         -- end)
--         local noelle = Game.battle:getPartyBattler("noelle")
--         local ralsei = Game.battle:getEnemyBattler("ralsei_forced")
--         for i = 1, 6 do 
--             noelle:setAnimation("battle/spell")
--             cutscene:playSound("error")
--             cutscene:wait(math.max(0.1, 0.6 - (i * 0.1)))
--         end 
--         noelle:resetSprite()
--         Assets.playSound("damage")
--         noelle:shake(4)
--         local noelle = Game.battle:getPartyBattler("noelle")
--         noelle:setSprite("kneel_right")
--         cutscene:wait(0.3)
--         cutscene:battlerText("noelle", "I-I can't [shake:1]PROCEED[shake:0]...", {right = true})
--         cutscene:battlerText("noelle", "It hurts so much...", {right = true})
--         cutscene:wait(0.5)
--         cutscene:battlerText("noelle", "I can't let you\nhurt me more.", {right = true})  
--         cutscene:wait(0.2)
--         noelle:setAnimation("battle/spell", function()
--             Assets.playSound("damage")
--             noelle:shake(4)
--             noelle:setSprite("kneel_right")
--         end)
--         local shield = Sprite("effects/shield", noelle.x + 90, noelle.y - 100) 
--         Game.battle:addChild(shield) 
--         shield:setScale(2)
--         shield.scale_x = -2
--         Assets.playSound("ice_impact")
--         shield:play(1/6, false)
--         cutscene:wait(1.8)
--         cutscene:battlerText("noelle", "My hands...\nthey're bleeding...", {right = true})
--         cutscene:battlerText("noelle", "All those other enemies...\n[wait:5]They'd be frozen.", {right = true})
--         cutscene:battlerText("noelle", "Yet you still\nstand in my way.", {right = true})
--         cutscene:wait(1)
--         cutscene:battlerText("ralsei_forced", "Sorry about this,[wait:2]\nbut this is in\nour best interest.")
--         ralsei:setAnimation("spell")
--         cutscene:wait(0.2)
--         local sprite = Sprite("bullets/fire", 505, 130) 
--         Game.battle:addChild(sprite)
--         sprite:setScale(1.3)
--         sprite.alpha = 0
--         Game.battle.timer:tween(0.2, sprite, {alpha = 1})
--         cutscene:wait(0.2)
--         local handle = Game.battle.timer:every(0.01, function()
--             sprite:setScale(sprite.scale_x + 0.01)
--         end)
--         sprite:slideTo(163, 178, 0.4, "out-cubic", function()
--             Game.battle.timer:cancel(handle)
--         end)
--         cutscene:wait(0.3)
--         sprite:fadeOutAndRemove(0.1)
--         shield:fadeOutAndRemove(0.1)
--         ralsei:setAnimation("battle/defend_ready")
--         cutscene:wait(0.1)
--         Assets.playSound("explosion")
--         cutscene:wait(cutscene:fadeOut(0.5, {color = COLORS.white}))
--         noelle:setSprite("collapsed_right")
--         noelle:setPosition(114, 223)
--        -- noelle:setPosition(103, 232)
--         shield:remove()
--         cutscene:wait(cutscene:fadeIn(0.5))
--         noelle:shake(2)
--         cutscene:wait(1.3)
--         ralsei:setSprite("walk/right_1")
--         ralsei:setPosition(536, 230)
--         cutscene:wait(0.3)
--         cutscene:battlerText("ralsei_forced", "(...is she okay?)")
--         cutscene:battlerText("ralsei_forced", "(That ring...)")
--         cutscene:battlerText("ralsei_forced", "(She said it hurt her.)")
--         cutscene:wait(0.1)
--         cutscene:battlerText("ralsei_forced", "(I have to go\ncheck up on her.)")
--         local frame = 1 
--         local walk_timer = Game.battle.timer:every(0.2, function()
--         frame = (frame % 4) + 1
--         ralsei:setSprite("walk/right_" .. frame)
--         end)
--         ralsei:slideTo(189, 230, 2, "linear", function()
--         Game.battle.timer:cancel(walk_timer)
--         ralsei:setSprite("walk/right_1")
-- end)
--         cutscene:wait(2)
--         ralsei:setSprite("grab")
--         ralsei.y = 250
--         Assets.playSound("item")
--         cutscene:wait(1)
--         noelle:shake(2)
--         Assets.playSound("wing")
--         ralsei.y = 230
--         ralsei:setSprite("walk/right_1")
--         frame = 1
--         local walk_timer = Game.battle.timer:every(0.2, function()
--         frame = (frame % 4) + 1
--         ralsei:setSprite("walk/right_" .. frame)
--         end)
--         ralsei:slideTo(250, ralsei.y, 0.8, "linear", function()
--         Game.battle.timer:cancel(walk_timer)
--         ralsei:setSprite("walk/right_1")
-- end)
--         cutscene:wait(0.4)
--         noelle:shake(2)
--         Assets.playSound("wing")
--         Game:getPartyMember("noelle"):setFlag("weird", false)
--         cutscene:wait(1)
--         noelle.y = 232
--         noelle:setSprite("kneel_shocked_right")
--         cutscene:wait(0.2)
--         cutscene:battlerText("noelle", "O-ow..", {right = true})  
--         cutscene:battlerText("noelle", "dhf")
--         cutscene:after(function()
--             Game.battle:setState("TRANSITIONOUT")
--         end)
--     end)
-- end) 
-- end 
-- else 
--     super.onTurnStart(self, battler)
-- end 
-- end

return character
