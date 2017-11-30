require("bullets")
require("score")

--Have to re-declare bc fml
screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

--GO BACK AND CHANGE SCFEEN RES TO iOS

Enemy = {} --Represents whole object 
enemies = {} 

function Enemy:new()
	eimgs = {
		[1] = love.graphics.newImage("img/enemies/Enemie 1.png"),
		[2] = love.graphics.newImage("img/enemies/Enemie 2.png"),
		[3] = love.graphics.newImage("img/enemies/Enemie 3.png"),
		[4] = love.graphics.newImage("img/enemies/Enemie 4.png"),
		[5] = love.graphics.newImage("img/enemies/Enemie 5.png")
 	}

	love.math.setRandomSeed(os.time())
  	e = {
  		xPos = math.random(0,screenWidth),
		yPos = -10,
		vel = 20,
		width = 32,
		shape = eimgs[math.random(1,5)]
	}

	setmetatable(e, { __index = Enemy })
  	return e
end

 
function Enemy:update(dt)
	self.yPos = self.yPos + (self.vel*3) * dt 

	if self.xPos > player.xPos then 
		self.xPos =self.xPos - (self.vel * dt)
	end 

	if self.xPos < player.xPos then 
		self.xPos = self.xPos + (self.vel * dt)
	end 

	self:isHit()
end 

function Enemy:draw()
	--love.graphics.rectangle("line",self.xPos,self.yPos,self.width,self.width)
	love.graphics.draw(self.shape, self.xPos, self.yPos)
end 


function Enemy:isHit()	--Checks collision with bulletsb
	for i = #bullets, 1, -1  do 
		if CheckCollision(self.xPos, self.yPos, self.width, self.width, bullets[i].x ,bullets[i].y, 3, 3) then 
			print("enemy down ")
			self:reset()
			table.remove(bullets, i)
			myScore.score = myScore.score + 20


		elseif self.yPos > screenHeight then
			self:reset()
		end 
	end 
end

function Enemy:reset()
	print("reseting enemy")
	self.yPos = -10
	self.xPos = math.random(0, screenWidth)
end 