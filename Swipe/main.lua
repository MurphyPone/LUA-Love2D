function love.load()
	beginX =0
	beginY =0
	endX =0
	endY =0
	 
	xDistance = 0  
	yDistance = 0
	 
	bDoingTouch=0
	minSwipeDistance = 50
	totalSwipeDistanceLeft=0
	totalSwipeDistanceRight=0
	totalSwipeDistanceUp=0
	totalSwipeDistanceDown=0
end 


 
function checkSwipeDirection()
	local direction = ""

	if bDoingTouch == true then
	    xDistance =  math.abs(endX - beginX) -- math.abs will return the absolute, or non-negative value, of a given value. 
	    yDistance =  math.abs(endY - beginY)

	    if xDistance > yDistance then
	        if beginX > endX then
	        	totalSwipeDistanceLeft = beginX - endX

	            if totalSwipeDistanceLeft > minSwipeDistance then
	                print("Swiped Left")
	                direction = "left"
	            end
	    	else 
	        	totalSwipeDistanceRight = endX - beginX

	            if totalSwipeDistanceRight > minSwipeDistance then
	                print("Swiped Right")
	                direction = "right"
	            end
	    	end
	    else 
			if beginY > endY then
	    		totalSwipeDistanceUp = beginY - endY

		    	if totalSwipeDistanceUp > minSwipeDistance then
		        	print("Swiped Up")
		        	direction = "up"
		        end
	    	else 
	    		totalSwipeDistanceDown = endY - beginY

		    	if totalSwipeDistanceDown > minSwipeDistance then
		            print("Swiped Down")
		            direction = "down"
		    	end
    		end
		end
    end

    return direction
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
	love.graphics.print(checkSwipeDirection())
end 


