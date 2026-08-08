return {
    renovating = function(cutscene, me, chara, facing)
        local susie = cutscene:getCharacter("susie")
        local noelle = cutscene:getCharacter("noelle")
        local ralsei = cutscene:getCharacter("ralsei")

        if ralsei and me.interact_count > 1 then
            cutscene:text("* Sorry,[wait:5] work in progress!", "wink", "ralsei")
        elseif susie and ralsei then
            cutscene:text("* Hey Ralsei,[wait:5] what's up here?", "smirk", "susie")
            cutscene:text("* Oh,[wait:5] just more rooms I'm renovating!", "blush_smile", "ralsei")
            cutscene:text("* ...[wait:5] so is your room up there?", "nervous", "susie")
            cutscene:text("* Er,[wait:5] yes![wait:5] I still,[wait:5] um,[wait:5] haven't dusted it though...", "pleased", "ralsei")
            cutscene:text("* Yeah,[wait:5] like we need to see your nerdy glasses collection anyway.", "nervous", "susie")
        elseif noelle and ralsei then
            cutscene:text("* Hey,[wait:5] what’s going on up here?", "smile", "noelle")
            cutscene:text("* Oh,[wait:5] just some rooms being fixed up!", "blush_smile", "ralsei")
            cutscene:text("* ...[wait:5] Is your room on this floor?", "confused", "noelle")
            cutscene:text("* Uh,[wait:5] yes![wait:5] Though I haven’t had time to tidy it yet...", "pleased", "ralsei")
            cutscene:text("* Fahaha,[wait:5] I bet it’s full of books and scrolls as usual.", "smile_closed_b", "noelle")
        end
    end,
}