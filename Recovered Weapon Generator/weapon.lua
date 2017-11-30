require("fonts")
require("backstory")
require("splunk")

weapon = {}

weapon.type = {
	[1] = "Pistol",            
	[2] = "Assault Rifle",
	[3] = "Sub Machine Gun",
	[4] = "Sniper Rifle",
	[5] = "Light Machine Gun", 
	[6] = "Rocket Launcher",
	[7] = "Special"
}

weapon.range = {
	[1] = {9, 21},  -- pistol
	[2] = {19, 31}, -- AR
	[3] = {15, 28}, -- SMG
	[4] = {60, 100},-- Sniper
	[5] = {27, 35}, -- LMG
	[6] = {65, 100},-- Launcher
	[7] = {0, 100}  -- Special
}

weapon.accuracy = {
	[1] = {1.9, 2.4}, -- pistol
	[2] = {1.2, 1.7}, -- AR
	[3] = {2.5, 3.5}, -- SMG
	[4] = {0,1},      -- Sniper
	[5] = {2.4, 2.8}, -- LMG
	[6] = {3.8, 4.1}, -- Launcher
	[7] = {0,5}	      --Special
}

weapon.rarity = {
	[1] = {"Common", {255,255,255}, math.random(-4,-2) },  -- White  -3,-2
	[2] = {"Uncommon", {174,255,0}, math.random(-2,0) }, -- green  -2,0
	[3] = {"Unusual", {83,0,197} }, -- Pink 200,0,200  -  
	[4] = {"Different", {30,144,245}, math.random(0,3) }, -- Blue  0,3
	[5] = {"Rare", {238,0,0}, math.random(3,5) },  -- Red --238  3,5
	[6] = {"Spectacular", {255, 102, 0}, math.random(5,7) },  -- Orange 
	[7] = {"Inter Galactic Trans-Dimentional Relic", {100, 100, 100} } -- gray 
}

weapon.manufacturer = {
	[1] = {"Alien", alienFont, alienBS},
	[2] = {"Imperial", imperialFont, imperialBS },
	[3] = {"Rebellion", rebellionFont, rebellionBS },
	[4] = {"One Percent", onePercentFont, onePercentBS },
	[5] = {"Native", nativeFont, nativeBS },
	[6] = {"Arch-Tech", archTechFont, archTechBS },
	[7] = {"THE 7", the7Font, the7BS }
}

