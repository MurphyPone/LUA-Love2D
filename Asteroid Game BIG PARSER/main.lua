require("ship")
require("fire")
require("background")
require("score")
require("sodapop") --Animation library not created by our team
require("bullets")
require("enemies")
require("shop")
require("Class")
require("GUIElements/GUIMain")


function love.load() 
	player = Ship:new()
	fire = Fire:new()
	myScore = Score:new()
	background = BG:new()
	bullets_load()
	shop_load()

	--Spawn lots of eneemies 
	for i = 1,12 do 
		enemies[i] = Enemy:new()
		enemies[i].x = math.random(0,screenWidth)
	end 

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()

	--Small assets
	go = love.graphics.newImage("img/game over.png")
	win = love.graphics.newImage("img/you win .png")
	lvl = love.graphics.newImage("img/level cleared.png")
	title = love.graphics.newImage("img/Title.png")
	

	button = {
		img = love.graphics.newImage("img/play.png"),
		x = screenWidth/2 -300,
		y = screenHeight/2,
		width = 573,
		height = 68
	}

	shop = {
		img = love.graphics.newImage("img/shop.png"),
		x = screenWidth/2 - (258/2),
		y = screenHeight - 74*2,
		width = 258,
		height = 74
	}

	gamestate = "title"
end 

function love.update(dt)
	if gamestate == "playing" then 
		player:update(dt)
		fire:update(dt)
		background:update(dt)
		myScore:update(dt)
		bullets_update(dt)

		for i = 1,#enemies do 
			enemies[i]:update(dt)
		end 
	elseif gamestate == "shop" then 
		shop_update(dt)
	end 
end

function love.draw()
	if gamestate == "playing" then 
		love.graphics.setBackgroundColor(200,200,200)
		background:draw()
		fire:draw()
		player:draw()
		bullets_draw(dt)
		myScore:draw()


		for i = 1,#enemies do 
			enemies[i]:draw()
		end
	elseif gamestate == "deathscreen" then 
		background:draw()
		myScore:draw()
		love.graphics.draw(button.img, button.x, button.y)
		if insideBox(love.mouse.getX(), love.mouse.getY(), button.x, button.y, button.width, button.height ) then
			gamestate = "playing"
			for i = 1,#enemies do 
				enemies[i]:reset()
				myScore.score = 0
			end
		end

		love.graphics.draw(go, 10, screenHeight/5)
	elseif gamestate == "win" then 
		love.graphics.setBackgroundColor(100,255,100)
		love.graphics.draw(win, 10, screenHeight/5)
		myScore:draw()

		love.graphics.draw(button.img, button.x, button.y)
		if insideBox(love.mouse.getX(), love.mouse.getY(), button.x, button.y, button.width, button.height ) then
			gamestate = "playing"
			for i = 1,#enemies do 
				enemies[i]:reset()
				myScore.score = 0
			end
		end
	elseif gamestate == "title" then
		love.graphics.draw(title)
		love.graphics.draw(button.img, button.x, button.y)
		love.graphics.setBackgroundColor(200,200,200)
		if insideBox(love.mouse.getX(), love.mouse.getY(), button.x, button.y, button.width, button.height ) then
			gamestate = "playing"
		end 

		love.graphics.draw(shop.img, shop.x, shop.y)
		if insideBox(love.mouse.getX(), love.mouse.getY(), shop.x, shop.y, shop.width, shop.height ) then
			gamestate = "shop"
		end 


	elseif gamestate == "shop" then 
		shop_draw()		

	end 
end 

function love.mousepressed(x, y, button, istouch)
	if x > screenWidth/2 then 
		player.rotation = player.rotation + 2 * .016
	else 
		player.rotation = player.rotation - 2 * .016
	end 
end 

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function insideBox( px, py, x, y, wx, wy )
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end