function Particles()
  this = {}
  local img
  local psystem

  this.load = function()
    img = love.graphics.newImage('images/heart.png')
    psystem = love.graphics.newParticleSystem(img, 50)
    psystem:setParticleLifetime(2, 3) -- Particles live in seconds
    psystem:setLinearAcceleration(-10, -4, -100, 4) -- Randomized movement towards the left of the screen.
    psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to black.
  end
  
  this.update = function(dt)
    psystem:update(dt)
    psystem:emit(1)
  end
  
  this.draw = function(x, y)
    love.graphics.draw(psystem, x, y)
  end
  
  return this
end