weapon.images = {
	--key = "name", "path", offset?-- should scale them down to be the proper size to begin with 
	[1] = {"Revolver", "/img/Gun Sprites/sixShooter.png"},
	[2] = {"Enfield", "/img/Gun Sprites/Enfield.png"},
	[3] = {"Uzi", "/img/Gun Sprites/uzi.png"},
	[4] = {"Barret .50 Cal", "/img/Gun Sprites/sniper.png"},
	[5] = {"Gatling", "/img/Gun Sprites/Minigun.png"},
	[6] = {"Javelin", "/img/Gun Sprites/rocketLauncher.png"},
	[7] = {"Wang", "/img/Gun Sprites/wang.png"}

}
-------------------------------------------------------------------------------
function weapon.Create()
	local sNum = math.random(1,#weapon.type)
	local tNum = math.random(1,#weapon.type-1)
	local vType = nil
	local vMan = nil
	local rRarity = math.random(1,10000) -- 10K
	local vDamage = {
		[1] = nil, --damageRange[rType][1], 
		[2] = nil --damageRange[rType][2]
	}
	local vRarity = nil
	local vAcc = nil

	if tNum == 1 then
		vMan = weapon.manufacturer[1]
		vType = weapon.type[1]
		vDamage[1] = weapon.range[1][1]
		vDamage[2] = weapon.range[1][2]
		vAcc = math.random(weapon.accuracy[1][1], weapon.accuracy[1][2])
	elseif tNum == 2 then
		vMan = weapon.manufacturer[2]
		vType = weapon.type[2]
		vDamage[1] = weapon.range[2][1]
		vDamage[2] = weapon.range[2][2]
		vAcc = math.random(weapon.accuracy[2][1], weapon.accuracy[2][2])
	elseif tNum == 3 then 
		vMan = weapon.manufacturer[3]
		vType = weapon.type[3]
		vDamage[1] = weapon.range[3][1]
		vDamage[2] = weapon.range[3][2]
		vAcc = math.random(weapon.accuracy[3][1], weapon.accuracy[3][2])
	elseif tNum == 4 then 
		vMan = weapon.manufacturer[4]
		vType = weapon.type[4]
		vDamage[1] = weapon.range[4][1]
		vDamage[2] = weapon.range[4][2]
		vAcc = math.random(weapon.accuracy[4][1], weapon.accuracy[4][2])
	elseif tNum == 5 then 
		vMan = weapon.manufacturer[5]
		vType = weapon.type[5]
		vDamage[1] = weapon.range[5][1]
		vDamage[2] = weapon.range[5][2]
		vAcc = math.random(weapon.accuracy[5][1], weapon.accuracy[5][2])
	elseif tNum == 6 then 
		vMan = weapon.manufacturer[6]
		vType = weapon.type[6]
		vDamage[1] = weapon.range[6][1]
		vDamage[2] = weapon.range[6][2]
		vAcc = math.random(weapon.accuracy[6][1], weapon.accuracy[6][2])
	end
-----------------------------------

	if rRarity == 69 then
		vRarity = weapon.rarity[7]
		vMan = weapon.manufacturer[7]
		vType = weapon.type[7]
		vDamage[1] = weapon.range[7][1]
		vDamage[2] = weapon.range[7][2]
		vAcc = math.random(weapon.accuracy[7][1], weapon.accuracy[7][2])
		print("YOU GOT ONE!!!!!!")
		tempVarToStop = "disabled"
		demoGun = "WANGEnabled"

	elseif rRarity <= 3000 then
		vRarity = weapon.rarity[1]
	elseif rRarity <= 6000 then
		vRarity = weapon.rarity[2]

	elseif rRarity <= 8000 then
		vRarity = weapon.rarity[3]

	elseif rRarity <= 9000 then
		vRarity = weapon.rarity[4]

	elseif rRarity <= 9750 then
		vRarity = weapon.rarity[5]

	elseif rRarity <= 10000 then
		vRarity = weapon.rarity[6]
	end
-----------------------------------
	--aDamage == actual Damage
	local aDamage = math.random(vDamage[1], vDamage[2])
 
	local midNum = math.floor((vDamage[2] + vDamage[1])/2)

	if vRarity == weapon.rarity[1] then 
		aDamage = aDamage + weapon.rarity[1][3]

	elseif vRarity == weapon.rarity[2] then 
		aDamage = aDamage + weapon.rarity[2][3]

		--3, NO BUFF/NERF

	elseif vRarity == weapon.rarity[4] then 
		aDamage = aDamage + weapon.rarity[4][3] 

	elseif vRarity == weapon.rarity[5] then 
		aDamage = aDamage + weapon.rarity[5][3] 

	elseif vRarity == weapon.rarity[6] then 
		aDamage = aDamage + weapon.rarity[6][3]  
	end

	--	
	local colorTable = {}

	if aDamage == midNum then
		colorTable = {247, 145, 33}
	elseif aDamage > midNum then
		colorTable = { 238,0,0}
	elseif aDamage < midNum then 
		colorTable = {255,255,0}
	end

	local weapon = {}
		weapon.type = vType
		weapon.range = vDamage
		weapon.damage = aDamage
		weapon.rarity = vRarity
		weapon.manufacturer = vMan
		weapon.color = colorTable
		weapon.accuracy = vAcc


		--Inserts the weapon into the table "logs" 
		splunkInsert(weapon)

	--[[print("Your Weapon Type: "..weapon.type)
	print("Your Weapon Damage: "..weapon.damage)
	print("Your Weapon Range: "..weapon.range[1].." - "..weapon.range[2])
	print("Your Weapon Rarity: "..weapon.rarity[1])
	print("Your Weapon Manufacturer: "..weapon.manufacturer[1])
	print("Your Weapon Accuracy: "..weapon.accuracy)
	print("-------------------------------------")]]--
	return weapon
end


-------------------------
---PRONE TO MALFUNCTION--
---      ლ(ಠ益ಠლ)

function weapon.tag(long, type, range1, range2, damage, rarity, manufacturer, color, x, y)	
	-- for Long
	local typeW = default:getWidth(type)
	local spaceString = " | "
	local spaceW = default:getWidth(spaceString)
	local rangeString = range1.." - "..range2
	local rangeW = default:getWidth(rangeString)
	local damageW = default:getWidth(damage)
	local rarityW = default:getWidth(rarity[1])

	if long then 

		love.graphics.setFont(default)

		local typeText = love.graphics.print(type, x, y)
		
		local space1 = love.graphics.print(spaceString, (x+typeW), y)

		local rangeText = love.graphics.print(rangeString, (x+typeW+spaceW), y)

		local space2 = love.graphics.print(spaceString, (x+typeW+spaceW+rangeW), y)

		love.graphics.setColor(color[1], color[2], color[3])
		local damageText = love.graphics.print(damage, (x+typeW+spaceW+rangeW+spaceW) , y)

		love.graphics.setColor(255,255,255)
		local space3 = love.graphics.print(spaceString, (x+typeW+spaceW+rangeW+spaceW+damageW), y)

		love.graphics.setColor(rarity[2][1], rarity[2][2], rarity[2][3])
		local rarityText = love.graphics.print(rarity[1], (x+typeW+spaceW+rangeW+spaceW+damageW+spaceW), y)

		love.graphics.setColor(255,255,255)
		local space4 = love.graphics.print(spaceString, (x+typeW+spaceW+rangeW+spaceW+damageW+spaceW+rarityW), y)

		love.graphics.setFont(manufacturer[2])

		--repositioning
		if manufacturer[1] == "Rebellion" then  
			--print("moving Reb......")
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+rangeW+spaceW+damageW+spaceW+rarityW+spaceW) , y-7)
		elseif manufacturer[1] == "Imperial" then 
			--print("moving Imp......")
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+rangeW+spaceW+damageW+spaceW+rarityW+spaceW) , y-2)
		elseif manufacturer[1] == "THE 7" then 
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+rangeW+spaceW+damageW+spaceW+rarityW+spaceW) , y-8)
		else
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+rangeW+spaceW+damageW+spaceW+rarityW+spaceW) , y)
		end

	elseif long == false then
		love.graphics.setFont(default)

		local typeText = love.graphics.print(type, x, y)

		local space1 = love.graphics.print(spaceString, (x+typeW), y)

		love.graphics.setColor(color[1], color[2], color[3])
		local damageText = love.graphics.print(damage, (x+typeW+spaceW), y)
		love.graphics.setColor(255,255,255)

		local space2 = love.graphics.print(spaceString, (x+typeW+spaceW+damageW), y)

		love.graphics.setColor(rarity[2][1], rarity[2][2], rarity[2][3])
		love.graphics.setFont(manufacturer[2])
		--repositioning
		if manufacturer[1] == "Rebellion" then  
			--print("moving Reb......")
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+damageW+spaceW) , y-7)
		elseif manufacturer[1] == "Imperial" then 
			--print("moving Imp......")
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+damageW+spaceW) , y-2)
		elseif manufacturer[1] == "THE 7" then 
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+damageW+spaceW) , y-8)
		else
			local manufacturerText = love.graphics.print(manufacturer[1], (x+typeW+spaceW+damageW+spaceW) , y)
		end

		love.graphics.setColor(255,255,255)
	end
