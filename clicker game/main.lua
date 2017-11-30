--MAY NEED TO CONVERT ALL INSTANCES OF MOUSE CLICK TO SCREENPRESSED

function love.load()
	--sets random seed to by the computer's time so we get a new random seed everytime we load the program
	seed = math.randomseed(os.time())

	--declares variables that we can use to quickly reference the widnows's width and height based off the values set in conf.lua 
	sW = love.graphics.getWidth()
	sH = love.graphics.getHeight()

	--declares variables which we can use to quickly reference the cursor's x and Y position
	cursorX = love.mouse.getX()
	cursorY = love.mouse.getY()

	--variables used to keep track of the score
	countdown = 10
	score = 0

	--allows us to determine what objects should be displayed on the screen
	gamestate = "playing"

	--sets the font size for the two different game states
	standardFont = love.graphics.newFont(30)
	loseFont = love.graphics.newFont(30)


	--delcares our table which we will treat as an object which has values that we will use to draw the object
	fruit = {}
		fruit.w = 64
		fruit.h = 64
		fruit.x = math.random(0, sW - fruit.w)
		fruit.y = math.random(0, sH - fruit.h)
		fruit.color = {255, 255, 255}	

	--table of strings which we will draw from when calling the player names when they lose
	termsOfEndearment = {"friend", "pal", "my guy", "jhai buddy", "buddy", "comrade", "player", "really great human", "scholar", "gentleman", "dude", "fellow", "legend", "trooper"}
	term = termsOfEndearment[math.random(1,#termsOfEndearment)]
	loseString = "you lose "..term

end 


function love.draw()
	--checks to see what gamestate we are currently set to
	if gamestate == "playing" then
		--sets font based on gamestate
		love.graphics.setFont(standardFont)
		--sets color to be random numbers between 1-255
		love.graphics.setColor(fruit.color[1],fruit.color[2],fruit.color[3])
		--draws the object which the player will click
		fruit.shape = love.graphics.rectangle("fill", fruit.x, fruit.y, fruit.w, fruit.h)
		--sets the color back to white to draw the text
		love.graphics.setColor(255,255,255)
		--declares variables for text and draws them
		counterText = love.graphics.print("Time: "..math.floor(countdown), 5, 10)
		scoreText = love.graphics.print("Score: "..score, 5, 40)

	elseif gamestate == "lost" then
		--sets font and color based on gamestate
		love.graphics.setFont(loseFont)
		love.graphics.setColor(255,0,0) 
		--displays text saying "you lose" and concatenates a string from our table of names to call the player
		love.graphics.print(loseString, 10, 400)
	end 
end 

function love.update(dt)
	if gamestate == "playing" then
		--checks to see if the timer is greater than 0 i.e. the player has not lost yet	
		if countdown > 0 then 
			--decreases the calue of the variable countdown based on the players score so the game gets harder the higher your score is --> making it actually countdown
			countdown = countdown - 1*dt*score
		else 
			--if the timer reaches 0, then change the gamestate to lose
			gamestate = "lost"
			print(gamestate)
		end
	end
end

function love.mousepressed(x, y, button, istouch)
	--checks if the player clicks the left mousebutton
	if button == 1 then
		if gamestate == "playing" then
			--updates the x,y positions of the cursor
			cursorX = x
			cursorY = y

			--checks to see if where the player click is inside the box we called fruit
			if insideBox(cursorX, cursorY, fruit.x, fruit.y, fruit.w, fruit.h) then
				--resets the values of fruit.color[1,2,3] to be random values between 0-255
				for i = 1,#fruit.color do 
					fruit.color[i] = math.random(0,255)
				end 
				
				--changes the fruits position to be a new random place that isn't off the screen
				fruit.x = math.random(0, sW - fruit.w)
				fruit.y = math.random(0, sH - fruit.h)
				--resets the timer and gives the player a little more time for every fruit they get --kinda counteracts the difficulty setting we implemented, but withy these values it just makes the rate of difficulty more gradual
				countdown = 10+(.2*score)
				--increeases the players score
				score = score+1
			end 
		elseif gamestate == "lost" then 
			if button == 1 then
				print("in button lost")
				cursorX = x
				cursorY = y 
				if insideBox(cursorX, cursorY, 10, 400, loseFont:getWidth(loseString), loseFont:getHeight(loseString)) then
					--resets everthing
					countdown = 10
					gamestate = "playing"
					score = 0
					
					term = termsOfEndearment[math.random(1,#termsOfEndearment)]
					loseString = "you lose "..term
				end
			end
		end 
	end
end 



--math for checking if a point is inside a box 
function insideBox( px, py, x, y, wx, wy )
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end