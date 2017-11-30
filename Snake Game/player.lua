Player = {}

function Player:new()
	o = {
		x = 30, 
		y = 30,
		w = 32,
		h = 32,
		speed = 300,
		score = 0,
		highscore = 0,
		imgUp = love.graphics.newImage("img/playerUp.png"),
		imgDown = love.graphics.newImage("img/playerDown.png"),
		imgRight = love.graphics.newImage("img/player.png"),
		imgLeft = love.graphics.newImage("img/playerLeft.png"),
		facing = "left"
	}
	setmetatable(o, { __index = Player })
	return o
end 

function Player:update(dt)
	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then 
		o.x = o.x - o.speed *dt
		o.facing = "left"
	end 

	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then 
		o.x = o.x + o.speed *dt
		o.facing = "right"

	end 
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then 
		o.y = o.y - o.speed *dt
		o.facing = "up"
	end 
	if love.keyboard.isDown("s") or love.keyboard.isDown("down") then 
		o.y = o.y + o.speed *dt
		o.facing = "down"
	end 

	if o.x> love.graphics.getWidth() - o.w then 
		o.x = love.graphics.getWidth() - o.w
	end 
	
	if o.y > love.graphics.getHeight() - o.h then 
		o.y = love.graphics.getHeight() - o.h
	end  
	
	if o.x <0 then 
		o.x = 0
	end

	if o.y < 32 then 
		o.y = 32
	end  
end 
