require("fonts")
require("backstory")

armor = {}
			--category, {examples of items in that category}
armor.type = {
	[1] = { "Boots", {"Sandal", "Slipper", "Normal", "Booty", "Krok"} },
	[2] = { "Leggings", {"Pajama", "", "Chain Mail", "", ""}  },
	[3] = { "Chest Plate", {"Battered", "Kevlar", "Chainmail", "", ""}  },
	[3] = { "Helmet", { "Ball Cap", "Sombrero", "Standard Issue", "Mask", ""} },  
	[4] = { "Guantlets", { "Mechanical", "Leather", "Fuzzy Mitten", "Oven Mit", ""} },
	[5] = { "Back Slot", nil },
	[6] = { "Gadget", nil },
	[7] = { "Accessory", nil }  
}

armor.protection = {
	-- [key] = {"type", health, speed}
	[1] = {"Speed", 0, 20},
	[2] = {"Light", 10, 10 },
	[3] = {"Medium", 20, 0 },
	[4] = {"Heavy", 30, -10},
	[5] = {"Turret", 50, nil} --Nil bc you shouldn't be able to move
}

--Why negwtive? WHo knows 
armor.rarity = {
	[1] = {"Common", {255,255,255}, math.random(-4,-2) },  -- White  -3,-2
	[2] = {"Uncommon", {174,255,0}, math.random(-2,0) }, -- green  -2,0
	[3] = {"Unusual", {83,0,197} }, -- Pink 200,0,200  -  
	[4] = {"Different", {30,144,245}, math.random(0,3) }, -- Blue  0,3
	[5] = {"Rare", {238,0,0}, math.random(3,5) },  -- Red --238  3,5
	[6] = {"Spectacular", {255, 102, 0}, math.random(5,7) },  -- Orange 
	[7] = {"Inter Galactic Trans-Dimentional Relic", {100, 100, 100} } -- gray 
}

armor.manufacturer = {
	[1] = {"Alien", alienFont, alienBS},
	[2] = {"Imperial", imperialFont, imperialBS },
	[3] = {"Rebellion", rebellionFont, rebellionBS },
	[4] = {"One Percent", onePercentFont, onePercentBS },
	[5] = {"Native", nativeFont, nativeBS },
	[6] = {"Arch-Tech", archTechFont, archTechBS },
	[7] = {"THE 7", the7Font, the7BS }
}

