local HeartButton, super = Class(Event)

function HeartButton:init(data)
    super.init(self, data)
    self.button_id = data.properties["button_id"] or 1
    self.sprite = Sprite("world/events/glowtile/idle")
    self:addChild(self.sprite)
    self.sprite:play(0.1, true)
    self.sprite:setScale(2)
    self:setHitbox(0, 0, self.sprite.width*2, self.sprite.height*2)
    self.id = "heartbutton"
    self.can_be_pressed = true 
end

function HeartButton:onEnter(player)
    if self.can_be_pressed and player == Game.world.player then 
        self.sprite:flash()
        Assets.playSound("bell", 0.4, 1.2) 
        for _, thing in ipairs(Game.stage:getObjects()) do
            if thing.id == "heart_screen" then
                thing.current_pattern[self.button_id] = thing.current_pattern[self.button_id] + 1
                if thing.current_pattern[self.button_id] > 3 then
                    thing.current_pattern[self.button_id] = 1
                end
                break
            end
        end
    end 
    super.onEnter(self, player)
end

return HeartButton
