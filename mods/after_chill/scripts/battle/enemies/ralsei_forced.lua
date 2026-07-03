local ralsei_forced, super = Class(EnemyBattler)

function ralsei_forced:init()
    super.init(self)

    -- Enemy name
    self.name = "Ralsei"
    self:setActor("enemy_ralsei")

    -- Enemy health
    self.max_health = 100
    self.health = 1000
    -- Enemy attack (determines bullet damage)
    self.attack = 15
    self.ui_modified = false
    -- Enemy defense (usually 0)
    self.defense = 200
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {}

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue_offset = {-60, 5}

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT "..self.attack.." DF "..self.defense.."\n* Standing in your way. \n* FIGHT him to his demise."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* The tension is so thick it can be cut with a knife.",
        "* Snowflakes fall.",
        "* Smells like ice.",
    }
end

function ralsei_forced:onHurt(damage, battler)
    for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
            child.x = child.x - 22
            child.y = child.y + 20 
        end 
    end
    Game.battle.timer:after(0.5, function()
    if Game.battle.turn_count ~= 3 then 
    self:resetSprite()
    end
    if Game.battle.turn_count == 3 then 
        for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
            child:remove()
        end 
        end
        self.hit_count = 0
        self:statusMessage("msg", "frozen")
        self:startSequence()
    end
    end)   
end 

function ralsei_forced:startSequence()
    Game.battle:startCutscene(function(cutscene)
        local ralsei = Game.battle:getEnemyBattler("ralsei_forced")
        ralsei.sprite.frozen = true 
        ralsei.sprite.freeze_progress = 0 
        local snd = Assets.playSound("petrify")
        Game.battle.timer:tween(0.75, ralsei.sprite, {freeze_progress = 1})
        Game.battle.music:fade(0, 2)
        cutscene:wait(2)
        Game.fader:fadeOut(nil, {speed = 1})
        local sprite = Sprite(ralsei.sprite.texture_path, 562, 184)
        Game.stage:addChild(sprite)
        sprite.layer = 9999
        sprite:setScale(2)
        sprite.scale_x = -2 
        sprite.alpha = 0 
        sprite:addFX(ColorMaskFX(COLORS.white))
        Game.battle.music:play("AUDIO_DRONE", 0)
        Game.battle.music:setVolume(0)
        Game.battle.music:fade(2, 1)
        sprite:fadeTo(1, 1)
        cutscene:wait(1.5) 
        local function gonerTextFade(text)
        local this_text = text
        Game.stage.timer:tween(1, this_text, { alpha = 0 }, "linear", function() this_text:remove() end)
        cutscene:wait(1) 
        end   
        local function gonerText(str, x, y)
        local txt = DialogueText("[noskip][voice:none]" ..str, x or 80, y or 80, {style = "GONER"}) -- HOW DO I DSIABLE THE VOICEEEEEE 
        txt:setParallax(0, 0)
        txt.layer = 9999
        Game.stage:addChild(txt)
        cutscene:wait(function() return not txt:isTyping() end)
        gonerTextFade(txt)
        end 
        gonerText("THE LONELY ONE.[wait:20]\nHIS LIGHT HAS FADED.")
        gonerText("THE EXPERIMENT CANNOT PROCEED[wait:10]\nIN THIS DARKNESS.")
        Assets.playSound("ui_spooky_action")
        local soul = SoulAppearance(SCREEN_WIDTH/2, 260)
        soul.layer = 9999 
        Game.stage:addChild(soul)
        cutscene:wait(1.2)
        gonerText("WILL YOU OFFER[wait:10]\nYOUR SOUL[wait:10]\nTO RESTORE HIM?")
        cutscene:wait(1.2)
        Assets.playSound("ui_spooky_action")
        soul:hide()
        cutscene:wait(1.2)
        gonerText("EXCELLENT.[wait:10]\nVERY EXCELLENT.")
        gonerText("WE SHALL NOW\nRESUME WITH THE STORY.")
        Game.battle.music:fade(0, 1)
        sprite:fadeOutAndRemove(1)
        cutscene:after(function() Game.battle:setState("TRANSITIONOUT") end)
    end)
end 
return ralsei_forced