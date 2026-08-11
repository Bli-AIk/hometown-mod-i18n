local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "Dummy"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("dummy")

    -- Enemy health
    self.max_health = 450
    self.health = 450
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "{hometown.text.at_4_df_0_cotton_heart_and_button_eye_looks_just_7f544a450c}"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "{hometown.text.the_dummy_gives_you_a_soft_smile_5218eb57c6}",
        "{hometown.text.the_power_of_fluffy_boys_is_in_the_air_639644f922}",
        "{hometown.text.smells_like_cardboard_704d5b3e9a}",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "{hometown.text.the_dummy_looks_like_it_s_about_to_fall_over_bc75e9ef9c}"

    -- Register act called "Smile"
    self:registerAct("Smile")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Tell Story", "", {"ralsei"})
end

function Dummy:onAct(battler, name)
    if name == "Smile" then
        -- Give the enemy 100% mercy
        self:addMercy(100)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "... ^^"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "{hometown.text.you_smile_wait_5_the_dummy_smiles_back_3cfd31dfbb}",
            "{hometown.text.it_seems_the_dummy_just_wanted_to_see_you_happy_85992f0a68}"
        }

    elseif name == "Tell Story" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            enemy:setTired(true)
        end
        return "{hometown.text.you_and_ralsei_told_the_dummy_a_bedtime_story_th_bcc5ef33b1}"

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "{hometown.text.ralsei_bowed_politely_the_dummy_spiritually_bowe_8d448abcde}"
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            Game.battle:startActCutscene("dummy", "susie_punch")
            return
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().."{hometown.text.straightened_the_dummy_s_hat_f5e1a99c02}"
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Dummy