function PandaSprite()
  this = {}

  local imageW = 320 
  local imageH = 20
        
  this.serializationVersion = 1.0
  this.spriteSheet = "images/running-panda.png"
  this.spriteName = "panda" -- The name of the sprite

  this.frameDuration = 0.07
  
  this.animationNames = {
    "run"
  }

  this.animations = { 
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
  
  return this
 end        