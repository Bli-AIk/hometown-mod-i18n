local SeamShop, super = Class(Shop)

function SeamShop:init()
    super.init(self)
    self.encounter_text = "* Hee hee...[wait:5]\n* Welcome,[wait:5] travellers."
    self.shop_text = "[emote:talk]* Take your time...[wait:5]\n* Ain't like it's\nbetter spent."
    self.leaving_text = "* See you again.[wait:5]\n* Or not.\n* Ha ha ha ha..."
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "[emote:talk]What do\nyou like\nto buy?"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "Buy it for\n%s ?"
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "What,\nnot good\nenough?"
    -- Shown when you buy something
    self.buy_text = "[emote:laugh]Thanks for\nthat."
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "[emote:laugh]Thanks, it'll\nbe in your\nSTORAGE."
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "[emote:impatient]Not\nenough\nmoney."
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "[emote:impatient]You're\ncarrying\ntoo much."
    -- Shown when something doesn't have a sell price
    self.sell_no_price_text = "[emote:impatient]Why would\nYou sell\nthis?"
    -- Shown when you're in the SELL menu
    self.sell_menu_text = "[emote:talk]What kind\nof junk\nyou got?"
    -- Shown when you try to sell an empty spot
    self.sell_nothing_text = "That's\nnothing."
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "Sell it for\n%s ?"
    -- Shown when you refuse to sell something
    self.sell_refuse_text = "No?"
    -- Shown when you sell something
    self.sell_text = "That's it\nfor that."
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "[emote:impatient]You don't\nhave\nanything!"
    -- Shown when you enter the talk menu.
    self.talk_text = "[emote:talk]Don't have\nanything\nbetter\nto do."

    self.sell_options_text["item"]   = "[emote:talk]What\nshould\nI sell?"
    self.sell_options_text["weapon"] = "[emote:talk]What\nshould\nI sell?"
    self.sell_options_text["armor"]  = "[emote:talk]What\nshould\nI sell?"
    self.sell_options_text["pocket"] = "[emote:talk]What\nshould\nI sell?"

    self:registerItem("cd_bagel")
    self:registerItem("darkburger")
    self:registerItem("amber_card")
    self:registerItem("spookysword")

    self:registerTalk("About yourself")
    self:registerTalk("Lightners")
    self:registerTalk("Kingdom")
    self:registerTalk("We're legendary")

    self.shopkeeper:setActor("shopkeepers/seam")
    self.shopkeeper.sprite:setPosition(-24, 12)
    self.shopkeeper.slide = true

    self.background = "ui/shop/bg_seam"

    self.shop_music = "lantern"
end

function SeamShop:startTalk(talk)
    if talk == "About yourself" then
        self:startDialogue({
            "* The name's Seam.\n[wait:5]* Pronounced \"Shawm.\"",
            "* And this is my little Seap.\n[wait:5]* Ha ha ha ha...",
            "* Over the years, I've collected\nodds and ends.",
            "* 'Course, I've no attachment to\nany of it\n[wait:5]* It's just a hobby of mine.",
            "* Around here, you learn to find\nways to pass the time...\n[wait:5]* ... or go mad like everyone else."
        })
    elseif talk == "Lightners" then
        self:startDialogue({
            "[emote:oh]* Long ago, the Darkners lived in\nharmony with the Lightners.",
            "[emote:talk]* They were like Gods to us.\n* Our protectors.\n* Our creators.\n* Those who gave us purpose...",
            "[emote:impatient]* Then, one day we were all\nlocked away in this prison..\n* And the Lightners never returned.",
            "[emote:oh]* Embittered, the King took up\narms, and aims to take revenge\nupon the Lightners that left us\nbehind.",
            "[emote:talk]* 'Course, even among his troops,\nsome still distantly hope the\nLightners will return..."
        })
    elseif talk == "Kingdom" then
        self:startDialogue({
            "* Historically, this land was\nruled by the Four Kings, from\n[color:yellow]CARD CASTLE[color:reset] to the East.",
            "[emote:oh]* But, recently, a [color:red]strange knight[color:reset]\nappeared..\n* And three of the kings were\nlocked away.",
            "[emote:talk]* The remaining king put him and\nhis strange son into power.",
            "[emote:oh]* This land hasn't seen THIS much\nchaos since...",
            "[emote:laugh]* Ha ha ha..\n* Well, you don't need to know\nabout THAT."
        })
    elseif talk == "We're legendary" then
        self:startDialogue({
            "[emote:laugh]* Ha ha ha ..\n* So you are the \"heroes\" who are\ngoing to seal our Fountain?",
            "[emote:talk]* Ha, good luck.\n* It makes no difference to me.",
            "[emote:impatient]* Neither Light nor Dark hold a\nfuture for a Darkner in my\ncondition."
        })
    end
end

return SeamShop