local ralsei, super = Class(Encounter)

function ralsei:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Ralsei unwillingly blocks your way."

    -- Battle music ("battle" is rude buster)
    self.music = "ralsei"
    -- Enables the purple grid battle background
    self.background = false 
    self.hide_world = false 

    -- Add the dummy enemy to the encounter
    self:addEnemy("ralsei", 533, 271)


    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

function ralsei:onStateChange(old, new) 
    if Game:getFlag("has_seen_ralsei") == false then 
     if old == "INTRO" and new == "ACTIONSELECT" then
        Game.battle.music:stop()
        Game.battle.battle_ui:clearEncounterText()
        Game.battle.seen_encounter_text = false
        Game.battle.current_selecting = 0
        Game.battle:startCutscene(function(cutscene)
            cutscene:wait(0.3)
            cutscene:battlerText("ralsei", "K-[wait:2]Kris...?")
            cutscene:battlerText("ralsei", "W-[wait:2]what are\nyou doing?")
            cutscene:wait(0.3)
            cutscene:battlerText("ralsei", "T-[wait:2]This[wait:2] isn't you!")
            cutscene:wait(1)
            cutscene:battlerText("ralsei", "Kris,[wait:2] can you\nhear me?")
            cutscene:wait(0.5)
            cutscene:battlerText("ralsei", "M-[wait:2]maybe,[wait:5] you can\nhear this.")
            local ralsei = Game.battle:getEnemyBattler("ralsei")
            ralsei:setAnimation("sing")
            cutscene:wait(0.6)
            local snd = Assets.playSound("snd_vsral")
            Game.fader:fadeOut(nil, {speed = 1})
            cutscene:wait(1)
            local mask = ColorMaskFX({1, 1, 1}, 1)
            mask.amount = 0 
            local sprite = Sprite("party/kris/dark/sit", 75, 150)
            sprite:setScale(2)
            sprite:addFX(mask)
            Game.stage:addChild(sprite)
            sprite.layer = 1000
            sprite.alpha = 0 
            Game.battle.timer:tween(0.5, sprite, {alpha = 1}, "in-out-sine")
            Game.battle.timer:tween(0.5, mask, {amount = 1}, "in-out-sine")       
            local melody_text = DialogueText("[noskip][shake:0.6][speed:0.10][spacing:6][voice:none]A melody you once knew.", 160, 240, {
            style = "none",
            align = "center"
            })
            melody_text:setOrigin(0.5, 0.5)
            melody_text.layer = 1000
            melody_text.x  = 346
            melody_text.y = 319
            Game.stage:addChild(melody_text)
            cutscene:wait(9.6)
            local rectangle = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
            rectangle.color = COLORS.black 
            Game.stage:addChild(rectangle)
            rectangle.layer = 9000
            rectangle.alpha = 0 
            Game.battle.timer:tween(0.5, rectangle, {alpha = 1})
            cutscene:wait(0.5)
            Game.fader.alpha = 0 
            sprite:remove()
            melody_text:remove()
            cutscene:wait(0.1)
            Game.battle.timer:tween(0.5, rectangle, {alpha = 0}, "in-out-sine", function()
                rectangle:remove()
            end)
            cutscene:wait(1.5)
            ralsei:setAnimation("idle")
            cutscene:wait(1)
            cutscene:battlerText("ralsei", "That didn't[wait:2]\ndo anything?")
            Game.battle.music:play("ralsei")
            Game.battle.music:setVolume(0)
            Game.battle.music:fade(1, 2)
            cutscene:battlerText("ralsei", "M-maybe,[wait:2] a battle\nwill do.")
            cutscene:wait(0.2)
            cutscene:battlerText("ralsei", "Kris...")
            local fire = FireGlow()
            Game.battle:addChild(fire)
            fire.alpha = 0 
            local sfx = Assets.playSound("boost", 0.4, 0.8)
            Game.battle.timer:tween(sfx:getDuration(), fire, {alpha = 1})
            Assets.playSound("weaponpull_fast")
            cutscene:wait(cutscene:setAnimation(ralsei, "battle/intro"))
            ralsei:setAnimation("idle")
        end)
    else 
        Game.battle:addChild(FireGlow())
    end 
 end
end 

function ralsei:getPartyPosition(index)
    if index == 1 then 
        return 113, 280
    end 
    return super.getPartyPosition(self, index)
end 

return ralsei
