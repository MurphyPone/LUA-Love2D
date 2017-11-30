require("player")
require("enemy")
require("food")
require("anAL")

function love.load()
	highscores = {}

	p = Player:new()
	nom = Food:new()

	collectingBgm = love.audio.newSource("sfx/coins/coin1.wav", "static")

	animUp = newAnimation(p.imgUp, 32, 32, 0.1, 0)
	animDown = newAnimation(p.imgDown, 32, 32, 0.1, 0)
	animLeft = newAnimation(p.imgLeft, 32, 32, 0.1, 0)
	animRight = newAnimation(p.imgRight, 32, 32, 0.1, 0)

	if not love.filesystem.exists("scores.lua") then 
		scores = love.filesystem.newFile("scores.lua")	
		love.filesystem.write("scores.lua", "p.highscore\n=\n" ..p.highscore)
	end 

	for lines in love.filesystem.lines("scores.lua") do 
		table.insert(highscores, lines)
	end 

	love.filesystem.write("scores.lua", "p.highscore\n=\n".. p.highscore)
	p.highscore = highscores[3]

	font20 = love.graphics.newFont("fonts/vermin_vibes_redux.ttf", 30)

	backgroundImage = love.graphics.newImage("img/bg.png")

	gamestate = "startmenu"

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
end 

local function drawButton(off, on, x, y, w, h, mx, my)
	local ins = insideBox( mx, my, x - (w/2), y - (h/2), w, h )
	
	love.graphics.setColor( 255, 255, 255, 255 )
	
	if ins then
		love.graphics.draw( on, x, y, 0, 1, 1, (w/2), (h/2) )
	else
		love.graphics.draw( off, x, y, 0, 1, 1, (w/2), (h/2) )
	end
end

function love.update(dt)
	p:update(dt)
	nom:update(dt)
	UPDATE_ENEMY(dt)


	if p.score > tonumber(p.highscore) then 
		p.highscore = p.score 
		love.filesystem.write("scores.lua", "p.highscore\n=\n"..p.highscore)
	end 

	if o.facing == "left" then 
		animLeft:update(dt)
	end 

	if o.facing == "right" then 
		animRight:update(dt)
	end 

	if o.facing == "up" then 
		animUp:update(dt)
	end 

	if o.facing == "down" then 
		animDown:update(dt)
	end 
end 

function love.draw()

	if gamestate =="startmenu" then 
		love.graphics.setBackgroundColor( 190, 190, 190 )
	imgPlay = love.graphics.newImage("img/play.png")
	imgPlayOn = love.graphics.newImage("img/play_on.png")
	imgExit = love.graphics.newImage("img/exit.png")
	imgExitOn = love.graphics.newImage("img/exit_on.png")
	
	buttons = 	{
				{imgOff = imgPlay, imgOn = imgPlayOn, x = 400, y = 300 - 64, w = 256, h = 64, action = "play"},
				{imgOff = imgExit, imgOn = imgExitOn, x = 400, y = 300 + 64, w = 256, h = 64, action = "exit"}
			}

	local x = love.mouse.getX( )
	local y = love.mouse.getY( )

	for k, v in pairs(buttons) do
		drawButton( v.imgOff, v.imgOn, v.x, v.y, v.w, v.h, x, y )
	end


	elseif gamestate == "playing" then
		DRAW_ENEMY() 
		love.graphics.setColor(255,255,255)
		love.graphics.draw(backgroundImage, 0, 0)

		love.graphics.setColor(255,255,255)
		love.graphics.setFont(font20)
		love.graphics.print("Score: "..p.score, 10, 10)
		love.graphics.print("Highscore: "..p.highscore, 150, 10)

		if o.facing == "left" then 
			animLeft:draw(p.x,p.y)
		end 

		if o.facing == "right" then 
			animRight:draw(p.x,p.y)
		end 

		if o.facing == "up" then 
			animUp:draw(p.x,p.y)
		end 

		if o.facing == "down" then 
			animDown:draw(p.x,p.y)
		end 

		nom:draw()
	end 
end 

function love.focus(bool)
	if bool then 
		print("Window Focused")
	else 
		print("Window Unfocused")
	end 
end 

function love.keypressed(key, isrepeat)
	if key == "escape" then
		love.quit()
	end 
end 

function love.keyreleased(key)
end

function love.mousepressed(x, y, button)
	if gamestate == "startmenu" then 
		if button == "l" then
		for k, v in pairs(buttons) do
			local ins = insideBox( x, y, v.x - (v.w/2), v.y - (v.h/2), v.w, v.h )
			
			if ins then
				if v.action == "play" then
					gamestate = "playing"
				elseif v.action == "exit" then
					love.event.quit()
				end
			end
		end
	end
	end 
end 

function love.mousereleased(x, y, button)
end

function love.joystickpressed(joystick, button)
end  

function love.quit()
	print("Shutting Down...Saving Files...")
	love.filesystem.write("scores.lua", "p.highscore\n=\n"..p.highscore)
	love.event.quit( )
end 

function insideBox( px, py, x, y, wx, wy )
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end