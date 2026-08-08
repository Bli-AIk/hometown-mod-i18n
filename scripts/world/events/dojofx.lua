local DojoFXGenerator, super = Class(Event)

function DojoFXGenerator:init(data)
    super.init(self, data)

    --[[self.ball = Sprite("world/castle_town/dojo_discoball")
    self.ball_back = Sprite("world/castle_town/dojo_discoball_back")

    self.siner = 0
    self.boombox_scroll = 0]]
end

function DojoFXGenerator:update()
    super.update(self)
end

return DojoFXGenerator