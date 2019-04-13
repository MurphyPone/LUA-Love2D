-- «« Bishop Ireton Practice Hackathon
-- «« Difficulty: Easy  
-- «« Objective: Fill in the missing code so that:
--      1. The button image that corresponds to the user's mouse input is displayed on the screen
--      2. The user's score and highscore are displayed on the screen
--      3. If the user clicks on a textfield that says "RESET", the highscore is reset
--      4. If the user's score is greater than the highscore, the highscore equals the player's new, higher score.
--		5. When the button is clicked, it moves to a new location entirely on the screen.

-- Goodluck! The wiki and IPH staff are your friends.
-- https://love2d.org/wiki/Main_Page

function love.load()
	--Declare a table called highscores which will hold the data we save to and load from
	highscores = {}
	--Declare variables called clicks and highscore and set them both to 0
	clicks = 0
	highscore = 0
	
	--This checks if a file called "myFile.lua" exists in the LOVE filesystem directory which is located at:
		--Windows XP: C:\Documents and Settings\user\Application Data\LOVE\ or %appdata%\LOVE\
		--Windows Vista & 7: C:\Users\user\AppData\Roaming\LOVE or %appdata%\LOVE\
		--Mac: /Users/user/Library/Application Support/LOVE/
	if not love.filesystem.exists("myFile.lua") then 
		--This line declares a variable called myFile whose value is a new file called myFile.lua
		myFile = love.filesystem.newFile("myFile.lua")	
		--This line writes to the file myFile.lua, and inserts the string "myFile =" with the appendage of the highscore variable
		love.filesystem.write("myFile.lua", "myFile\n=\n" ..highscore)
	end 

	--This line is a for loop that iterates through the lines of myFile.lua
	for lines in love.filesystem.lines("myFile.lua") do 
		--This line inserts the contents of myFile.lua into the highscores table
		table.insert(highscores, lines)
	end 

	--Set the value of the highscore variables to the third entry in the highscores table
	--Hint: Because all of the entries of the highscores table are string, you need to convert them to a numeric value using the tonumber() function
	highscore = tonumber(highscores[3])

	--Declare three variables caleld unclicked, preclick, and clicked and set their values to the corresponding images in this directory
	unclicked = love.graphics.newImage("unclicked.png")
	preclick = love.graphics.newImage("preclick.png")
	clicked = love.graphics.newImage("clicked.png")

	--Declare a variable called currentButton and set its value to unlclicked for now
	currentButton = unclicked

	--Declare a variable called buttonX and set its value to a positive multiple of 100
	buttonX = 100 --love.graphics.getWidth()/2-currentButton:getWidth()/2
	--Declare a variable called buttonY and set its value to the vertical center of the screen
	buttonY = love.graphics.getHeight()/2
	--Declare variables called buttonW and buttonH and set their values to the width of the currentButton's width and height
	buttonW = currentButton:getWidth()
	buttonH = currentButton:getHeight()

	--Declare a variable called font and set it equal to a new 10pt font
	font = love.graphics.newFont(10)
	--Declare variables called resetX and resetY and set their values to be 750 and 10
	resetX = 750
	resetY = 10 
	--Declare a variable called resetW and set its value to the width of the string "RESET" + 10
	resetW = font:getWidth("RESET") + 10
	--Declare a variable called resetH and set its value to the height of the string "RESET" + 6
	resetH = font:getHeight("RESET") + 6
end

function love.draw()
	--Reset the color to white
	love.graphics.setColor(255,255,255)
	--Draw the currentButton at the corresponding x and y variables which we declared in love.load()
	love.graphics.draw(currentButton, buttonX , buttonY)

	--In the top left corner of the screen, display the string "Score: " and concatinate the current score (the variable click) to the end of the string.  
	love.graphics.print("Score: "..clicks, 10, 10)
	--Directly to the right of the "Score: " string you just displayed, display the string "Highscore: " and concatinate the highscore to the end of the string.  
	love.graphics.print("Highscore: "..highscore, 100, 10)
	
	--Set the color to red
	love.graphics.setColor(255,0,0)
	--Draw a rectangle with the syle "fill" using the resetX, resetY, resetW, and resetH variables 
	love.graphics.rectangle("fill", resetX, resetY, resetW, resetH)
	--Reset the color to white to draw the text itself
	love.graphics.setColor(255,255,255)
	--Display the text "RESET" using the resetX and resetY variables.  Add or subtract a few pixels to center the text in the red box 
	love.graphics.print("RESET", resetX + 2, resetY+2)
end 

function love.update(dt)
	--Declare two local variables called mouseX and mouseY and set their values to the result of the corresponding love.mouse.getX() or love.mouse.getY() methods
	local mouseX = love.mouse.getX()
	local mouseY = love.mouse.getY()

	--Check if the users current score is greater than the highscore 
	--If so:
		--set the highscore to equal the current score
		--Update the highscore file by writing to myFile.lua 
		--Hint: Use the same method that we used in love.load() when first checking if myFile.lua exists or not
	if clicks > highscore then
		highscore = clicks
		love.filesystem.write("myFile.lua", "myFile\n=\n" ..highscore)
	end 

	--Using the insideBox() function and the mouseX & mouseY variables we declared, check if the users cursor is over the button
	--If so:
		--Check if the user is pressing the left mouse button
		--If so:
			--Change the value of currentButton to the corresponding variable we declared in love.load()
			--Increase the value of the clicks variable by 1 
			--change the buttonX and buttonY values to a location on the screen while still keeping the button entirely visible on the screen
		--Otherwise:
			--Change the value of currentButton to the corresponding variable we declared in love.load() 
	--Otherwise:
		--Change the value of currentButton to the corresponding variable we declared in love.load()
	if insideBox(mouseX, mouseY, buttonX, buttonY, buttonW, buttonH) then
		if love.mouse.isDown(1) then 
			currentButton = clicked
			clicks = clicks + 1 
			buttonX = math.random(0,love.graphics.getWidth() - buttonW)
			buttonY = math.random(0,love.graphics.getHeight() - buttonH)
		else 
			currentButton = preclick
		end 
	else 
		currentButton = unclicked
	end
end 

function love.mousepressed(x, y, button, istouch)
	--Using the insideBox() function, check if the user clicks inside the red 'reset' box we draw in the top right of the screen
	--If so:
		--Reset the value of clicks
		--Reset the value of highscore
		--Update the highscore file by writing to myFile.lua 
		--Hint: Use the same method that we used in love.load() when first checking if myFile.lua exists or not
	if insideBox(x, y, resetX, resetY, resetW, resetH) then
		clicks = 0
		highscore = 0
		love.filesystem.write("myFile.lua", "highscore\n=\n"..0)
	end 
end 

function love.quit()
	print("Shutting Down...Saving Files...")
	--Save the the highscore file before the program closes by writing to myFile.lua 
	--Hint: Use the same method that we used in love.load() when first checking if myFile.lua exists or not
	love.filesystem.write("myFile.lua", "highscore\n=\n".. highscore)
	love.event.quit( )
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