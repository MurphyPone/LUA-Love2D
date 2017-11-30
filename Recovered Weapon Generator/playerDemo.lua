require("fonts")
require("lib/AnAL")

function LOAD_PLAYERDEMO()
	player = {}
		player.img = love.graphics.newImage("img/PlayerDemo/body.png")
		player.x = 550
		--The line below works
		--player.y = 505-player.img:getHeight()/2
		player.y = 325-player.img:getHeight()/2
		player.w = player.img:getWidth()
		player.h = player.img:getHeight()
		player.speed = 200
		player.facing = "right"

		player.arm = {}
			player.arm.img = love.graphics.newImage("img/PlayerDemo/arm.png")
			player.arm.x = player.x+5.5
			player.arm.y = player.y+34

		player.gun = {}
			player.gun.img = love.graphics.newImage("img/Gun Sprites/sixShooter.PNG")
			player.gun.x = player.arm.x+55
			player.gun.y = player.arm.y+22
		
		player.wang = {}
			player.wang.img = love.graphics.newImage("img/PlayerDemo/Minigun.png")
			player.wang.x = player.arm.x+55
			player.wang.y = player.arm.y+22

		----------------------------------------------------------------------------------------------------
		---TEMP ANIMATION STUFF
		img  = love.graphics.newImage("img/PlayerDemo/minigunSprite.png")
		imgWang = love.graphics.newImage("img/PlayerDemo/wangSprite.png")
 
   		-- Create animation.  (image, frameX, frameY, interval, 0=tsking care of #imgs&size)

   		anim = newAnimation(img, 1755, 837, 0.1, 0)
   		wangAnim = newAnimation(imgWang, 168, 91, 0.1, 0)
   		wangAnim:setMode("bounce")
		----------------------------------------------------------------------------------------------------
end 

function UPDATE_PLAYERDEMO(dt)

	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then 
		player.x = player.x - player.speed *dt
		player.facing = "left"
	end 

	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then 
		player.x = player.x + player.speed *dt
		player.facing = "right"

	end 
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then 
		player.y = player.y - player.speed *dt
		player.facing = "up"
	end 
	if love.keyboard.isDown("s") or love.keyboard.isDown("down") then 
		player.y = player.y + player.speed *dt
		player.facing = "down"
	end 
	
	--prevents dynamic bg from working
	--[[if player.x > love.graphics.getWidth() - player.w/2 then 

		player.x = love.graphics.getWidth() - player.w/2
	end ]]--
	

	if player.y > 505-player.img:getHeight()/2 then 
		player.y = 505-player.img:getHeight()/2
	end  
	
	if player.x < 550 then 
		player.x = 550
	end

	if player.y < 0 then 
		player.y = 0
	end  

	----------------------------------------
	--FIX THIS SHIT IT'S ALL OVER THE PLACE--
	----------------------------------------
	mouseX = love.mouse.getX()
	mouseY = love.mouse.getY()


	--updates locations
	player.arm.x = player.x+5.5
	player.arm.y = player.y+34


	player.gun.x = player.arm.x+55
	player.gun.y = player.arm.y+22
	-----------------------

	---45 to properly orient the arm
	angle = math.atan2((mouseY - player.y), (mouseX - player.x))


	----------------------------------------------------------------------------------------------------
	---TEMP ANIMATION STUFF?]
	anim:update(dt) 
	wangAnim:update(dt)
	
end 

function DRAW_PLAYERDEMO()
	--FIX HIS ARM
	love.graphics.draw(player.img, player.x,player.y, 0, .5, 0.5)
	--11 = offset --or the distsance between top left, and where we want the origin to be = the shoulder 
	--[[IDEALLY THE HAND WOULD COVER THE HANDLE OF THE GUN
	love.graphics.draw(player.arm.img, player.arm.x,player.arm.y, angle, .5,.5,12,23)]]--
	--Gun on his arm, #s only work for gattling 
	--love.graphics.draw(player.gun.img, player.arm.x+math.cos(angle)*12, player.arm.y-math.sin(angle)/12, angle, .055, .055, -30, 200)


	love.graphics.setFont(default)
	love.graphics.print("Player Demo", love.window.getWidth() - default:getWidth("Player Demo")*4, default:getHeight("Player Demo")/4)
	love.graphics.rectangle("line", 550, 0, love.window.getWidth()-550,505)

	----------------------------------------------------------------------------------------------------
	---TEMP ANIMATION STUFF?]
	--anim:draw(player.arm.x+math.cos(angle)*12, player.arm.y-math.sin(angle)/12) 
	if demoGun == "gatling" then 	
		--if mouse pressed then spin animate
		if animGo then  
			anim:draw(player.arm.x+math.cos(angle)*12, player.arm.y-math.sin(angle)/12, angle, .07, .07, -30, 200) 
		elseif animGo == false then 
			love.graphics.draw(player.gun.img, player.arm.x+math.cos(angle)*12, player.arm.y-math.sin(angle)/12, angle, .07, .07, -30, 200)
		end 
	elseif demoGun == "WANG" then 
		if animGo then 
			--repositioning  puts it on the hand and rotates w/mouse for x,y, angle, scale to 40%, offset by .....  
			wangAnim:draw( (player.arm.x+math.cos(angle)*12), (player.arm.y-math.sin(angle)/12), angle, .4, .4, -20, 85) 

		elseif animGo == false then 
			love.graphics.draw(player.gun.img, player.arm.x+math.cos(angle)*12, player.arm.y-math.sin(angle)/12, angle, .07, .07, -30, 200)
		end 
	end 

	--SAME CODE AS A BOVE, moved for layering effect
	love.graphics.draw(player.arm.img, player.arm.x,player.arm.y, angle, .5,.5,12,23)
	
end 

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
--Not in its ownfile bc part of player demo


function LOAD_BACKGROUND()
	bg1 = love.graphics.newImage("img/bgs/map1.png")

	bg1Lines = {
		--hardcoded acc to bg1 img file
		[1] = love.graphics.rectangle("line", 550, 315, 214, 330)
	}
	bg2 = love.graphics.newImage("img/bgs/map2.png")
	bg3 = love.graphics.newImage("img/bgs/map3.png")
	bgX = 550
	bgY = 0
end 

function DRAW_BACKGROUND()
	if frameCount == 0 then 
		love.graphics.draw(bg1, bgX, bgY)
		--draws lines for impromptu physics engine that will eventually be removed 
		--[[for i = 1, #bg1Lines do 
			love.graphics.draw(bg1Lines[i])
		end ]]--

	elseif frameCount == 1 then 
		love.graphics.draw(bg2, bgX, bgY)
	elseif frameCount == 2 then 
		love.graphics.draw(bg3, bgX, bgY)
	end 
end 

function UPDATE_BACKGROUND(dt)
	if player.x > love.graphics.getWidth() then 
		frameCount = frameCount + 1
		player.x = 550

		player.y = 325-player.img:getHeight()
	end 

	--resets 
	if frameCount >= 2 then 
		frameCount = 0
	end 

end 