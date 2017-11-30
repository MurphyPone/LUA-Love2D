--load in various cursor images 
cursors = {}
	cursors.pointer1 = love.graphics.newImage("img/crosshairs/cursor.png")
	cursors.pointer1Down = love.graphics.newImage("img/crosshairs/cursorDown.png")

	cursors.pointer2 = love.graphics.newImage("img/crosshairs/cursor2.png")
	cursors.pointer2Down = love.graphics.newImage("img/crosshairs/cursorDown2.png")

currentCursor = cursors.pointer2

crosshair = love.graphics.newImage("img/crosshairs/default.png")
love.mouse.setVisible(false)
--love.mouse.setGrabbed(menuCursor) -- disables mouse leaving screen


function DRAW_CURSOR()
	love.graphics.draw(currentCursor, love.mouse.getX(), love.mouse.getY() )
end 

function UPDATE_CURSOR()
	if love.mouse.isDown("l") then 
 		currentCursor = cursors.pointer2Down
 	else 
 		currentCursor = cursors.pointer2
 	end
end 

