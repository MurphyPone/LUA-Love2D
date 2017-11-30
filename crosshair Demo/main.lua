
function love.load()
	--Hides Cursor
	love.mouse.setVisible(false)

	hand = love.graphics.newImage("hand.png")
	
	width = love.window.getWidth()
	height = love.window.getHeight()

	mouseX = love.mouse.getX()
	mouseY = love.mouse.getY()

	love.graphics.setBackgroundColor(35, 35, 35)


end

function love.update(dt)
	--Some math for the angles
	startX = width/2
	startY = height/2
	mouseX = love.mouse.getX()
	mouseY = love.mouse.getY()

	angle = math.atan2((mouseY - startY), (mouseX - startX))

	spread = 20

	distance = math.dist(width/2, height/2, mouseX, mouseY)

end
	
function love.draw()

	love.graphics.setColor(255, 255, 255)
	love.graphics.print(tostring(love.timer.getFPS( )), 1150, 10)


	
	--hand
	love.graphics.draw(hand, width/2, height/2, angle, 1, 1, 8,8)

	love.graphics.setColor(200, 200, 200)
	--center dot
	love.graphics.rectangle("fill", mouseX, mouseY, 3, 3)
	--right
	love.graphics.rectangle("fill", mouseX+3+(5*(distance/spread)), mouseY, 15, 3)
	--left
	love.graphics.rectangle("fill", mouseX-(5*(distance/spread)), mouseY, -15, 3)

	--top
	love.graphics.rectangle("fill", mouseX, mouseY+3+(5*(distance/spread)), 3, 15)
	--bottom
	love.graphics.rectangle("fill", mouseX, mouseY-(5*(distance/spread)), 3, -15)

end

function love.focus(bool)
end

function love.keypressed(key, unicode)
	print(key)

	--returns to main if not on main
	
end

function love.quit()
	love.event.quit()
end


-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) 
	return ((x2-x1)^2+(y2-y1)^2)^0.5 
end