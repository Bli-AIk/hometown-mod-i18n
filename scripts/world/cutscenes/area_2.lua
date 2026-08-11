return {
    book_pillar = function(cutscene, me, chara, facing)
        cutscene:text("{hometown.text.it_s_a_manual_read_a_topic_bfec37e746}")
        local tip = cutscene:choicer({"Recruits", "Item storage", "Controls", "Do not read"})

        if tip == 1 then
            cutscene:text("{hometown.text.if_you_spare_or_pacify_enough_enemies_of_the_sam_a3d14e0fff}")
            cutscene:text("{hometown.text.recruits_will_appear_in_your_town_wonder_what_ha_9b5fd04ce6}")
            cutscene:text("{hometown.text.you_can_check_the_area_s_recruit_status_at_save__dfcb1db8e6}")
        elseif tip == 2 then
            cutscene:text("{hometown.text.you_will_now_have_access_to_a_storage_menu_at_sa_8640e58f92}")
            cutscene:text("{hometown.text.when_you_re_out_of_space_wait_5_items_you_find_o_72182acd50}")
            cutscene:text("{hometown.text.feel_free_to_put_things_inside_you_might_not_be__f9f067f6f2}")
        elseif tip == 3 then
            cutscene:text("{hometown.text.here_is_a_reminder_of_the_controls_change_them_i_9e2a9efc0b}")
            cutscene:text(string.format("{hometown.text.s_confirm_and_interact_with_things_0a1c4aacf7}", Input.getText("confirm")))
            cutscene:text(string.format("{hometown.text.s_cancel_hold_to_run_shows_all_text_instantly_24b74bf937}", Input.getText("cancel")))
            cutscene:text(string.format("{hometown.text.s_opens_the_menu_hold_down_to_quickly_skip_textb_356e537202}", Input.getText("menu")))
        else
            cutscene:text("{hometown.text.there_s_no_time_to_read_books_670ad76d5c}")
        end
    end,
}