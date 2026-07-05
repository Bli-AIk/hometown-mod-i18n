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
    self.money = 0
    self.dmg_sprite_offset = {-14, 13}
    self.tired_percentage = 0
    if Game:getFlag("geno") then 
    self.disable_mercy = true 
    else 
    self.mercy = 100 
    end   

    self.spare_points = 20 

    self.waves = {
        "ralsei/fire_spin"
    }

    self.dialogue_offset = {-60, 5}
    self.dialogue = {}
    TableUtils.merge(self.actor.animations, {
        ["hurt"] = {"battle/hurt", 0.1, false}
    }, false)

    self.check = "AT "..self.attack.." DF "..self.defense.."\n* Standing in your way. \n* FIGHT him to his demise."

    self.text = {
        "* Fire emanates from the floor.",
        "* Smells like burnt friendship.",
        "* You shiver a little,[wait:2] even though it isn't cold.",
    }
    self:registerAct("Apologize")
    -- self:registerAct("???", "...")
    -- self.acts[3].color = {COLORS.red}
end

function ralsei:onAct(battler, name)
    if name == "Apologize" then
        local ap = self.apologize 
        if not Game:getFlag("geno") then 
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
            self:mercyFlash()
            cutscene:text("* Kris tried to spare Ralsei.")
            cutscene:wait(0.5)
            cutscene:text("* K[wait:2]-Kris?\n* You are...[wait:5] sparing me...?", "blush", "ralsei")
            self:addMercy(100)
            cutscene:text("* W[wait:2]-well,[wait:2] that was unexpected...", "blush_pleased_open", "ralsei")
            cutscene:after(function()
                Game.battle:setState("VICTORY")
            end)
        end) 
    end 


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
            cutscene:battlerText(ralsei, "K-[wait:5]Kris?")
            cutscene:battlerText(ralsei, "K-Kris,[wait:5]what\nare you doing?")
            cutscene:battlerText(ralsei, "Your..[wait:5] eyes...")
            cutscene:battlerText(ralsei, "I-[wait:2]I...")
            cutscene:battlerText(ralsei, "Kris,[wait:5] please...")
            battler:setAnimation("battle/attack")
            Assets.playSound("scytheburst")
            local sprite = Sprite("effects/attack/cut", 476, 200)
            Game.battle:addChild(sprite)
            sprite:setScale(2)
            cutscene:wait(0.1)
            sprite:play(0.1, false, function() sprite:remove() ralsei:hurt(math.ceil(battler.chara:getStat("attack") * 14 - ralsei.defense), battler, nil, COLORS.red) end)
            cutscene:wait(0.2)
            ralsei:resetSprite()
            battler:removeFX("fx1")
            battler:removeFX("fx2")
            battler:resetSprite()
            cutscene:wait(0.6)
            cutscene:battlerText(ralsei, "(I-I have to go...)")
            Assets.playSound("wing")
            ralsei:resetSprite()
            ralsei.y = 285 -- 271
            ralsei:setSprite("walk/left_1")
            cutscene:wait(0.2)
            ralsei:setSprite("walk/left")
            ralsei.sprite:play(0.25, true)
            ralsei:slideTo(700, ralsei.y, 2)
            cutscene:wait(2)
            ralsei.visible = false
            Game:setFlag("encounter#ralsei:violenced", true) 
            cutscene:after(function()
                Game:setFlag("geno", true)
                Game.battle:setState("TRANSITIONOUT")
            end)
            end)
    end
    return super.onAct(self, battler, name)
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
        self.acts[3].color = {COLORS.red}
    end
    super.onHurt(self, damage, battler)
    self:getActiveSprite():stopShake()
end 

function ralsei:onAdd(parent)
    self:setAnimation("battle/intro")
end 

return ralsei
