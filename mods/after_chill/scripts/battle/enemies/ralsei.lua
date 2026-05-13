local ralsei, super = Class(EnemyBattler)

function ralsei:init()
    super.init(self)

    -- Enemy name
    self.name = "Ralsei"
    self:setActor("enemy_ralsei")

    -- Enemy health
    self.max_health = 100
    self.health = 100
    -- Enemy attack (determines bullet damage)
    self.attack = 15
    self.ui_modified = false
    -- Enemy defense (usually 0)
    self.defense = 4
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20 

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue_offset = {-60, 5}
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT "..self.attack.." DF "..self.defense.."\n* Standing in your way. \n* FIGHT him to his demise."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* The dummy gives you a soft\nsmile.",
        "* The power of fluffy boys is\nin the air.",
        "* Smells like cardboard.",
    }
    self:registerAct("Apologize")
end

function ralsei:onAct(battler, name)
    if name == "Apologize" then
        return {
            "* You try apologizing.",
            "* Nothing happened."
        }
    end 
    return super.onAct(self, battler, name)
end

function ralsei:onHurt(damage, battler)
    self:stopShake()
    self:setAnimation("hurt")
    for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
            child.x = child.x - 22
            child.y = child.y + 20 
        end 
    end 
end 

function ralsei:update()
    super.update(self)
    if Game.battle.battle_ui and not self.ui_modified then
        Game.battle.battle_ui.action_boxes[1].buttons[4].disabled = true
        self.ui_modified = true
    end
end

function ralsei:onDefeat()
        for _, child in ipairs(Game.battle.children) do
                if child:includes(DamageNumber) then
                    child.x = 469 - 44
                    child.y = 205 + 6
                elseif child:includes(Sprite) then 
                    if child:isSprite("effects/attack/cut_1") or child:isSprite("effects/attack/cut_2") then
                        child.x = 438
                        child.y = 175 
                        child.layer = 1000
                    end
                end
        end
        local shield = Sprite("effects/shield", 409, 123) 
        Game.battle:addChild(shield) 
        shield:setScale(2)
        Assets.playSound("ice_impact")
        shield:play(1/6, false)
end 


return ralsei 