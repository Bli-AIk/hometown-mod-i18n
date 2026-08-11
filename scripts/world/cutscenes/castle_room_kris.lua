return {
    manual_stand = function(cutscene, me, chara, facing)
        cutscene:text("{hometown.manual_stand.stand_manual}")
        if cutscene:getCharacter("ralsei") then
            cutscene:text("{hometown.manual_stand.thought_might_want_keep_here}", "blush_smile", "ralsei")
        end
    end,
    moss = function(cutscene, me, chara, facing)
        cutscene:text("{hometown.moss.some_decorative_moss_looks_delicious}")
        if cutscene:getCharacter("susie") then
            cutscene:text("{hometown.moss.why_hell_room_get_moss}", "nervous_side", "susie")
        end
    end,
}
