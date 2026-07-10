---@class FMCinematicController : Sprite
---@overload fun(...) : FMCinematicController
local FMCinematicController, super = Class(Object)

function FMCinematicController:init(fountain_center_x, fountain_center_y)
    super.init(self, 0, 0, 0, 0)

    self.fountain_center_x = fountain_center_x
    self.fountain_center_y = fountain_center_y

    self.state = 1
    self.timer = 0
    self.lightbeam_timerx = 0
    self.lightbeam_timery = 0
end

return FMCinematicController