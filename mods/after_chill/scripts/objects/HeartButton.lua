local HeartButton, super = Class(Event)

function HeartButton:init(data)
    super.init(self, data)
    self.button_id = data.properties["button_id"] or 1
    self.sprite = Sprite("world/events/glowtile/idle")
    self:addChild(self.sprite)
    self.sprite:play(0.1, true)
    self.sprite:setScale(2)
    self.id = "heartbutton"
    self.can_be_pressed = true 
end

function HeartButton:onEnter(player)
    if self.can_be_pressed then 
        self.sprite:flash()
        Assets.playSound("bell", 0.4, 1.2)
        local current_states = Game:getFlag("heart_puzzle_state", {1, 1, 1})
        current_states[self.button_id] = current_states[self.button_id] + 1
        if current_states[self.button_id] > 3 then
            current_states[self.button_id] = 1
        end
        Game:setFlag("heart_puzzle_state", current_states)
    end 
    super.onEnter(self, player)
end

return HeartButton
