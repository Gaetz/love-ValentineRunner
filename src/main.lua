io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end

--Including files
require "spriteManager" 
require "parallaxManager"
require "particles"
require "pandaSprite"

local screenWidth
local screenHeight
local panda
local groundPosition

local parallaxManager
local spriteManager
local particles

function love.load()
  
  love.window.setMode(512 * 2, 256 * 2)
  love.window.setTitle("Valentine Runner")
  screenWidth = love.graphics.getWidth() / 2
  screenHeight = love.graphics.getHeight() / 2
  -- Utils
  parallaxManager = ParallaxManager()
  spriteManager = SpriteManager()
  particles = Particles()
  -- Panda
  panda = spriteManager.get(PandaSprite())
  groundPosition = screenHeight-30
  -- Parallaxes
  parallaxManager.addParallax("paralax_sky.png", 0)
  parallaxManager.addParallax("paralax_sea-clouds.png", 0.01)
  parallaxManager.addParallax("paralax_mountains-bg.png", 0.05)
  parallaxManager.addParallax("paralax_mountains-middle.png", 0.1)
  parallaxManager.addParallax("paralax_mountains.png", 0.2)
  parallaxManager.addParallax("paralax_trees.png", 0.8)
  parallaxManager.addParallax("paralax_behind-grass.png", 1)
  parallaxManager.addParallax("paralax_grass.png", 1.2)
  -- Particules
  particles.load()

end

function love.update(dt)
  parallaxManager.update(dt)
  spriteManager.update(panda, dt)
  particles.update(dt)
end

function love.draw()
  love.graphics.push()
  
  -- Double scale
  love.graphics.scale(2,2)
  
  -- Draw parallaxes
  parallaxManager.draw()
    
  -- Draw the particle system behind the panda
  particles.draw(screenWidth / 4 + 18, groundPosition + 12)
  -- Draw the panda above particles
  spriteManager.draw(panda, screenWidth / 4, groundPosition)

  love.graphics.pop()
end