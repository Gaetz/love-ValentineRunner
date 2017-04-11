function SpriteManager()
  serializationVersion = 1.0
  this = {}

  this.spriteBank = {} --Map with all the sprite definitions 
  this.imageBank = {} --Contains all images that were already loaded

  function loadSprite(spriteDef) -- private
    if spriteDef == nil then return nil end --Load the sprite definition file to ensure it exists    
    
    local definitionFile = loadfile(spriteDef) 
    --If the file doesn't exist or has syntax errors, it'll be nil.    
    if definitionFile == nil then
      print("Attempt to load an invalid file (inexistent or syntax errors?): "..spriteDef)         
      return nil
    end 

    local oldSprite = this.spriteBank[spriteDef]     
    this.spriteBank[spriteDef] = definitionFile()
    
    --Check the version to verify if it is compatible with this one.   
    if this.spriteBank[spriteDef].serializationVersion ~= serializationVersion then 
      print("Attempt to load file with incompatible versions: "..spriteDef) 
      print("Expected version "..serializationVersion..", got version "..this.spriteBank[spriteDef].serializationVersion.." .")
      this.spriteBank[spriteDef] = oldSprite -- Undo the changes due to error 
      -- Return old value (nil if not previously loaded)
      return this.spriteBank[spriteDef]
    end 
    
    --Storing the path to the image in a variable (to add readability)
    local spriteSheet = this.spriteBank[spriteDef].spriteSheet 

    --Load the image.    
    local oldImage = this.imageBank[spriteSheet]     
    this.imageBank[spriteSheet] = love.graphics.newImage(spriteSheet)
    
    --Check if the loaded image is valid.    
    if this.imageBank[spriteSheet] == nil then 
      -- Invalid image, reverting all changes        
      this.imageBank[spriteSheet] = oldImage   
      -- Revert image        
      this.spriteBank[spriteDef] = oldSprite    
      -- Revert sprite
      print("Failed loading sprite "..spriteDef..", invalid image path ( "..spriteSheet.." ).")     
    end
    
    return this.spriteBank[spriteDef]
  end

  this.get = function(spriteDef) 
    if spriteDef == nil then return nil end
    
    -- invalid use
    if this.spriteBank[spriteDef] == nil then 
      --Sprite not loaded attempting to load; abort on failure.        
      if loadSprite(spriteDef) == nil then 
        return nil 
      end
    end
    
    --All set, return the default table.    
    return {         
      sprite = this.spriteBank[spriteDef], --Sprite reference 
      --Sets the animation as the first one in the list.        
      currentAnim = this.spriteBank[spriteDef].animationNames[1],
      currentFrame = 1,
      elapsedTime = 0,
      sizeScale = 1,
      timeScale = 1,
      rotation = 0,
      flipH = 1,
      flipV = 1   
    }
  end

  this.update = function(spr, dt) 
    --Increment the internal counter.
    spr.elapsedTime = spr.elapsedTime + dt 

    --We check we need to change the current frame.
    if spr.elapsedTime > spr.sprite.frameDuration * spr.timeScale then
      --Check if we are at the last frame.
      if spr.currentFrame < #spr.sprite.animations[spr.currentAnim] then 
        -- Not on last frame, increment.
        spr.currentFrame = spr.currentFrame + 1
      else -- Last frame, loop back to 1.
        spr.currentFrame = 1
      end 
      -- Reset internal counter on frame change.
      spr.elapsedTime = 0
    end
  end

  this.draw = function(spr, x, y) 
    if(spr == nil) then return end
    love.graphics.draw(
      this.imageBank[spr.sprite.spriteSheet],
      --The image --Current frame of the current animation
      spr.sprite.animations[spr.currentAnim][spr.currentFrame],
      x,
      y,
      spr.rotation,
      spr.sizeScale,
      spr.sizeScale,
      flipH,
      flipV
    )
  end
  
  return this
end