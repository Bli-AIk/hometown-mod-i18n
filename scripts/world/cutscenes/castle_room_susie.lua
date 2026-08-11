return {
    bed = function(cutscene, me, chara, facing)
        if cutscene:getCharacter("susie") then
            cutscene:text("{hometown.bed.cool_spike_bed}", "smile", "susie")
            cutscene:text("{hometown.bed.now_can_stab_myself_during}", "smirk", "susie")
            cutscene:text("{hometown.bed.finally_some_convenience}", "smile", "susie")
        end
    end,
    fridge = function(cutscene, me, chara, facing)
        if cutscene:getCharacter("susie") then
            if me.interact_count > 1 then
                cutscene:text("{hometown.fridge.hey_kris_stop_eye_bogarting}", "teeth", "susie")
            else
                cutscene:text("{hometown.fridge.damn_everything_here}", "surprise_smile", "susie")
                cutscene:text("{hometown.fridge.pinecones_chalk_moss_jars_salsa}", "surprise_smile", "susie")
                cutscene:text("{hometown.fridge.pieces_ice_black_crumbs_toaster}", "surprise_smile", "susie")
                cutscene:text("{hometown.fridge.oh_like_actual_food}", "smile", "susie")
            end
        end
    end,
    manual_stand = function(cutscene, me, chara, facing)
        if cutscene:getCharacter("susie") and cutscene:getCharacter("ralsei") then
            cutscene:text("{hometown.manual_stand.susie_didnt_get_read_manual}", "neutral", "ralsei")
            cutscene:text("{hometown.manual_stand.put_over_here}", "blush_smile", "ralsei")
            cutscene:text("{hometown.manual_stand.cool_read_before_bed}", "small_smile", "susie")
            cutscene:text("{hometown.manual_stand.thatll_put_sleep}", "smile", "susie")
        else
            cutscene:text("{hometown.manual_stand.stand_susies_manual}")
        end
    end,
    clothes_drawer = function(cutscene, me, chara, facing)
        cutscene:text("{hometown.clothes_drawer.clothes_drawer_full_spikey_dangerous}")
        cutscene:text("{hometown.clothes_drawer.all_clothes_ripping_each_other}")
        if cutscene:getCharacter("susie") then
            cutscene:text("{hometown.clothes_drawer.hell_yeah_jealous_kris}", "smile", "susie")
        end
    end
}