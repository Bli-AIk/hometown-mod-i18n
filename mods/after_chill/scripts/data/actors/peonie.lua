local actor, super = Class(Actor, "peonie")

function actor:init()
    super.init(self)

    self.name = "Peonie"
    self.width = 27
    self.height = 45
    self.visible = false 
    self.hitbox = { 0, 25, 19, 14 }
    self.color = { 1, 0, 0 }
    self.flip = nil
    self.path = "enemies/peonie"
    self.default = "idle"
    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil
    self.can_blush = false
    self.talk_sprites = {}

    self.animations = {
        ["idle"] = { "idle", 0.25, true },
        ["spared"] = {"spared", 0.25, true}, 
        ["hurt"]= {"hurt", 0.25, true}
    }

    self.offsets = {
        ["idle"] = { 0, 0 },
    }
end

function actor:onSpriteUpdate(sprite)
    sprite:setScale(0.75)
    sprite.visible = self.visible
    sprite:setOrigin(-0.2, -0.2)
    if Game.battle then  
        sprite.visible = true 
        if not sprite.center_x then
            sprite.center_x = sprite.x - 20
            sprite.center_y = sprite.y
            sprite.wave_time = 0
        end
        if sprite.center_x then
            sprite.wave_time = sprite.wave_time + (DT * 2.0)     
            sprite.x = sprite.center_x + (math.sin(sprite.wave_time) * 15)
            sprite.y = sprite.center_y + (math.cos(2 * sprite.wave_time) * 7.5)
            sprite.rotation = math.cos(sprite.wave_time) * 0.4
        end
    end 
end

return actor