function armor.Create()
	--(rand(1,#armor.type)) = rnd # between 1&2 so it ony generates boots/leggins --the 1/2 values of armor.type snd alien/imperial the 1/2 values of man
	local tNum = math.random(1,#armor.type-1)
	local vType = nil
	local vMan = nil
	local vProt = nil 
	local rProt = math.random(1,4)
	local rRarity = math.random(1,10000)
	local vRarity = nil
	--Implement color like in weapon bbut find mid range of protection values?


	if tNum == 1 then
		vMan = armor.manufacturer[1]
		vType = armor.type[1]
	elseif tNum == 2 then
		vMan = armor.manufacturer[2]
		vType = armor.type[2]
	elseif tNum == 3 then 
		vMan = armor.manufacturer[3]
		vType = armor.type[3]
	elseif tNum == 4 then 
		vMan = armor.manufacturer[4]
		vType = armor.type[4]
	elseif tNum == 5 then 
		vMan = armor.manufacturer[5]
		vType = armor.type[5]
	elseif tNum == 6 then 
		vMan = armor.manufacturer[6]
		vType = armor.type[6]
	end
-----------------------------------
	if rProt == 1 then 
		vProt = armor.protection[1]
	elseif rProt == 2 then 
		vProt = armor.protection[2]
	elseif rProt == 3 then 
		vProt = armor.protection[3]
	elseif rProt == 4 then 
		vProt = armor.protection[4]		
	end 
-----------------------------------

	if rRarity == 69 then
		vRarity = armor.rarity[7]
		vMan = armor.manufacturer[7]
		vType = armor.type[7]
		print("YOU GOT ONE!!!!!!")
		tempVarToStop = "disabled"

	elseif rRarity <= 3000 then
		vRarity = armor.rarity[1]
	elseif rRarity <= 6000 then
		vRarity = armor.rarity[2]

	elseif rRarity <= 8000 then
		vRarity = armor.rarity[3]

	elseif rRarity <= 9000 then
		vRarity = armor.rarity[4]

	elseif rRarity <= 9750 then
		vRarity = armor.rarity[5]

	elseif rRarity <= 10000 then
		vRarity = armor.rarity[6]
	end

	local armor = {}
		armor.type = vType
		armor.rarity = vRarity
		armor.manufacturer = vMan
		armor.protection = vProt
		

		--Interprets the whole table 
		--print_r(armor)

	return armor 
end 


------------------------------------------------------------------------------------------
function armor.Tag(long, type, protection, rarity, manufacturer, color, x, y)	
	-- for Long
	local typeW = default:getWidth(type[1])
	local spaceString = " | "
	local spaceW = default:getWidth(spaceString)
	local protectionW = default:getWidth(protection[1])
	local rarityW = default:getWidth(rarity[1])

	if long then 

		love.graphics.setFont(default)

		local typeText = love.graphics.print(type[1], x, y)
		
		local space1 = love.graphics.print(spaceString, (x+typeW), y)

		local protectionText = love.graphics.print(protection[1], (x+typeW+spaceW), y)

		love.graphics.setColor(255,255,255)
		local space2 = love.graphics.print(spaceString, (x+typeW+spaceW+protectionW), y)

		love.graphics.setColor(rarity[2][1], rarity[2][2], rarity[2][3])
		local rarityText = love.graphics.print(rarity[1], (x+typeW+spaceW+protectionW+spaceW), y)

		love.graphics.setColor(255,255,255)
		local space3 = love.graphics.print(spaceString, (x+typeW+spaceW+protectionW+spaceW+rarityW), y)

		love.graphics.setFont(manufacturer[2])

		--repositioning
		if manufacturer[1] == "Rebellion" then  
			--print("moving Reb......")
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+protectionW+spaceW+rarityW+spaceW) , y-7)
		elseif manufacturer[1] == "Imperial" then 
			--print("moving Imp......")
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+protectionW+spaceW+rarityW+spaceW) , y-2)
		elseif manufacturer[1] == "THE 7" then 
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+protectionW+spaceW+rarityW)+spaceW , y-8)
		else
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+protectionW+spaceW+rarityW+spaceW) , y)
		end

	elseif long == false then
		love.graphics.setFont(default)

		local typeText = love.graphics.print(type[1], x, y)

		local space1 = love.graphics.print(spaceString, (x+typeW), y)

		--love.graphics.setColor(color[1], color[2], color[3])
		local protectionText = love.graphics.print(protection[1], (x+typeW+spaceW), y)
		love.graphics.setColor(255,255,255)

		local space2 = love.graphics.print(spaceString, (x+typeW+spaceW+protectionW), y)

		love.graphics.setColor(rarity[2][1], rarity[2][2], rarity[2][3])
		love.graphics.setFont(manufacturer[2])
		

		--repositioning
		if manufacturer[1] == "Rebellion" then  
			--print("moving Reb......")
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+protectionW+spaceW) , y-7)
		elseif manufacturer[1] == "Imperial" then 
			--print("moving Imp......")
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+protectionW+spaceW) , y-2)
		elseif manufacturer[1] == "THE 7" then 
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+protectionW+spaceW) , y-8)
		else
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+protectionW+spaceW) , y)
		end

		love.graphics.setColor(255,255,255)
	end
end


function drawArmorSim()
	love.graphics.print("Armor Sim", 550-default:getWidth("Armor Sim")-default:getWidth("Armor Sim")/6, 505)
	love.graphics.rectangle("line", 0, 505, 550, love.window.getHeight()-505)

	textForArmor1 = armor.Tag(true, armor1.type, armor1.protection, armor1.rarity, armor1.manufacturer, armor1.color, 10,510)
	textForArmor2Short = armor.Tag(false, armor2.type, armor2.protection, armor2.rarity, armor2.manufacturer, armor2.color, 10,510+default:getHeight(type))
	textForArmor3 = armor.Tag(true, armor3.type, armor3.protection, armor3.rarity, armor3.manufacturer, armor3.color, 10,510+default:getHeight(type)*2)
	textForArmor4Short = armor.Tag(false, armor4.type, armor4.protection, armor4.rarity, armor4.manufacturer, armor4.color, 10,510+default:getHeight(type)*3)
	textForArmor5 = armor.Tag(true, armor5.type, armor5.protection, armor5.rarity, armor5.manufacturer, armor5.color, 10,510+default:getHeight(type)*4)
	textForArmor6Short = armor.Tag(false, armor6.type, armor6.protection, armor6.rarity, armor6.manufacturer, armor6.color, 10,510+default:getHeight(type)*5)
	textForArmor7 = armor.Tag(true, armor7.type, armor7.protection, armor7.rarity, armor7.manufacturer, armor7.color, 10,510+default:getHeight(type)*6)
	textForArmor8Short = armor.Tag(false, armor8.type, armor8.protection, armor8.rarity, armor8.manufacturer, armor8.color, 10,510+default:getHeight(type)*7)
	textForArmor9 = armor.Tag(true, armor9.type, armor9.protection, armor9.rarity, armor9.manufacturer, armor9.color, 10,510+default:getHeight(type)*8)
	textForArmor10Short = armor.Tag(false, armor10.type, armor10.protection, armor10.rarity, armor10.manufacturer, armor10.color, 10,510+default:getHeight(type)*9)
	

end 

function UPDATE_ARMOR(dt)

end 

function DRAW_ARMOR()
	drawArmorSim()
end 