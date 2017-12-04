require("point")
require("flower")

function love.load()
  love.filesystem.setIdentity('Procedural Flower')
  showStats = true

  WIDTH = love.graphics.getWidth()
  HEIGHT = love.graphics.getHeight()
  c = {}
    c.x = WIDTH/2
    c.y = HEIGHT/2
 
 flower = Flower:create(200)
  
  love.graphics.setBackgroundColor(50,50,50)
end 

function love.draw()
  love.graphics.setColor(255,255,255)

  flower:draw()

  if(showStats) then 
    love.graphics.print("FPS:"..love.timer.getFPS(), WIDTH-50, 10)
    local stats = love.graphics.getStats()
    local str = string.format("Estimated amount of texture memory used: %.2f MB", stats.texturememory / 1024 / 1024)
    love.graphics.print(str, 10, 10)
  end 
end

function love.update(dt)
  flower:update(dt)
end

function love.keypressed(key, isrepeat)
  if(key == "space") then 
    flower = Flower:create(300)
  elseif (key == "q") then
    showStats = false 
    local screenshot = love.graphics.newScreenshot();
    screenshot:encode('png', 'flower.png');
  end 

end 

function map(n, start1, stop1, start2, stop2) 
  return ((n-start1)/(stop1-start1))*(stop2-start2)+start2
end 

function getDist(a, b) 
    -- Get the length for each of the components x and y
    local xDist = a.x - b.x
    local yDist = a.y - b.y

    return math.sqrt( (xDist ^ 2) + (yDist ^ 2) ) 
end


