function Parallax()
  this = {}
  
  local x
  local img
  local speed
  
  this.load = function(filename, sp)
    x = 1
    img = love.graphics.newImage("images/"..filename)
    speed = sp
  end
  
  this.update = function(dt)
    -- Infinite horizontal scrolling
    x = x - 120 * speed * dt
    if x <= 0 - img:getWidth() then
      x = 1
    end
  end
  
  this.draw = function()
    love.graphics.draw(img, x, 1)
    -- If screen is empty on the right, draw a second background
    if x < 1 then
      love.graphics.draw(img, x + img:getWidth(), 1)
    end
  end
  
  return this
end