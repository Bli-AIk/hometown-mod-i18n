local peonie, super = Class(Recruit)

function peonie:init()
    super.init(self)
    
    -- Display Name
    self.name = "Peonie"
    
    -- How many times an enemy needs to be spared to be recruited
    self.recruit_amount = 3
    
    -- Organize the order that recruits show up in the recruit menu
    self.index = 1
    
    -- Selection Display
    self.description = "A cute flower.\nIt fell off a bouquet."
    self.chapter = "?"
    self.level = 8
    self.attack = 10
    self.defense = 7
    self.element = "ORDER:PETAL"
    self.like = "Bouquets"
    self.dislike = "Wind"
    
    -- Controls the type of the box gradient
    -- Available options: dark, bright
    self.box_gradient_type = "bright"
    
    -- Dyes the box gradient
    self.box_gradient_color = {0.84, 0.78, 1.0, 1.0}
    
    -- Sets the animated sprite in the box
    -- Syntax: Sprite/Animation path, offset_x, offset_y, animation_speed
    self.box_sprite = {"enemies/peonie/spared", 0, 0, 4/30}
    
    -- Recruit Status (saved to the save file)
    -- Number: Recruit Progress
    -- Boolean: True = Recruited | False = Lost Forever
  --  self.recruited = true
    
    -- Whether the recruit will be hidden from the recruit menu (saved to the save file)
    self.hidden = false
end

return peonie