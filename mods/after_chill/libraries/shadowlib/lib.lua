local Lib = {}

function Lib:init()
	Game:registerEvent("full_shadow", function(data)
        return PerspectiveShadow(data)
    end)
	Game:registerEvent("exit_shadow", function(data)
        return ShadowEvent(data.x, data.y, data)
    end)
end

return Lib