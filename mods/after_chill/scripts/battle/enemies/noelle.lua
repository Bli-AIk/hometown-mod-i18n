local noelle, super = Class(EnemyBattler)

function noelle:init()
    super.init(self)
    self.name = "Noelle"
    self:setActor("enemy_noelle")

    self.max_health = 280
    self.health = 280
    self.attack = 14
    self.defense = 10
    self.money = 40
    self.tired_percentage = 0 
    self.disable_mercy = true 
    self.exit_on_defeat = false
    self.dialogue = ""

    self.spare_points = 0

    self.check = "AT 14 DF "..self.defense.."\n* A lost girl.\n* ..."

    self.text = {
        "* Ice falls down from the sky.",
        "* The air is getting colder, and you shiver a little.",
        "* Smells like peppermint.", 
        "* The wind sends chills down your spine.", 
        "* Snowflakes twirl, dancing through the wind.", 
        "* You start to regret your actions."
    }

    -- self.text_alt = { 
    --    "* A blizzard has been brought upon\nyou both.", 
    --    "* Smells like never-melting ice.",
    --    "* Snowflakes fall in your hair.", 
    --    "* Shining in the cold.",
    --    "* The dark hero's remains stay, and the wind sways them slightly.", 
    --    "* Ice courses through your veins.", 
    --    "* Noelle closes her eyes, her main focus on you.", 
    --    "* You start to regret your actions."
    -- }
 
    self.waves = {}
    self:registerAct("Weaken")
end
function noelle:onAdd(parent)
    self:setAnimation("float")
    super.onAdd(self, parent)
    Game.battle.timer:after(0.5, function()
        self:resetSprite()
    end)
end 

function noelle:onAct(battler, name)
    if name == "Weaken" then 
        return "* You attempted to weaken Noelle's ice powers!"
    else 
    return super.onAct(self, battler, name)
    end 
end

return noelle