end 

---------------------
function drawWeaponSim()
	love.graphics.print("Weapon Simulator", 225 - default:getWidth("Weapon Simulator")/4, 265)
	love.graphics.rectangle("line", 0, 290,550,215)
	textForWeapon = weapon.tag(true, weapon1.type, weapon1.range[1], weapon1.range[2], weapon1.damage, weapon1.rarity,  weapon1.manufacturer, weapon1.color, 10,300)
	textForWeaponShort = weapon.tag(false, weapon2.type, weapon2.range[1], weapon2.range[2], weapon2.damage, weapon2.rarity,  weapon2.manufacturer, weapon2.color, 10,325)

	textForWeapon3 = weapon.tag(true, weapon3.type, weapon3.range[1], weapon3.range[2], weapon3.damage, weapon3.rarity,  weapon3.manufacturer, weapon3.color, 10,350)
	textForWeaponShort4 = weapon.tag(false, weapon4.type, weapon4.range[1], weapon4.range[2], weapon4.damage, weapon4.rarity,  weapon4.manufacturer, weapon4.color, 10,375)

	textForWeapon5 = weapon.tag(true, weapon5.type, weapon5.range[1], weapon5.range[2], weapon5.damage, weapon5.rarity,  weapon5.manufacturer, weapon5.color, 10,400)
	textForWeaponShort6 = weapon.tag(false, weapon6.type, weapon6.range[1], weapon6.range[2], weapon6.damage, weapon6.rarity,  weapon6.manufacturer, weapon6.color, 10,425)
	
	textForWeapon7 = weapon.tag(true, weapon7.type, weapon7.range[1], weapon7.range[2], weapon7.damage, weapon7.rarity,  weapon7.manufacturer, weapon7.color, 10,450)
	textForWeaponShort8 = weapon.tag(false, weapon8.type, weapon8.range[1], weapon8.range[2], weapon8.damage, weapon8.rarity,  weapon8.manufacturer, weapon8.color, 10,475)
end 

function UPDATE_WEAPON(dt)

end 

function DRAW_WEAPON()
	drawWeaponSim() --༼ つ ಥ_ಥ ༽つ
end 