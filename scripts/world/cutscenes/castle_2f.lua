return {
    renovating = function(cutscene, me, chara, facing)
        local susie = cutscene:getCharacter("susie")
        local noelle = cutscene:getCharacter("noelle")
        local ralsei = cutscene:getCharacter("ralsei")

        if ralsei and me.interact_count > 1 then
            cutscene:text("{hometown.renovating.sorry_work_progress}", "wink", "ralsei")
        elseif susie and ralsei then
            cutscene:text("{hometown.renovating.hey_ralsei_whats_up_here}", "smirk", "susie")
            cutscene:text("{hometown.renovating.oh_more_rooms_renovating}", "blush_smile", "ralsei")
            cutscene:text("{hometown.renovating.room_up}", "nervous", "susie")
            cutscene:text("{hometown.renovating.er_still_um_havent_dusted}", "pleased", "ralsei")
            cutscene:text("{hometown.renovating.yeah_like_need_see_nerdy}", "nervous", "susie")
        elseif noelle and ralsei then
            cutscene:text("{hometown.renovating.hey_what_going_up_here}", "smile", "noelle")
            cutscene:text("{hometown.renovating.oh_some_rooms_fixed_up}", "blush_smile", "ralsei")
            cutscene:text("{hometown.renovating.room_floor}", "confused", "noelle")
            cutscene:text("{hometown.renovating.uh_though_haven_time_tidy}", "pleased", "ralsei")
            cutscene:text("{hometown.renovating.fahaha_bet_full_books_scrolls}", "smile_closed_b", "noelle")
        end
    end,
}