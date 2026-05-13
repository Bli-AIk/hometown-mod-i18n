return {
    manual_stand = function(cutscene, me, chara, facing)
        cutscene:text("* It's a stand for your Manual.")
        if cutscene:getCharacter("ralsei") then
            cutscene:text("* I thought you might want to keep it here in case you want to read it!", "blush_smile", "ralsei")
        end
    end,
    moss = function(cutscene, me, chara, facing)
        cutscene:text("* It's some decorative moss. Looks delicious.")
        if cutscene:getCharacter("susie") then
            cutscene:text("* Why the hell does YOUR room get moss!?", "nervous_side", "susie")
        end
    end,
}
