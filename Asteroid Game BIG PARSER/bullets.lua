function bullets_load()
  bulletSpeed = 250 
  bullets = {}

end 

function bullets_draw()
  love.graphics.setColor(255,255,255)
  for i,v in ipairs(bullets) do
    love.graphics.circle("fill", v.x, v.y, 3)
  end

end 

function bullets_update(dt)
  for i,v in ipairs(bullets) do
    v.x = v.x + (v.dx * dt)
    v.y = v.y + (v.dy * dt)
  end


  if (love.math.random(1, player.rate) == 1) then
    bullets_shoot()
  end 
end 

function bullets_shoot(dt)
  --THIS CANNOT EXIST IN THE REAL GAME 
  local startXR = player.xPos + player.width / 2
  local startYR = player.yPos + player.width / 2
  local startXL = player.xPos - player.width / 4
  local startYL = player.yPos + player.width / 4


  local angleR = -math.pi/2 +math.pi/10--= math.atan2((mouseY - startY), (mouseX - startX))
  local angleL = -math.pi/2 -math.pi/10--= math.atan2((mouseY - startY), (mouseX - startX))
  
  local bulletDxR = bulletSpeed * math.cos(angleR)
  local bulletDyR = bulletSpeed * math.sin(angleR)

  local bulletDxL = bulletSpeed * math.cos(angleL)
  local bulletDyL = bulletSpeed * math.sin(angleL)

  table.insert(bullets, {x = startXR, y = startYR, dx = bulletDxR, dy = bulletDyR})
  table.insert(bullets, {x = startXL, y = startYL, dx = bulletDxL, dy = bulletDyL})
end 