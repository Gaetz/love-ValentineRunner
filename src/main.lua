io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end

require "spriteManager" --Including the file
require "parallaxManager" --Including the file

local screenw
local screenh
local groundPosition
local panda

local parallaxManager
local spriteManager

function love.load()
  
  love.window.setMode(512*2, 256*2)
  love.window.setTitle("Valentine runner")
  screenw = love.graphics.getWidth()/2
  screenh = love.graphics.getHeight()/2
  
  parallaxManager = ParallaxManager()
  spriteManager = SpriteManager()

  parallaxManager.addParallax("paralax_sky.png", 0)
  parallaxManager.addParallax("paralax_sea-clouds.png", 0.01)
  parallaxManager.addParallax("paralax_mountains-bg.png", 0.05)
  parallaxManager.addParallax("paralax_mountains-middle.png", 0.1)
  parallaxManager.addParallax("paralax_mountains.png", 0.2)
  parallaxManager.addParallax("paralax_trees.png", 0.8)
  parallaxManager.addParallax("paralax_behind-grass.png", 1)
  parallaxManager.addParallax("paralax_grass.png", 1.2)
  
  panda = spriteManager.get("pandaSprite.lua")

  groundPosition = screenh-30
end

function love.update(dt)
  parallaxManager.update(dt)
  spriteManager.update(panda, dt)
end

function love.draw()
  love.graphics.push()
  -- double scale
  love.graphics.scale(2,2)
  
  parallaxManager.draw()
  spriteManager.draw(panda, screenw/4, groundPosition)
  
  love.graphics.pop()
end