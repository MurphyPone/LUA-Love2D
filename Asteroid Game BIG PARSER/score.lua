--Have to re-declare bc fml
screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

Score = {}

function Score:new()
  	s = {
		score = 0,
		font = love.graphics.newFont("fonts/kremlin.ttf", 30),
		highscore = 0
	}

	setmetatable(s, { __index = Score })
  	return s
end

function Score:update(dt)
	if gamestate == "playing" then 
		s.score = math.floor(s.score + 1)
	end 
end 

function Score:draw()
	love.graphics.setFont(s.font)
	love.graphics.print(s.score, screenWidth/2 - s.font:getWidth(s.score)/2, 5)
end
