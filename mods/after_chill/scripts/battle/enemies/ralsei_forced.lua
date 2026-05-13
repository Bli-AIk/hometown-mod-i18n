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
    self:stopShake()
     for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
            child.x = child.x - 22
            child.y = child.y + 20 
        end 
    end
    Game.battle.timer:after(0.3, function() 
    self:setAnimation("idle")
    for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
         child:fadeOutAndRemove(0.2) 
        end   
    end
end)
end 

function ralsei_forced:getGrazeTension()
    return 0 
end 


return ralsei_forced