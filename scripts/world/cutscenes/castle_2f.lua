return {
    renovating = function(cutscene, me, chara, facing)
        local susie = cutscene:getCharacter("susie")
        local noelle = cutscene:getCharacter("noelle")
        local ralsei = cutscene:getCharacter("ralsei")

        if ralsei and me.interact_count > 1 then
            cutscene:text("{hometown.text.sorry_wait_5_work_in_progress_501161f1b8}", "wink", "ralsei")
        elseif susie and ralsei then
            cutscene:text("{hometown.text.hey_ralsei_wait_5_what_s_up_here_38dac9efaf}", "smirk", "susie")
            cutscene:text("{hometown.text.oh_wait_5_just_more_rooms_i_m_renovating_c3500458f4}", "blush_smile", "ralsei")
            cutscene:text("{hometown.text.wait_5_so_is_your_room_up_there_78c071367f}", "nervous", "susie")
            cutscene:text("{hometown.text.er_wait_5_yes_wait_5_i_still_wait_5_um_wait_5_ha_4f8fcfeb76}", "pleased", "ralsei")
            cutscene:text("{hometown.text.yeah_wait_5_like_we_need_to_see_your_nerdy_glass_f34e52f000}", "nervous", "susie")
        elseif noelle and ralsei then
            cutscene:text("{hometown.text.hey_wait_5_what_s_going_on_up_here_8bf5ba6ed4}", "smile", "noelle")
            cutscene:text("{hometown.text.oh_wait_5_just_some_rooms_being_fixed_up_2b8206e4c8}", "blush_smile", "ralsei")
            cutscene:text("{hometown.text.wait_5_is_your_room_on_this_floor_503d07fa67}", "confused", "noelle")
            cutscene:text("{hometown.text.uh_wait_5_yes_wait_5_though_i_haven_t_had_time_t_e908dd5095}", "pleased", "ralsei")
            cutscene:text("{hometown.text.fahaha_wait_5_i_bet_it_s_full_of_books_and_scrol_1b1ff0eaa0}", "smile_closed_b", "noelle")
        end
    end,
}