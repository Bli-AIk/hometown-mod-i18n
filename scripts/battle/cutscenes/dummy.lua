return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene BattleCutscene
    susie_punch = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("{hometown.text.susie_threw_a_punch_at_the_dummy_47f6bfbb4c}")

        -- Hurt the target enemy for 1 damage
        Assets.playSound("damage")
        enemy:hurt(1, battler)
        -- Wait 1 second
        cutscene:wait(1)

        -- Susie text
        cutscene:text("{hometown.text.you_wait_5_uh_wait_5_look_like_a_weenie_wait_5_i_9c8b23c919}", "nervous_side", "susie")

        if cutscene:getCharacter("ralsei") then
            -- Ralsei text, if he's in the party
            cutscene:text("{hometown.text.aww_wait_5_susie_c3d42fac42}", "blush_pleased", "ralsei")
        end
    end
}