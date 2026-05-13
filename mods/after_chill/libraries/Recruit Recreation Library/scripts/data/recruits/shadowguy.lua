local shadowguy, super = Class(Recruit)

function shadowguy:init()
    super.init(self)
    
    -- Display Name
    self.name = "Shadowguy"
    
    -- How many times an enemy needs to be spared to be recruited
    self.recruit_amount = 25
    
    -- Organize the order that recruits show up in the recruit menu
    self.index = 19
    
    -- Selection Display
    self.description = "Battling's just a side gig.\nPlaying on stage is the dream!"
    self.chapter = 3
    self.level = 5
    self.attack = 10
    self.defense = 11
    self.element = "SHADOW:MUSIC"
    self.like = "Socks"
    self.dislike = "Battle"
    
    -- Controls the type of the box gradient
    -- Available options: dark, bright
    self.box_gradient_type = "bright"
    
    -- Dyes the box gradient
    self.box_gradient_color = {1, 1, 1, 1}
    
    -- Sets the animated sprite in the box
    -- Syntax: Sprite/Animation path, offset_x, offset_y, animation_speed
    self.box_sprite = {"enemies/shadowman/idle", 0, 12, 4/30}
    
    -- Recruit Status (saved to the save file)
    -- Number: Recruit Progress
    -- Boolean: True = Recruited | False = Lost Forever
    self.recruited = true
    
    -- Whether the recruit will be hidden from the recruit menu (saved to the save file)
    self.hidden = false
end

return shadowguy