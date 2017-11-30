--Have to re-declare bc fml
screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

BG = {}

function BG:new()
  	bg = {
		imgs = { 
			[1] = love.graphics.newImage("img/bgs/1.png"), --Mercury 
			[2] = love.graphics.newImage("img/bgs/2.png"), --Venus 
			[3] = love.graphics.newImage("img/bgs/3.png"), --Earth 
			[4] = love.graphics.newImage("img/bgs/4.png"), --Mars
			[5] = love.graphics.newImage("img/bgs/5.png"), --Jupiter
			[6] = love.graphics.newImage("img/bgs/6.png"), --Saturn
			[7] = love.graphics.newImage("img/bgs/7.png"), --Uranus
			[8] = love.graphics.newImage("img/bgs/8.png"), --Neptune/Pluto


		},
		img = love.graphics.newImage("img/bgs/1.png"),
		n = 1,
		speed = 4, --should incease for difficulty?
		yPos = 0,
		clearOpacity = 0,
	}

	--bg.yPos = bg.img:getHeight()‘«‘«‘‘«“‘«‘““…¬…¬˚¬∆µ¬˚˜∆˙√∆˙©ç¨ƒ∂∆˙©√˚∆˙√∫˚∆˙√¥∆çˆ¥√¬˙∫…˚˜øˆ∫¨¥ƒ¨®†∂¥†®∂†¥BADBADNOTGOOD
	setmetatable(bg, { __index = BG })
  	return BG
end

function BG:update(dt)
	stitch(dt)

	bg.yPos = bg.yPos + bg.speed 
	--bg.speed = bg.speed + 1 * dt  --Accel
end

function BG:draw()
	--love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
	love.graphics.draw(bg.img, 0, bg.yPos, 0, 1, 1, 0, 4434)  --DOUBLE CHECK AT 6:30  --10202 for old way
	love.graphics.setColor(255,255,255, bg.clearOpacity)
	love.graphics.draw(lvl, 10, screenHeight/5)
	love.graphics.setColor(255,255,255)
end

function stitch(dt)
	bg.img = bg.imgs[bg.n]

	if bg.n == 9 then 
		gamestate = "win"
		clearOpacity = 0
	else 
		if (bg.n > 5) then 
			if bg.yPos >= 3122 then 
				bg.yPos = 0 
				bg.n = bg.n + 1
				bg.clearOpacity = 255
			end 
		else 
			if bg.yPos >= 2884 then 
				bg.yPos = 0 
				bg.n = bg.n + 1
				bg.clearOpacity = 255
			end 
		end 
	end 

	bg.clearOpacity = bg.clearOpacity - 5

end 





--[[function DRAW_LOGO()
	love.graphics.setColor(255,255,255,logoAlpha)
	love.graphics.draw(logo)
end 

function UPDATE_LOGO(dt)
	if gamestate =="loading" then 
		if logoAlpha > 0 and logoAlpha <= 255 then 
			gamestate = "loading"
			logoAlpha = logoAlpha-(100*dt)
		else 
			gamestate = "main"
		end 
	end 
end ]]--
