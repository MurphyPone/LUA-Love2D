require("enemies")
require("shop")

--Have to re-declare bc fml
screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

--GO BACK AND CHANGE SCFEEN RES TO iOS

Ship = {} --Represents whole object 

function Ship:new()
  	p = {
  		xPos = screenWidth/2,
		yPos = screenHeight - screenHeight/8,
		rotation = 0,
		width = 32,
		height = 48,
		img = love.graphics.newImage("img/player.png"),
		leftTurret = love.graphics.newImage("img/turretL.png"),
		rightTurret = love.graphics.newImage("img/turretR.png"),
		score = 0,
		fireImg = love.graphics.newImage("img/fire/sheey.png"),

		rate= 16

	}

	setmetatable(p, { __index = Ship })
  	return p
end


function Ship:update(dt)
	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then 
		p.rotation = p.rotation - 2 * dt
	end 

	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then 
		p.rotation = p.rotation + 2 * dt
	end 

	--Edge detection 
	--Right side of the screen
	if (p.xPos < screenWidth - p.img:getWidth()/2 ) then
		p.xPos = p.xPos + (p.rotation * 1000) * dt
	else 
		p.xPos = screenWidth - p.img:getWidth()/2 
	end

	--Left Side of the Screen
	if (p.xPos > p.img:getWidth()/2 ) then
		p.xPos = p.xPos + (p.rotation * 1000) * dt
	else 
		p.xPos = p.img:getWidth()/2
	end 

	Ship:isHit()


end 

function Ship:draw()
	--love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
	--Main
	love.graphics.draw(p.img, p.xPos, p.yPos, p.rotation, 1, 1, 16, 16 )

	--local degrees = ( * 180)/math.pi
	--Left
	love.graphics.draw(p.leftTurret, p.xPos-18, p.yPos, p.rotation-45, 1, 1, 8, 8 )

	--Right
	love.graphics.draw(p.rightTurret, p.xPos+18, p.yPos, p.rotation+45, 1, 1, 8, 8 )

end 


function Ship:isHit()	--Checks collision with enemies
	for i = 1, #enemies do 
		if CheckCollision(p.xPos, p.yPos, p.width, p.height, enemies[i].xPos,enemies[i].yPos, enemies[i].width, enemies[i].width) then 
			print("gameover")
			gamestate = "deathscreen"
		end 
	end 

end
