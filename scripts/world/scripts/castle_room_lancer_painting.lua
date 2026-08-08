return function(script, chara, facing)
    if script.interact_count <= 1 then
        Assets.playSound("bluh")
        script:setSprite("lancerpainting_bluh")
    end
end