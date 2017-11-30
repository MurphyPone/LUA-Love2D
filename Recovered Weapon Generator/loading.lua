logo = love.graphics.newImage("img/logo splash.png")
logoAlpha = 255

function DRAW_LOGO()
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
end 