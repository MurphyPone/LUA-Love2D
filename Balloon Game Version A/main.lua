require("anAL")
require("balloons")

function love.load()
	balloons = {}
	numBalloons = 5
	health = 3 
	score = 0

	font = love.graphics.newFont(20)
	love.graphics.setFont(font)
	loseText = "All the balloons got away :("

	popSound = love.audio.newSource("pop.mp3")

	for i = 1, numBalloons do 
		i = Balloon:create()
	end 
	
	love.graphics.setBackgroundColor(252, 182, 182)
end 

function love.draw()
	if health > 0 then 
		for k, v in pairs(balloons) do 
			v:draw()
		end

		love.graphics.print("Score: "..score, 10, 20)
		love.graphics.print("Health: "..health, 10 + font:getWidth("Score: "..score)+ love.graphics.getWidth()/20, 20)

	else 
		love.graphics.print(loseText, love.graphics.getWidth()/4, 100)
	end
end

function love.update(dt)
	if health > 0 then 
		for k, v in pairs(balloons) do 
			v:update(dt)
		end
	end 
end 

function love.mousepressed(x, y, button, istouch)
	for k,v in pairs(balloons) do 
		if insideBox(x, y, v.x, v.y, v.frameW, v.frameH ) then 
			score = score +1 
			v.state = "popped"
			love.audio.play(popSound)
		end 
	end 

	print(font:getWidth("Health: "..health))
	if health <= 0 and insideBox(x, y, love.graphics.getWidth()/4, 100, font:getWidth(loseText), font:getHeight(loseText) ) then
		for k, v in pairs(balloons) do 
			v:reset()
		end
		print(true)
		health = 3 
		score = 0

	end
end 



-- Point-collision detection function.
-- Returns true if a point and a rectangle overlap, false if they don't
-- px,py are the coords of the point, while w1,h1 are its width and height
-- x,y, w,h are the coords, width and height of the rectangle
function insideBox( px, py, x, y, wx, wy )
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end