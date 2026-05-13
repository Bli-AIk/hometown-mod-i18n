return {
    book_pillar = function(cutscene, me, chara, facing)
        cutscene:text("* (It's a manual. Read a topic?)")
        local tip = cutscene:choicer({"Recruits", "Item storage", "Controls", "Do not read"})

        if tip == 1 then
            cutscene:text("* If you SPARE or PACIFY enough enemies of the same type,[wait:5] they will be RECRUITed.")
            cutscene:text("* RECRUITs will appear in your TOWN. Wonder what happens if you get them all...?")
            cutscene:text("* You can check the area's RECRUIT status at SAVE POINTS. Certain BOSSES are excluded.")
        elseif tip == 2 then
            cutscene:text("* You will now have access to a STORAGE menu at SAVE POINTS.")
            cutscene:text("* When you're out of space,[wait:5] ITEMs you find or BUY will be sent to your STORAGE.")
            cutscene:text("* Feel free to put things inside you might not be able to use yet.")
        elseif tip == 3 then
            cutscene:text("* Here is a reminder of the controls. Change them in the config menu.")
            cutscene:text(string.format("* %s\n* Confirm and interact with things.", Input.getText("confirm")))
            cutscene:text(string.format("* %s\n* Cancel. Hold to RUN. Shows all text instantly.", Input.getText("cancel")))
            cutscene:text(string.format("* %s\n* Opens the menu. Hold down to quickly skip textboxes.", Input.getText("menu")))
        else
            cutscene:text("* (There's no time to read books.)")
        end
    end,
}