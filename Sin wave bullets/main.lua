local player 

function love.load()
  cx , cy = love.graphics.getWidth()/2,  love.graphics.getHeight()/2

  player = {
    x = cx, 
    y = cy, 
    vel = 500, 
    size = 20,
    rot = 0 
  }


  bulletSpeed = 300
  lifeSpan = 200
  bullets = {}


  --temp wave variables
  x = 0
  freq = 20 --< 20 = good val
  amp = 20

end 

function love.update(dt)
  player.rot = player.rot + 5* dt
  
  --if(x < love.graphics.getWidth()) then x = x + 5 else x = 0 end 

  if love.keyboard.isDown("a") then player.x = player.x - player.vel *dt end 
  if love.keyboard.isDown("d") then player.x = player.x + player.vel *dt end 
  if love.keyboard.isDown("w") then player.y = player.y - player.vel *dt end 
  if love.keyboard.isDown("s") then player.y = player.y + player.vel *dt end

  if love.keyboard.isDown("q") then freq = freq - 1 end
  if love.keyboard.isDown("e") then freq = freq + 1 end

  if love.keyboard.isDown("r") then amp = amp - 1 end
  if love.keyboard.isDown("t") then amp = amp + 1 end


  --REMOVING OLD BULLETS
  for i, v in ipairs(bullets) do 
    v.span = v.span + 1

    if v.x > cx*2 then 
      table.remove(bullets, i)
    end 
    if(v.span > lifeSpan ) then 
      table.remove(bullets, i)
    end 
  end 
end 

function love.draw()
  --disp wave info
    love.graphics.print("Freq (q,e) : ".. freq, 10, 10)   --dist freq, low amp
    love.graphics.print("amp (t,r) : ".. amp, 10, 30)

    --Draw player
    drawPlayer()
  

    --THIS MATH HAS TO GO IN DRAW FOR PUSH/POP
    --need to rotate by -angle so that forward = to the right 
    --x go forward
    --y = sin(x)
    --MATH Bullet
    for i,v in ipairs(bullets) do
      love.graphics.push()
        love.graphics.translate(v.x, v.y) --origin to center of bullet
        love.graphics.rotate(-v.r)  --rotate by -angle from v to mouse 
         --v.x = v.x + (v.dx * 0.02) + (math.cos(v.y/freq) * amp)--Should not be a function of y
         --v.y = v.y + (v.dy * 0.02) + (math.sin(v.x/freq) * amp) --(math.sin(v.dx/freq) * amp)  --THIS SHOULD WORK!!!
        
    --[[A * sin(B * (x - C))) + D 

        A = Amplitude (Tallness) of the wave.
        B = How many waves there are for each cycle.
        C = How far to shift the wave’s X position.
        D = How far to shift the wave’s Y position. --]]
      
         v.x = v.x + v.dx *.02
         v.y = v.y + (v.dy *.02) * math.sin(v.x/freq) ;
        love.graphics.circle("fill", 0, 0, 3) --draw bullet
      love.graphics.pop()
    end

end


function love.mousepressed(x, y, button)
  if button == 1 then
    local startX = player.x + player.size / 2
    local startY = player.y + player.size / 2
 
    local angle = math.atan2((y - startY), (x - startX))

    local bulletDx = bulletSpeed * math.cos(angle)
    local bulletDy = bulletSpeed * math.sin(angle)
 
    --table.insert(bullets, {x = startX, y = startY, r = angle})    --HANDLE AS CLUSTER?
    table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy, r = angle, span = 0})
  end
end

function drawPlayer()
  local angle
  love.graphics.push()
      love.graphics.translate(player.x, player.y)
      love.graphics.rotate(player.rot/2)
      love.graphics.circle("line", 0, 0, player.size, 5) -- draw player 
    love.graphics.pop()

    love.graphics.push()
      love.graphics.translate(player.x, player.y)
      love.graphics.rotate(-player.rot)
      love.graphics.circle("line", 0, 0, player.size-3, 5) -- draw player 
    love.graphics.pop()

    love.graphics.push()
      love.graphics.translate(player.x, player.y)
      love.graphics.rotate(-player.rot/4)
      love.graphics.circle("line", 0, 0, player.size+3, 7) -- draw player 
    love.graphics.pop()

    love.graphics.push()
      love.graphics.translate(player.x, player.y)
      local startX = player.x + player.size / 2
      local startY = player.y + player.size / 2
      local x, y = love.mouse.getPosition()
      angle = math.atan2((y - startY), (x - startX))
      love.graphics.rotate(angle)
        love.graphics.setColor(0, 200, 90)        ---ONLY PUSHES COORD SYSTEM, NOT CANVAS
        love.graphics.line(0, 0, player.size, 0 )
        love.graphics.setColor(255, 255, 255)
    love.graphics.pop()

    love.graphics.print(angle, 10, 50)
end