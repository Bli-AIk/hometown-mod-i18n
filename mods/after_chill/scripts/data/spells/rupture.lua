local spell, super = Class(Spell, "rupture")

function spell:init()
    super.init(self)

    self.name = "Rupture"
    self.cast_name = nil

    self.effect = "Blade\nSlash\nDMG"
    self.description = "Deals neutral sword damage to one foe.\nGrows stronger with each kill."

    self.cost = 2
    self.target = "enemy"
    self.tags = {"blade"}
end

function spell:getCastMessage(user, target)
    return "* " .. user.chara:getName() .. " used RUPTURE!"
end

function spell:getDamage(user, target)
    local base_attack = user.chara:getStat("attack")
    local kills = Game:getFlag("enemies_killed", 0)
    local multiplier = 2.0 + (kills * 0.3)
    local final_damage = base_attack * multiplier
    
    local damage_after_defense = final_damage - target.defense
    local dmg
    if target.tired then  
        dmg = MathUtils.clamp(math.ceil(damage_after_defense + 40), 1, 150)
    else 
        dmg = MathUtils.clamp(math.ceil(damage_after_defense), 1, 150)
    end
    return dmg
end

function spell:onCast(user, target)
    local outlines = {}
    
    local kills = Game:getFlag("enemies_killed", 0)
    local slash_count = math.max(1, math.floor(kills / 5) - 1)
    Game.battle.timer:script(function(wait)
        user:setAnimation("battle/idle")
        Assets.playSound("break1", 0.6, 0.8)
        user:shake(3, 0) 
        wait(12/30)
        Assets.playSound("boost")
        local fx = user:addFX(ColorMaskFX(COLORS.white))
        Game.battle.timer:tween(0.5, fx, {amount = 0})    
        for i = 1, 2 do 
            local fx = user:addFX(OutlineFX(COLORS.maroon))
            fx.thickness = 0 
            table.insert(outlines, fx)
            
            Game.battle.timer:tween(10/30, fx, {thickness = 1}, "out-cubic")
        end
        user:setAnimation("battle/attack_ready")
        wait(15/30)

        if target and target.stage and target.health > 0 then
            local base_damage = self:getDamage(user, target)

            for strike = 1, slash_count do
                if not target or not target.stage or target.health <= 0 then 
                    break 
                end

                if strike > 1 then
                    user:setAnimation("battle/attack_ready")
                    wait(6/30)
                end

                user:setAnimation("battle/attack")
                wait(4/30) 

                local raw_pitch = 1.0 - ((strike - 1) * 0.1)
                local pitch_shift = MathUtils.clamp(raw_pitch, 0.2, 1.0)
                Assets.playSound("laz_c", 1.2, pitch_shift) 
                Assets.playSound("scytheburst", 1.0, pitch_shift)

                local damage_multiplier = 1.0 - ((strike - 1) * 0.2)
                local current_damage = math.max(1, math.ceil(base_damage * damage_multiplier))

                if target and target.stage and target.health > 0 then
                    target:hurt(current_damage, user)
                    Game.battle:shake(8, 8)

                    local mask = target:addFX(ColorMaskFX(COLORS.red))
                    mask.amount = 1
                    Game.battle.timer:tween(15/30, mask, {amount = 0}, "out-quad", function()
                        if target and target.stage then
                            target:removeFX(mask)
                        end
                    end)

                    -- If this specific strike drops them to 0 or below, kill them violently!
                    if target.health <= 0 then
                        Assets.stopSound("defeatrun")
                        target:onDefeatFatal(user)
                        break -- Snap out of the slash loop instantly
                    end
                end

                wait(10/30)
            end
        end

        wait(5/30)
        for _, fx in ipairs(outlines) do
            Game.battle.timer:tween(15/30, fx, {thickness = 0}, "linear", function()
                user:removeFX(fx)
            end)
        end
        wait(15/30)
        Game.battle:finishActionBy(user)
    end)
    return false
end

return spell
