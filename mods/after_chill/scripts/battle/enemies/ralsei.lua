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
    self.money = 100

    self.spare_points = 20 

    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    self.dialogue_offset = {-60, 5}
    self.dialogue = { "..." }

    self.check = "AT "..self.attack.." DF "..self.defense.."\n* Standing in your way. \n* FIGHT him to his demise."

    self.text = {
        "* The dummy gives you a soft\nsmile.",
        "* The power of fluffy boys is\nin the air.",
        "* Smells like cardboard.",
    }
    self:registerAct("Apologize")
            self:registerAct("???", "...")
        self.acts[3].color = {COLORS.red}
end

function ralsei:onAct(battler, name)
    if name == "Apologize" then
        return {
            "* You try apologizing.",
            "* Nothing happened."
        }
    elseif name == "???" then 
        Game.battle:startActCutscene(function(cutscene)
            Game.battle.music:play("d")
            Game.battle.music:setVolume(0)
            Game.battle.music:fade(1, 0.5)
            cutscene:wait(1)
            battler:setAnimation("battle/idle")
            Assets.playSound("break1", 0.6, 0.8)
            battler:shake(3, 0)
            cutscene:wait(25/30)      
            Assets.playSound("boost")
            battler:flash()
            for i = 1, 2 do 
                battler:addFX(OutlineFX(COLORS.maroon)) 
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
            local pitch_shift = 1.0 - ((2 - 1) * 0.1)
            local sprite = Sprite("effects/attack/cut", 470, 135)
            Game.battle:addChild(sprite)
            sprite:setScale(2)
            cutscene:wait(0.1)
            sprite:play(0.1, false, function() sprite:remove() end)
            Assets.playSound("laz_c", 1.2, pitch_shift) 
            Assets.playSound("scytheburst", 1.0, pitch_shift)
            ralsei:setSprite("battle/hurt")
            ralsei.y = 215
            ralsei:slideTo(600, ralsei.y, 0.3)
            cutscene:wait(0.3)
            cutscene:wait(2) 
            end)
    end
    return super.onAct(self, battler, name)
end

function ralsei:onHurt(damage, battler)
    super.onHurt(self, damage, battler)
    
    self:stopShake()
    self:setAnimation("hurt")
    
    for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
            child.x = child.x - 22
            child.y = child.y + 20 
        end 
    end 
    
    if self.health <= (self.max_health * 0.4) then 
        self:registerAct("???", "...")
        self.acts[3].color = {COLORS.red}
    end 
end 

return ralsei
