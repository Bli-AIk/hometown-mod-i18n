local Virovirokun, super = Class(EnemyBattler)

function Virovirokun:init()
    super.init(self)

    self.name = "Virovirovirus"
    self:setActor("virovirokun")

    self.max_health = 600
    self.health = 600
    self.attack = 10
    self.defense = -25
    self.money = 47

    self.spare_points = 20
    self.tired_percentage = 25

    self.waves = {
        -- "virovirokun/needle",
        -- "virovirokun/invader"
    }

    self.check = "AT II DEF -V\nThis virus has come to life and decided to block your way!"

    self.text = {
        "* Virovirovirus is sweating\nsuspiciously.",
        "* Virovirovirus is poking round\nthings with a spear.",
        "* Virovirovirus is beeping a\ncriminal tune."
    }

    self.low_health_text = "* Virovirovirus looks extra sick."
    self.dmg_sprite_offset = {37, 14}

    self:registerAct("TakeCare")
    self:registerAct("TakeCareX", "All\nMercy", {"ralsei"})
    self.text_override = nil
end


function Virovirokun:onAct(battler, name)
    if name == "TakeCare" then
        self:addMercy(50)
        return "* You took care of the sick virus!"
    elseif name == "TakeCareX" then
        self:addMercy(100)
        for _, enemy in ipairs(Game.battle:getActiveEnemies()) do 
            if enemy.id == "virovirokun" and enemy ~= self then 
                enemy:addMercy(50)
            elseif enemy ~= self then 
                enemy:addMercy(25)
            end 
        end 
        return "* Everyone took care of the enemies!"
    elseif name == "Standard" then  
        if battler.chara.id == "ralsei" then 
            self:addMercy(50)
            return "* Ralsei tried to rehabilitate!"
        end 
    end 
    
    return super.onAct(self, battler, name)
end 

function Virovirokun:getEnemyDialogue()
    if self.text_override then
        local dialogue = self.text_override
        self.text_override = nil
        return dialogue
    end

    local dialogue
    if self.mercy >= 100 then
        dialogue = {
            "Just what the\ndoctor ordered!",
            "Kindness is\ncontagious!"
        }
    else
        dialogue = {
            "Don't let\nthis bug ya!",
            "Happy new\nyear!",
            "I've got a love\nletter for you.",
            "I'm the fever,\nI'm the chill."
        }
    end
    return dialogue[love.math.random(#dialogue)]
end


function Virovirokun:onActStart(battler, name)
    local sprite_lookup = {
        ["kris"] = {"enemies/virovirokun/take_care/kris_nurse", "enemies/virovirokun/take_care/kris_doctor"},
        ["susie"] = "enemies/virovirokun/take_care/susie",
        ["ralsei"] = "enemies/virovirokun/take_care/ralsei",
        ["noelle"] = "enemies/virovirokun/take_care/noelle"
    } 
    local offset_lookup = {
        ["kris"] = {-4, -2},
        ["susie"] = {-6, 0},
        ["ralsei"] = {6, -1},
        ["noelle"] = {-7, 0}
    }
    
    local function getSpriteAndOffset(id)
        local selected_sprite = sprite_lookup[id] or ("enemies/virovirokun/take_care/"..id)
        if type(selected_sprite) == "table" then
            selected_sprite = TableUtils.pick(sprite_lookup[id])
        end
        local selected_offset = offset_lookup[id] or {0, 0}
        return selected_sprite, selected_offset[1], selected_offset[2]
    end

    if name == "TakeCare" then
        battler:setActSprite(getSpriteAndOffset(battler.chara.id))
    elseif name == "TakeCareX" then
        for _, ibattler in ipairs(Game.battle.party) do
            ibattler:setActSprite(getSpriteAndOffset(ibattler.chara.id))
        end
    else
        super.onActStart(self, battler, name)
    end
end

return Virovirokun