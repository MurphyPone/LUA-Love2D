function love.load()
	--Variables for Direction code--
	beginX =0
	beginY =0
	endX =0
	endY =0
	 
	xDistance = 0  
	yDistance = 0
	 
	bDoingTouch=false
	minSwipeDistance = 50
	totalSwipeDistanceLeft=0
	totalSwipeDistanceRight=0
	totalSwipeDistanceUp=0
	totalSwipeDistanceDown=0
	--------------------------------

	player = {
		x = love.graphics.getWidth()/2,
		y = love.graphics.getHeight()/2,
		s = 40,
		speed = 300,
		facing = "right"
		}
end 


function love.mousepressed(x, y, button, istouch)
	bDoingTouch = true
    beginX = x
	beginY = y
end 

function love.mousereleased(x, y, button, istouch)
	endX = x
    endY = y
    checkSwipeDirection();
    bDoingTouch = false
end 

function love.draw()
	love.graphics.print("xDistance:"..tostring(xDistance), 10, 10)
	love.graphics.print("yDistance:"..tostring(yDistance), 10, 20)
	--love.graphics.print(checkSwipeDirection())

	love.graphics.rectangle("fill", player.x, player.y, player.s, player.s)
end 

function love.update(dt)
	player.facing = checkSwipeDirection()

	if player.facing == "right" then 
		player.x = player.x +player.speed*dt
	elseif player.facing == "left" then 
		player.x = player.x - player.speed*dt
	elseif player.facing == "up" then 
		player.y = player.y - player.speed*dt
	elseif player.facing == "down" then 
		player.y = player.y + player.speed*dt
	end
end 

function checkSwipeDirection()
	--resting value of right
	local lastDir 
	local newDir = "right"

	if bDoingTouch == true then
	    xDistance =  math.abs(endX - beginX) -- math.abs will return the absolute, or non-negative value, of a given value. 
	    yDistance =  math.abs(endY - beginY)

	    if xDistance > yDistance then
	        if beginX > endX then
	        	totalSwipeDistanceLeft = beginX - endX

	            if totalSwipeDistanceLeft > minSwipeDistance then
	                --print("Swiped Left")
	                lastDir = "left"
	                newDir = "left"
	                return newDir
	            end
	    	else 
	        	totalSwipeDistanceRight = endX - beginX

	            if totalSwipeDistanceRight > minSwipeDistance then
	                --print("Swiped Right")
	                lastDir = "right"
	                newDir = "right"
	                return newDir
	            end
	    	end
	    else 
			if beginY > endY then
	    		totalSwipeDistanceUp = beginY - endY

		    	if totalSwipeDistanceUp > minSwipeDistance then
		        	--print("Swiped Up")
		        	lastDir = "up"
		        	newDir = "up"
		        	return newDir
		        end
	    	else 
	    		totalSwipeDistanceDown = endY - beginY

		    	if totalSwipeDistanceDown > minSwipeDistance then
		           --print("Swiped Down")
		           lastDir = "down"
		            newDir = "down"
		            return newDir
		    	end
    		end
		end
	else 
		return lastDir
    end

    --return newDir
end





