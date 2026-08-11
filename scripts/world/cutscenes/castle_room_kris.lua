return {
    manual_stand = function(cutscene, me, chara, facing)
        cutscene:text("{hometown.text.it_s_a_stand_for_your_manual_34960470b7}")
        if cutscene:getCharacter("ralsei") then
            cutscene:text("{hometown.text.i_thought_you_might_want_to_keep_it_here_in_case_d3bab1869a}", "blush_smile", "ralsei")
        end
    end,
    moss = function(cutscene, me, chara, facing)
        cutscene:text("{hometown.text.it_s_some_decorative_moss_looks_delicious_d4786dd6e0}")
        if cutscene:getCharacter("susie") then
            cutscene:text("{hometown.text.why_the_hell_does_your_room_get_moss_474fbb4a4f}", "nervous_side", "susie")
        end
    end,
}
