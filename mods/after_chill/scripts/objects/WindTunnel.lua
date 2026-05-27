---@class WindTunnel : Event
local WindTunnel, super = Class(Event)

function WindTunnel:init(x, y, shape, data)
    super.init(self, x, y, shape)
    self.entered = false 
    data = data or {}
    local properties = data.properties or {}   
    self.base_speed = properties.speed or 4
    self.wind_speed = self.base_speed
    self.side = properties.side or "left"
end

function WindTunnel:onEnter(player)
     Game.world.music:play("wind", 0)
    Game.world.music:fade(1, 0.3)
    player:removeFX()
    self.fx = player:addFX(OutlineFX({0.1, 0.2, 0.8, 1}))
    self.entered = true 
    return super.onEnter(self, player)
end 

function WindTunnel:onExit(player)
    local spawners = Game.stage:getObjects(TornadoSpawner)
    if spawners and #spawners > 0 then
        self.tunnel = spawners[1]
        if self.tunnel and self.tunnel.tornados then
            for _, tornado in ipairs(self.tunnel.tornados) do 
                if tornado and tornado.stage then
                    tornado:remove()
                end
            end 
            self.tunnel.tornados = {}
        end
    end

    self.entered = false 
    self.wind_speed = self.base_speed
    if Game.world.music:isPlaying("wind") then
        Game.world.music:stop()
    end
    if self.fx then
        Game.world.timer:tween(0.2, self.fx, {amount = 0})
    end
    
    local reached_end = false
    if self.side == "left" then
        if player.x > (self.x + (self.width / 2)) then reached_end = true end
    else
        if player.x < (self.x + (self.width / 2)) then reached_end = true end
    end

    if reached_end then
        player:removeFX()
    else
        local move = self.side == "left" and 20 or -20
        Game.lock_movement = true 
        Game.world.timer:tween(0.2, player, {x = player.x - move})
        Game.world.timer:after(0.2, function()
            if Game.world.player then
                Game.world.player:removeFX()
            end
            Game.lock_movement = false 
        end)
    end
    
    return super.onExit(self, player)
end


function WindTunnel:update()
    super.update(self)
    
    if self.entered and Game.world.player then 
        Game.world.player.force_walk = true 
        if Game.world.player:isMoving() then
            self.wind_speed = 80 
        else
            self.wind_speed = 100
        end
        if self.side == "left" then
            Game.world.player.x = Game.world.player.x - (self.wind_speed * DT)
        else
            Game.world.player.x = Game.world.player.x + (self.wind_speed * DT)
        end
    end
end

return WindTunnel
