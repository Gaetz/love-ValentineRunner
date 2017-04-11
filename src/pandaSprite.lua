local imageW = 320 
local imageH = 20
        
return {
  serializationVersion = 1.0,
  
  spriteSheet = "images/running-panda.png", 
  spriteName = "panda", -- The name of the sprite

  frameDuration = 0.07,
  
  animationNames = {
    "run"
  },

  animations = { 
    run = {
      love.graphics.newQuad( 1, 1, 40, 20, imageW, imageH ),
      love.graphics.newQuad( 41, 1, 40, 20, imageW, imageH ),
      love.graphics.newQuad( 81, 1, 40, 20, imageW, imageH ),
      love.graphics.newQuad( 121, 1, 40, 20, imageW, imageH ),
      love.graphics.newQuad( 161, 1, 40, 20, imageW, imageH ),
      love.graphics.newQuad( 201, 1, 40, 20, imageW, imageH ),
      love.graphics.newQuad( 241, 1, 40, 20, imageW, imageH ),
      love.graphics.newQuad( 281, 1, 40, 20, imageW, imageH )
    }
  }
}
       