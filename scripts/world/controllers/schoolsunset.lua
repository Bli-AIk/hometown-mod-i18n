local SchoolSunset, super = Class(Event)

function SchoolSunset:onLoad()
    super.onLoad(self)

    local time = Game:getFlag("hometown_time", "day")

    if time ~= "sunset" and time ~= "night" then
        Game.world.map.image_layers["sunset"]:remove()
    end
end

return SchoolSunset