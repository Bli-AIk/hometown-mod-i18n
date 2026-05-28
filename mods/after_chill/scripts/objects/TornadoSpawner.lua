---@class TornadoSpawner : Event
local TornadoSpawner, super = Class(Event)

function TornadoSpawner:init(x, y, shape, data)
    super.init(self, x, y, shape)
    
    data = data or {}
    local properties = data.properties or {}
    self.spawn_rate = properties.rate or 1.5
    self.tornados = {}
    self.timer = 0
    self.tunnel = nil
end

function TornadoSpawner:update()
    super.update(self)
    
    if not self.tunnel then
        local tunnels = Game.stage:getObjects(WindTunnel)
        if tunnels and #tunnels > 0 then
            self.tunnel = tunnels[1]
        end
    end

    if self.tunnel and self.tunnel.entered then
        self.timer = self.timer + DT
        if self.timer >= self.spawn_rate then
            self.timer = 0
            
            local spawn_x = self.tunnel.x
            if self.tunnel.side == "left" then
                spawn_x = self.tunnel.x + self.tunnel.width
            end
            
            local spawn_y = love.math.random(self.tunnel.y, self.tunnel.y + self.tunnel.height)
            
            local tornado = Game.world:spawnBullet("tornado", spawn_x, spawn_y)
            table.insert(self.tornados, tornado)
        end
    else
        self.timer = 0
    end
end

return TornadoSpawner
