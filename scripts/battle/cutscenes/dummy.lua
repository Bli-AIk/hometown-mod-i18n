return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene BattleCutscene
    susie_punch = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("{hometown.battle.cutscenes.dummy.susie_threw_punch_dummy}")

        -- Hurt the target enemy for 1 damage
        Assets.playSound("damage")
        enemy:hurt(1, battler)
        -- Wait 1 second
        cutscene:wait(1)

        -- Susie text
        cutscene:text("{hometown.battle.cutscenes.dummy.uh_look_like_weenie_dont}", "nervous_side", "susie")

        if cutscene:getCharacter("ralsei") then
            -- Ralsei text, if he's in the party
            cutscene:text("{hometown.battle.cutscenes.dummy.aww_susie}", "blush_pleased", "ralsei")
        end
    end
}