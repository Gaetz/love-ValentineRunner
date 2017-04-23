require "parallax" --Including the file

function ParallaxManager()
  serializationVersion = 1.0
  this = {}
  
  local parallaxes = {}
  
  this.addParallax = function(filename, speed)
    parallax = Parallax()
    parallax.load(filename, speed)
    table.insert(parallaxes, parallax)
  end
  
  this.update = function(dt) 
    for i=1, #parallaxes do 
      parallaxes[i].update(dt) 
    end
  end
  
  this.draw = function() 
    for i=1, #parallaxes do 
      parallaxes[i].draw() 
    end
  end
  
  return this
end