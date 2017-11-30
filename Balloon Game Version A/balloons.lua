require("anAL")

Balloon = {}

function Balloon:create()
	love.math.setRandomSeed(os.time())
	b = {}
		b.imgs = {"imgs/balloonSprite.png", "imgs/balloonSprite_blue.png", "imgs/balloonSprite_green.png", "imgs/balloonSprite_yellow.png"}

		b.img = love.graphics.newImage(tostring(b.imgs[math.random(1,4)]))
		b.frameW = 23
		b.frameH = 56

		b.imgPop = love.graphics.newImage("imgs/pop.png")
		b.popW = 49
		b.popH = 56

		b.x = math.random(b.frameW, love.graphics.getWidth()-b.frameW)
		b.y = math.random(love.graphics.getHeight(), love.graphics.getHeight()+500)
		b.speed = 0

		b.animFloat = newAnimation(b.img, b.frameW, b.frameH, .1, 0)
		b.animPop = newAnimation(b.imgPop, b.popW, b.popH, .05, 0)

		b.state = "floating" --floating, popped
		b.animTimer = 5


		setmetatable(b, { __index = Balloon })

		table.insert(balloons, b)
		return b
end 


function Balloon:draw()
	if self.state == "floating" then 
		self.animFloat:draw(self.x, self.y)
	elseif self.state == "popped" then
		self.animPop:draw(self.x, self.y)
	end 
end 

function Balloon:update(dt)
	if self.state == "floating" then 

		self.animFloat:update(dt)
		self.speed = self.speed + 20 *dt

		if self.y > 0 - self.frameH then 
			self.y = self.y - self.speed*dt
		else 
			health = health - 1 
			self:reset()
		end
	elseif self.state == "popped" then 

		if self.animTimer < 0 then 
			self:reset()
		else 
			self.animTimer = self.animTimer - 1
			self.animPop:update(dt)
		end 

	end 
end 

function Balloon:reset()
	self.y = love.graphics.getHeight()
	self.x = math.random(self.frameW/2, love.graphics.getWidth()-self.frameW/2)
	self.speed = 0
	self.state = "floating"
	self.animTimer = 10
end 