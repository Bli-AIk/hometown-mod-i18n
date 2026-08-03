local ralsei, super = Class(EnemyBattler)

function ralsei:init()
    super.init(self)

    self.name = "Ralsei"
    self:setActor("enemy_ralsei")

    self.max_health = 280
    self.health = 280
    self.attack = 15
    self.ui_modified = false
    self.defense = 12
    self.money = 63
    self.dmg_sprite_offset = {-14, 13}
    self.tired_percentage = 0
    self.mercy = 100  
    self.spare_points = 20 
    self.wave_index = 1

    self.waves = {
        "ralsei/fire_spin", 
        "ralsei/manual_throw", 
        "ralsei/star_rain"
    }
    self.vig = Sprite("world/evil_fucking_vignette", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
    self.vig.layer = 9999
    self.vig.alpha = 0
    self.vig:setScale(2)
    self.vig:setOrigin(0.5, 0.5)
    self.vig:setParallax(0, 0)
    self.vig:addFX(ShaderFX(Mod.wave_shader, {
            ["wave_sine"] = function () return Kristal.getTime() * 100 end,
            ["wave_mag"] = 2,
            ["wave_height"] = 10,
            ["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
        }), "funky_mode")

    self.dialogue_offset = {-60, 5}
    self.dialogue = {}
    TableUtils.merge(self.actor.animations, {
        ["hurt"] = {"battle/hurt", 0.1, false}
    }, false)

    self.check = "AT "..self.attack.." DF "..self.defense.."\n* The dark prince, seemingly lost in his own dark."

    self.text_alt = {
        "* Fire emanates from the floor.",
        "* Smells like burnt friendship.",
        "* You shiver a little,[wait:2] even though it isn't cold.", 
        "* Hospital alarms seem to blare even louder,[wait:5] seemingly closer.", 
        "* Is it too late go back.[wait:2].[wait:2].[wait:2]?", 
        "* The heat is unsettling.[wait:5]\n* You start to feel dizzy."
    }

    self.text = {
        "* Ralsei looks at you nervously.", 
        "* Hospital alarms seem to blare\nin the distance.", 
        "* A tingling feeling in your stomach starts to rise.", 
        "* Smells like charcoal."
    }

    self:registerAct("Apologize")
    -- self:registerAct("???", "...")
    -- self.acts[3].color = {COLORS.red}
end


function ralsei:onAct(battler, name)
    if name == "Apologize" then
        local ap = self.apologize or 0 
        if not self:getFlag("dead") then 
            return {
            "* You apologized to Ralsei.",
            "* Nothing happened."
        }
        end 
        if ap == 0 then  
        self.apologize = ap + 1 
        return {
            "* You apologized to Ralsei.",
            "* Nothing happened."
        }
    elseif ap == 1 then 
        self.apologize = ap + 1 
        return { 
            "* You apologized about starting a battle with him.", 
            "* Ralsei looks at you.", 
            "* (Nothing seems to happen...)[wait:5]\n* (Try apologizing again!)"
        }
    elseif ap == 2 then 
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* Kris sincerely apologized to\nRalsei.")
            Game.battle.music:fade(0, 0.5)
            cutscene:wait(0.5)
            Assets.playSound("mercyadd")
            cutscene:text("* Kris tried to spare Ralsei.")
            self:mercyFlash()
            cutscene:wait(0.5)
            self.vig:fadeTo(0, 0.5)
            Game.stage:removeFX("shiftfx")
            Game.battle.background:remove()
            cutscene:wait(0.5)
            Game:getPartyMember("ralsei"):setFlag("serious", false)
            self:setAnimation("idle")
            cutscene:text("* K[wait:2]-Kris?\n* You're...[wait:5] sparing me...?", "blush", "ralsei")
            self:addMercy(100)
            cutscene:text("* W[wait:2]-well,[wait:2] that was unexpected...", "blush_pleased_open", "ralsei")
            cutscene:after(function()
                Game.battle.tired_bar:slideTo(-300, Game.battle.tired_bar.y, 1)
                self:spare()
                self:setFlag("spared", true)
                Game.battle:setState("VICTORY")
            end)
        end) 
    end 

    elseif name == "WakeUp" then 
    Game.battle.tired_bar:addTired(-16)
    Assets.playSound("bell_bounce_short")
    return "* Kris rubbed their eyes and gripped their sword tighter![wait:5]\n* [color:blue]TIREDNESS[color:reset] reduced!"

    elseif name == "CallOut" then  
        Game.battle:startActCutscene(function(cutscene)
        cutscene:text("* Kris screamed out across the fire\nin agony.")
        self:sendAngel()
        cutscene:wait(3.5)
        cutscene:text("* ...", "disappointed_down", "ralsei")
    end)
    
    elseif name == "???" then 
        Game.battle:startActCutscene(function(cutscene)
            Game.battle.music:play("d")
            self.exit_on_defeat = false 
            Game.battle.music:setVolume(0)
            Game.battle.music:fade(1, 0.5)
            cutscene:wait(1)
            battler:setAnimation("battle/idle")
            Assets.playSound("break1", 0.6, 0.8)
            battler:shake(3, 0)
            cutscene:wait(25/30)      
            Assets.playSound("boost")
            local fx = battler:addFX(ColorMaskFX(COLORS.white))
            Game.battle.timer:tween(0.5, fx, {amount = 0})
            for i = 1, 2 do 
                battler:addFX(OutlineFX(COLORS.maroon), "fx"..i.."") 
            end 
            battler:setAnimation("battle/attack_ready")
            cutscene:wait(15/30)
            local ralsei = Game.battle:getEnemyBattler("ralsei")
            ralsei:setSprite("what")
            ralsei.scale_x = -2 
            ralsei.y = ralsei.y + 14
            ralsei.dialogue_offset = {0, -5}
            cutscene:battlerText(ralsei, "Kris,[wait:5] why are you...?")
            cutscene:battlerText(ralsei, "Let's just... talk-[next]")
            battler:shake()
            cutscene:wait(cutscene:playSound("break1"))
            Game.battle.music:fade(0, 1)
            self.vig:fadeOutAndRemove(1)
            Game.battle.background:remove()
            Game.stage:removeFX("shiftfx")
            cutscene:wait(1)
            cutscene:battlerText(ralsei, "(I can't let them...)")
            Assets.playSound("wing")
            ralsei:resetSprite()
            ralsei.scale_x = 2 
            ralsei.y = 285 -- 271
            ralsei.x = ralsei.x 
            ralsei:setSprite("walk/left_1")
            cutscene:wait(0.5)
            Assets.playSound("escaped")
            ralsei:setSprite("walk/left")
            ralsei.sprite:play(0.1, true)
            battler:removeFX("fx1")
            battler:removeFX("fx2")
            battler:resetSprite()
            ralsei:slideTo(700, ralsei.y, 1.2)
            cutscene:wait(2)
            ralsei.visible = false
            Game:setFlag("encounter#ralsei:violenced", true) 
            cutscene:after(function()
                Game:setFlag("geno", true)
                Game.battle.tired_bar:slideTo(-300, Game.battle.tired_bar.y, 1)
                Game.battle:setState("TRANSITIONOUT")
            end)
            end)
    end
    return super.onAct(self, battler, name)
end

function ralsei:sendAngel()
    self:setAnimation("spell", function()
        local sx, sy = self:getRelativePos(0, 0, Game.battle)
        local sprite = Sprite("effects/angelmove", sx - 72, sy - 40)
        sprite:setScale(2)
        Game.battle:addChild(sprite)
        local snd = Assets.playSound("spell_cure_slight_smaller")
        sprite.alpha = 0
        sprite:fadeTo(1, 0.2, function()
        local old_update = sprite.update
        local wave_offset = love.math.random() * math.pi * 2
        local start_y = sprite.y
        local timealive = 0 
        sprite:setSprite("effects/angel")
        sprite:play(0.08, true)
        sprite.update = function(spelf)
            old_update(spelf)
            timealive = timealive + DT 
            local wave_movement = math.sin((timealive * 6) + wave_offset) * 9
            spelf.y = start_y + wave_movement
        end 
        sprite:slideTo(114, 151, 1.8, "linear", function()
            Assets.playSound("sparkle_glock")
            Game.battle.tired_bar:addTired(-32)
            for _, mem in ipairs(Game.battle.party) do 
                mem:healEffect()
                mem:heal(MathUtils.round(mem.chara:getStat("health")/3))
            end 
            sprite.physics.speed_y = -4 
            sprite:fadeTo(0, 0.5)
            sprite.update = function(spelf)
            old_update(spelf)
            end 
        end)
        end) 
    end)
end  


function ralsei:onDefeat()
if not Game.battle:hasCutscene() then 
   if self:getFlag("dead") then 
    self:getActiveSprite():resetSprite()
    self.y = self.y + 20 
    self:getActiveSprite():setSprite("battle_alt/hurt_1")
        Game.battle:startCutscene(function(cutscene)
            Game.battle.battle_ui:endAttack()
            self.exit_on_defeat = false 
            self:setSprite("battle_alt/hurt_1")
            Game.battle.background:remove()
            Game.battle.music:fade(0, 2)
            local current_color = {self.vig:getDrawColor()}
            local shifted_color = ColorUtils.mergeColor(current_color, COLORS.gray, 0.5)
            local fx = ColorMaskFX(shifted_color, 0)
            self.vig:addFX(fx)
            Game.battle.timer:tween(2, fx, {amount = 1})
            cutscene:wait(2)
            cutscene:setSpeaker("ralsei")
            cutscene:text("* Y-[wait:2]you really think you won,[wait:5] don't you?", "roaring")
            cutscene:text("* Not Kris,[wait:5] you, the [color:red]SOUL[color:reset].", "roaring", "ralsei")
            Game.fader:fadeOut(nil, {speed = 0.5})
            Game.battle.music:play("deltarune/flashback_excerpt")
            Game.battle.music:setPitch(0.8)
            Game.battle.music:fade(1, 0.5)
            local sprite = Sprite("party/ralsei/dark/walk/down_1", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
            sprite.alpha = 0 
            sprite:fadeTo(1, 0.5)
            sprite:setScale(2)
            sprite:setOrigin(0.5, 0.5)
            sprite:addFX(ColorMaskFX())
            Game.stage:addChild(sprite)
            sprite.layer = 9999
            cutscene:wait(0.5)
            local function gonerTextFade(text)
            Game.stage.timer:tween(1, text, { alpha = 0 }, "linear", function() text:remove() end)
            cutscene:wait(1) 
            end   
            local function rtext(str, x, y)
            local txt = DialogueText("[noskip][voice:ralsei]" ..str, x or 110, y or 345) 
            txt:setParallax(0, 0)
            txt.layer = 9999
            Game.stage:addChild(txt)
            cutscene:wait(function() return not txt:isTyping() end)
            gonerTextFade(txt)
            end 
            Game.stage:removeFX("shiftfx")
            self.vig:remove()
            cutscene:wait(1)
            rtext("You see, I knew exactly what\nyou were doing to her.")
            rtext("Everything...[wait:5]\ncovered in a blanket of ice.")
            rtext("But seeing Kris safe...\n[wait:10]that was all that mattered\nto me.")
            sprite:slideTo(sprite.x - 70, sprite.y, 0.5)
            local n_sprite = Sprite("party/noelle/dark/head_lowered", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
            n_sprite.alpha = 0 
            n_sprite:fadeTo(1, 0.5)
            n_sprite:setScale(2)
            n_sprite:setOrigin(0.5, 0.5)
            n_sprite:addFX(ColorMaskFX())
            n_sprite.layer = 9999
            Game.stage:addChild(n_sprite)
            cutscene:wait(0.5)
            rtext("Yet,[wait:5] poor Noelle was\ntrapped in an eternal nightmare.")
            rtext("Attacking everything,[wait:5] even me!", 80)
            n_sprite:fadeOutAndRemove(0.5)
            sprite:slideTo(sprite.x + 70, sprite.y, 0.5)
            cutscene:wait(0.5)
            rtext("I tried so hard to change your\nfate,[wait:5] Kris.[wait:10]\nI really did.")
            rtext("So...[wait:3] Kris?[wait:5] Please hear me.")
            rtext("I don't blame you for any of this.", 64)
            cutscene:wait(1)
            rtext("Keep fighting,[wait:5] Kris.\n[wait:5]Don't let your own voice\ngo completely quiet.", 147, 319)
            Game.battle.music:fade(0, 0.5)
            Game.fader:fadeIn(nil, {speed = 0.5})
            sprite:fadeOutAndRemove(0.5)
            cutscene:wait(1)
            Game:setFlag("encounter#ralsei:violenced", true) 
            self:shake(2)
            Assets.playSound("damage")
            Assets.playSound("levelup")
            Game.battle.tired_bar:slideTo(-300, Game.battle.tired_bar.y, 1)
            self:onDefeatFatal()
            self.x = self.x + 50 
            self.scale_x = -2 
        end) 
   end
end
end       

function ralsei:spellEffectHeal()
    self:resetSprite()
    self:setAnimation("spell")
    self.hit_count = 0 
    self:heal(45)
     for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
            child.x = child.x - 22
            child.y = child.y + 20 
        end 
    end 
end 

function ralsei:onHurt(damage, battler)
    for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
            child.x = child.x - 22
            child.y = child.y + 20 
        end 
    end 
    if self.health <= (self.max_health * 0.4) and Game:getFlag("enemies_killed", 0) >= 10 then 
        self:registerAct("???", "...")
        self.acts[5].color = {COLORS.red}
    end
    super.onHurt(self, damage, battler)
    self:getActiveSprite():stopShake()
    if self:getFlag("dead") and self.health <= (self.max_health * 0.3) and self.health >= (self.max_health * 0.1) then 
        self:getActiveSprite():resetSprite()
        self:getActiveSprite():setAnimation("spell")
        self:spellEffectHeal()
    end 
    if not Game.battle:hasCutscene() then
    if self.mercy == 100 then 
        self.mercy = 0 
        self.disable_mercy = true 
        Game.battle.battle_ui:endAttack()
        Game.battle:startCutscene(function(cutscene)
            Game.battle.music:fade(0, 2)
            cutscene:wait(2)
            battler:resetSprite()
            self:setFlag("dead", true)
            cutscene:battlerText("ralsei", "Y-[wait:2]you were\nreally serious..?")
            cutscene:wait(1)
            cutscene:battlerText("ralsei", "[shake:0.7][speed:0.7][noskip]After everything,\n[wait:5]and [color:red]you[color:reset] just.[wait:2].[wait:2].[wait:2]")
            battler:shake()
            Assets.playSound("bump")
            cutscene:wait(1)
            cutscene:battlerText("ralsei", "[noskip][speed:0.7]...Forgive me,[wait:2] Kris.")
            local snd = Assets.playSound("boost")
            local fx = self:addFX(ColorMaskFX(COLORS.white))
            fx.amount = 0 
            Game:getPartyMember("ralsei"):setFlag("serious", true)
            self:setAnimation("attack")
            Game.battle.music:seek(20)
            Game.battle.music:fade(1, 1)
            Game.battle.timer:tween(0.4, fx, {amount = 1})
            cutscene:wait(0.4)
            Game.battle.timer:tween(0.4, fx, {amount = 0})
            cutscene:wait(0.5)
            self:setAnimation("spell")
            Game.stage:addFX(HSVShiftFX(false, 99), "shiftfx")
            Game.world:addChild(self.vig)
            self.vig:fadeTo(0.75, 0.3)
            self.vig:setPosition(322, 165)
            self.vig:flash()
            self:healEffect()
            Assets.playSound("spell_cure_slight_smaller")
            Game.battle.battle_ui.action_boxes[1].buttons[4].disabled=true
            cutscene:wait(0.7)
            self:setHardMode()
            cutscene:after(function()
                battler:resetSprite()
                Game.battle:setState("DEFENDINGBEGIN", {"ralsei/fireshock"})
            end)
        end)
    end 
end 
end 

function ralsei:getNextWaves()
    if self:getFlag("dead") then
    local wave = self.waves[self.wave_index]
    self.wave_index = self.wave_index + 1
    if self.wave_index > #self.waves then
        self.wave_index = 1
    end
    return { wave }
    else 
    return super.getNextWaves(self)
    end 
end


function ralsei:setHardMode()
    self.waves = {
        "ralsei/fire_circle",
        "ralsei/solar_pulse",
        "ralsei/pacify_wave",
        "ralsei/pacify_wave_2",
        "ralsei/angel", 
        "ralsei/star_bomb", 
        "ralsei/z_rainstorm"
    }
    self.check = "AT "..self.attack.." DF 12\n* Standing in your way. \n* FIGHT him to his demise."
    self.health = self.max_health
    self.defense = self.defense + 5 
    self.kaboom = true 
    local tired = TiredBar(-200, -200)
    Game.battle:addChild(tired)
    Game.battle.tired_bar = tired
    Game.battle.tired_bar:setPosition(Game.battle.tired_bar.x, 6)
    Game.battle.tired_bar:slideTo(70, 6, 0.6)
    self:registerAct("WakeUp", "Reduce\nTired 16%", {}, 8)
    self:registerAct("CallOut", "Heal &\n-32% Tired", {}, 36)
end 

function ralsei:getEncounterText()
    if self.kaboom then 
        self.kaboom = nil
        return "* Ralsei's [color:yellow]defense[color:reset] went up.[wait:5]\n* Ralsei can heal himself.[wait:5]\n* Ralsei will attempt to induce [color:blue]TIRED[color:reset]."
    elseif self:getFlag("dead") then 
        return TableUtils.pick(self.text_alt)
    else 
        return super.getEncounterText(self)
    end  
end 
      

function ralsei:onAdd(parent)
    self:setAnimation("battle/intro")
end 

return ralsei
