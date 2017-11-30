Food = {}
require("player")

function Food:new()
	o2 = {
		w = 16,
		h = 16, 
		x = math.random(800- 16),
		y = math.random(600 + 32),
		img = love.graphics.newImage("img/food.png"),
	}
	setmetatable(o2, { __index = Food})
	return o2
end 

function Food:update(dt)
	if o.y + o.h > self.y and o.y < self.y + self.h and o.x +o.w > self.x and o.x <self.x + self.w then
		o.score = o.score + 1
		Food:respawn()
		collectingBgm:play()
	end 
end 

function Food:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(o2.img, o2.x, o2.y)
end 

function Food:respawn()
	o2.x = math.random(800 - 16)
	o2.y = math.random(32+o2.h,600) 
end 

