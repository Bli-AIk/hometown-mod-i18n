---@param cutscene WorldCutscene
return function (cutscene)
    cutscene:detachCamera()
    cutscene:panTo(950, 0, .6)
    cutscene:wait(cutscene:slideTo(cutscene:getCharacter("kris_lw"), 990, 345, 1, "out-quad"))
    Game.world:closeMenu()
    cutscene:after(function ()
        Game.world:loadMap(Game.world.map.id)
    end)
    cutscene:gotoCutscene("test/pace")
end