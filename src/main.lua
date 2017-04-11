io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end

local screenw -- largeur écran
local screenh -- hauteur écran

-- Fond des zones
local imgBG1 = love.graphics.newImage("images/forest.png")
-- Position horizontale du fond (pour scrolling)
local bgX = 1
local groundPosition


function love.load()
  
  love.window.setMode(512*2,256*2)
  love.window.setTitle("Valentine runner")
  screenw = love.graphics.getWidth()/2
  screenh = love.graphics.getHeight()/2
  
  
  require "spriteManager" --Including the file
  spriteManager = SpriteManager()
  
  panda = spriteManager.get("pandaSprite.lua")
  
  groundPosition = screenh-30
end

function love.update(dt)
  spriteManager.update(panda, dt)
  
  -- Scrolling infini du fond
  bgX = bgX - 120*dt
  if bgX <= 0-imgBG1:getWidth() then
    bgX = 1
  end
end

function love.draw()
  love.graphics.push()
  -- double scale
  love.graphics.scale(2,2)
  
  love.graphics.draw(imgBG1,bgX,1)
  -- Si il y a du noir à droite, on dessine un 2ème fond
  if bgX < 1 then
    love.graphics.draw(imgBG1,bgX + imgBG1:getWidth(),1)
  end
  
  spriteManager.draw(panda, screenw/4, groundPosition)
  
  love.graphics.pop()
end