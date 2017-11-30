require("rocket")

function love.load()
  WIDTH = love.graphics.getWidth()
  HEIGHT = love.graphics.getHeight()

  --t = Rocket:create()
  population = {} --Flock

  for i = 0, 100 do
    population[i] = Rocket:create()
  end 
  
  love.graphics.setBackgroundColor(120,70,70)
end 

function love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.print("FPS:"..love.timer.getFPS(), WIDTH-50, 10)

  --t:draw()

  --population.draw
  for k, v in pairs(population) do 
     v:draw()
  end 
end

function love.update(dt)
  --t:update()

  --population.udpdate
  for k, v in pairs(population) do 
     v:update(dt)
  end
  
end

-- Collision detection function.
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function getDist(a, b) 
    -- Get the length for each of the components x and y
    local xDist = a.x - b.x
    local yDist = a.y - b.y

    return math.sqrt( (xDist ^ 2) + (yDist ^ 2) ) 
end
