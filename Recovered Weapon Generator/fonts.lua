alienFont = love.graphics.newFont("fonts/Waning Moon 2.ttf", 30)
imperialFont = love.graphics.newFont("fonts/BEBAS___.TTF", 20)
rebellionFont = love.graphics.newFont("fonts/BankGothic Bold.ttf", 28)
onePercentFont = love.graphics.newFont("fonts/CODE Bold.otf", 20)
nativeFont = love.graphics.newFont("fonts/kremlin.ttf", 20)
archTechFont = love.graphics.newFont("fonts/ROBO.ttf", 24)
the7Font = love.graphics.newFont("fonts/vermin_vibes_redux.ttf", 48)
default = love.graphics.newFont("fonts/BEBAS___.TTF", 18)


fonts = {
	[1] = alienFont,
	[2] = imperialFont, 
	[3] = rebellionFont,  
	[4] = onePercentFont,  
	[5] = nativeFont ,
	[6] = archTechFont, 
	[7] = the7Font, 
}

function drawManInfo(man, font, info)
	love.graphics.setColor(255,255,255)

	if man == "THE 7" then 
		love.graphics.setColor(100, 100, 100) 
		love.graphics.setFont(font)

		love.graphics.print(man.." ", 10, 10-6)
		love.graphics.setColor(255,255,255)

		love.graphics.setFont(default)
		love.graphics.print("Are...", 10+font:getWidth(man), 10)

	elseif man == "Rebellion" then 
		love.graphics.setFont(default)
		love.graphics.print("The ", 10, 10)

		love.graphics.setFont(font)
		love.graphics.print(man.." ", 10+default:getWidth("The "), 10-6)

		love.graphics.setFont(default)
		love.graphics.print("Are...", 10+default:getWidth("The ")+font:getWidth(man), 10)

	else
		love.graphics.setFont(default)
		love.graphics.print("The ", 10, 10)
		love.graphics.setFont(font)

		love.graphics.print(man.." ", 10+default:getWidth("The "), 10)

		love.graphics.setFont(default)
		love.graphics.print("Are...", 10+default:getWidth("The ")+font:getWidth(man), 10)

	end 
	love.graphics.setFont(default)
	love.graphics.print(info, 10, 50)
end 

function drawRarityInfo(rarity, color)
	love.graphics.setFont(default)
	love.graphics.setColor(color[1], color[2], color[3])
	love.graphics.print(rarity, 10, 10)
	love.graphics.setColor(255,255,255)

	love.graphics.print("Chances of getting  "..rarity.."  are".."<insert Values>", 10, 50)
end 