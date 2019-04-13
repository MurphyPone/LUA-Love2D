-- «« Bishop Ireton Practice Hackathon
-- «« Difficulty: Medium  
-- «« Objective: Fill in the missing code so that:
--      1. When the user clicks the screen, a circle is drawn with its center at the mouse click's position
--      2. The circle should grow in size over time
--      3. The circle's transparency should decrease over time 
--      4. The circle should not be drawn if it has faded entirely
--		5. The user should be able to make multiple circles appear on the screen at once

-- Goodluck! The wiki and IPH staff are your friends.
-- https://love2d.org/wiki/Main_Page

function love.load()
	--Declare an empty table called circles
	circles = {}

	--Set the background color to a light blue
	love.graphics.setBackgroundColor(0,150,230)
end 

function love.draw()
	--Declare a for loop that through the number of things inside the circles table
	for i = 1,#circles do 
		--Set the color to be anything, and set the alpha to be the alpha value of circle you are iterating through //PLEASE WORD ME BETTER
		--Hint:to reference a value in a table, the syntax is tbale[#entry in table].proprty of entry in table
		--Example: names[5].first would be the the value corresponding to the "first" value which is linked to the 5th key inside a table called names
		love.graphics.setColor(255, 255 ,255, circles[i].a)
		--Draw circle with the style "line" and 32 segments that corresponds to entry in the circles table that you are currently iterating through
		love.graphics.circle("line", circles[i].x,  circles[i].y,  circles[i].r, 32)
	end 
end 

function love.update(dt)
	--Declare a for loop that through the number of things inside the circles table
	for i = 1,#circles do 
		--Check the value of the "go" key of every entry in the circles table
		--If so:
			--increase the radius and alpha values of of entry in the circles table at a steady rate using the dt parameter of love.update()
		if circles[i].go then 
			circles[i].r = circles[i].r + 100 * dt
			circles[i].a = circles[i].a - 100 * dt
		end 

		--Check to see if the alpha value of every entry in the circles table is less than 0
		--If so:
			--Reset the go, alpha, and radius values of every entry in the circles table to the values they
		if circles[i].a <= 0 then
			 circles[i].go = false
			 circles[i].a = 255
			 circles[i].r = 0

			 --UNCOMMENT THIS LINE TO MAKE THE CIRCLE TABLE NOT INFINITELY HUGE, HOWEVER, ERRORS WITH circle[i].go ARRIS AND I'M NOT SURE WHY
			 --table.remove(circles, i)
		end 
	end 
end 

function love.mousepressed(x, y, button, istouch)
	--Call the constructor method createCircle() and pass in the x,y positions of the love.mousepressed() function as well as the values 255 for alpha, 0 for radius, and true for startGrow
	createCircle (x, y, 255, 0, true)
end 


--Declare a function called createCircle() with the arguments xPosition, yPosition, alpha, radius, and startGrow
function createCircle(xPosition, yPosition, alpha, radius, startGrow)
	--Create a local table called circle with the keys x, y, a, r, and go which correspond to the parameters of the function it is inside.  (go = startGrow)
	local circle = {
		x = xPosition,
		y = yPosition, 
		a = alpha,
		r = radius,
		go = startGrow
	}

	--Use the lua method table.insert(table, object) to insert the local table circle into the table circles
	table.insert(circles, circle)

	--return the circle
	return circle
end 