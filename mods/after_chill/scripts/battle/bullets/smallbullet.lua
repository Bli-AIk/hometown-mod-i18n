---@class SmallBullet : Bullet
package.loaded["mods.after_chill.scripts.battle.bullets.darkbullet"] = nil
local DarkBullet = require("mods.after_chill.scripts.battle.bullets.darkbullet")
local SmallBullet, super = Class(DarkBullet)

function SmallBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/smallbullet")
    self.tiredness = 12
    self.remove_offscreen = false
    if self.physics then 
    self.physics.direction = dir 
    self.physics.speed = self:getTired()
    end 
end

return SmallBullet
