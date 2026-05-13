return {
    bed = function(cutscene, me, chara, facing)
        if cutscene:getCharacter("susie") then
            cutscene:text("* Cool,[wait:5] spike bed.", "smile", "susie")
            cutscene:text("* Now I can stab myself during the night.", "smirk", "susie")
            cutscene:text("* Finally some convenience.", "smile", "susie")
        end
    end,
    fridge = function(cutscene, me, chara, facing)
        if cutscene:getCharacter("susie") then
            if me.interact_count > 1 then
                cutscene:text("* Hey Kris,[wait:5] stop eye-bogarting my snacks.", "teeth", "susie")
            else
                cutscene:text("* Damn,[wait:5] there's everything in here!", "surprise_smile", "susie")
                cutscene:text("* Pinecones,[wait:5] chalk,[wait:5] moss,[wait:5] jars of salsa,[wait:5]", "surprise_smile", "susie")
                cutscene:text("* Pieces of ice,[wait:5] black crumbs from the toaster,[wait:5] jawbreakers...", "surprise_smile", "susie")
                cutscene:text("* ...[wait:5] Oh,[wait:5] and like actual food,[wait:5] too.", "smile", "susie")
            end
        end
    end,
    manual_stand = function(cutscene, me, chara, facing)
        if cutscene:getCharacter("susie") and cutscene:getCharacter("ralsei") then
            cutscene:text("* Susie,[wait:5] you didn't get to read the manual...", "neutral", "ralsei")
            cutscene:text("* So I put it over here for you.", "blush_smile", "ralsei")
            cutscene:text("* Cool,[wait:5] I'll read it before bed.", "small_smile", "susie")
            cutscene:text("* That'll put me to sleep.", "smile", "susie")
        else
            cutscene:text("* It's a stand for Susie's Manual.")
        end
    end,
    clothes_drawer = function(cutscene, me, chara, facing)
        cutscene:text("* It's a clothes drawer full of spikey and dangerous clothing.")
        cutscene:text("* All the clothes are ripping each other up into shreds.")
        if cutscene:getCharacter("susie") then
            cutscene:text("* Hell yeah!!![wait:5] Jealous,[wait:5] Kris!?", "smile", "susie")
        end
    end
}