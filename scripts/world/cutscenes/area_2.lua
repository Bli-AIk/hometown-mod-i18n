return {
    book_pillar = function(cutscene, me, chara, facing)
        cutscene:text("{hometown.book_pillar.manual_read_topic}")
        local tip = cutscene:choicer({"Recruits", "Item storage", "Controls", "Do not read"})

        if tip == 1 then
            cutscene:text("{hometown.book_pillar.if_spare_pacify_enough_enemies}")
            cutscene:text("{hometown.book_pillar.recruits_will_appear_town_wonder}")
            cutscene:text("{hometown.book_pillar.can_check_areas_recruit_status}")
        elseif tip == 2 then
            cutscene:text("{hometown.book_pillar.will_now_access_storage_menu}")
            cutscene:text("{hometown.book_pillar.when_out_space_items_find}")
            cutscene:text("{hometown.book_pillar.feel_free_put_things_inside}")
        elseif tip == 3 then
            cutscene:text("{hometown.book_pillar.here_reminder_controls_change_config}")
            cutscene:text(string.format("{hometown.book_pillar.confirm_interact_things}", Input.getText("confirm")))
            cutscene:text(string.format("{hometown.book_pillar.cancel_hold_run_shows_all}", Input.getText("cancel")))
            cutscene:text(string.format("{hometown.book_pillar.opens_menu_hold_down_quickly}", Input.getText("menu")))
        else
            cutscene:text("{hometown.book_pillar.time_read_books}")
        end
    end,
}