local actor, super = Class(Actor, "dusteer")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Dusteer"

    -- Width and height for this actor, used to determine its center
    self.width = 27
    self.height = 45

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {10, 18, 20, 20}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 1, 0, 0 }

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/dusteer"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["idle"] = { "idle", 0.25, true },
        ["spared"] = {"spared", 0.25, true},
        ["hurt"]= {"hurt", 0.25, true},
        ["sweep"]={"sweep", 0.25, true},
        ["walk"] = {"walk", 0.25, true},
        ["chasing"] = {"walk", 0.25, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["idle"] = { 0, 0 },
    }
end

function actor:onSpriteInit(sprite)
    sprite:setScale(1.3)
    super.onSpriteInit(self, sprite)
end 


return actor
