Hello, this is my ShadowLib. 

There are three objects to implement shadows. 

`ShadowEvent`, `Shadow`, `PerspectiveShadow` -- is where you should look to see this. 

I will explain what each does. 

# Perspective Shadow

Add a point on the `objects` layer, and name it `full_shadow`. 

This object takes three properties. You should add them all as `float`. 

`opacity` - How light/dark should the shadows be? Defaults to `0.5`. 
`shear` - Slants the shadow at an angle. Defaults to `-0.5`. 
`scale` - How big should the shadow be, affects scale_x and scale_y. Defaults to `1.5`. 

# Shadow Event 

Add this as a rectangle, or any other polygon for that matter. This takes all the properties from `PerspectiveShadow` and more. 

`fade` - Do the shadows fade out on exit? Defaults to `false`.
`fade_speed` How fast the shadow fades out. Defaults to `0.1`.
`target_opacity` - The opacity the shadow fades out to. Defaults to `0`.

# Shadow 

A normal object that isn't registered through Tiled. This exists for cutscenes, and stuff, to add it, you have to parent the object to the character you want. 

To spawn it and store it in a variable, do 

`local shadow = Shadow({opacity = 1, scale = 1, shear = 1})` - The options table isn't needed, as it will default to the values as shown above. This is just to showcase how you would tweak the values when spawning the object. 

And yeah, that's it. Hope you have fun with the library! 


