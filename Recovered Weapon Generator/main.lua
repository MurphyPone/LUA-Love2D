require("weapon")
require("armor")
require("fonts")
require("backstory")
require("cursor")
require("loading")
require("playerDemo")
require("splunk")
local AnAL = require("lib/AnAL")
local inspect = require("lib/inspect")

function love.load()
	math.randomseed(os.time())


	-----Loads stuff from other files
	LOAD_PLAYERDEMO()
	LOAD_BACKGROUND()
	LOAD_SPLUNK()

	--Stuff for animation
	--gatling,, WANGEnabled, WANG
	demoGun = "gatling"
	animGo = false

	--Gamestates include "loading" "main" "saving" + lol whatever the mess with manufacturers is where it concatinates and adds "info"
	gamestate = "main"
	--pauses ability to gen. weapons when your role a super rare
	tempVarToStop = "enabled"
	--Frame count for which part of the map is being shown
	frameCount = 0
	counter = 0
	
	love.graphics.setBackgroundColor(10,10,10)

	
	---CREATES WEAPONS FOR STARTUP
	weapon1 = weapon.Create()
	weapon2 = weapon.Create()
	weapon3 = weapon.Create()
	weapon4 = weapon.Create()           
	weapon5 = weapon.Create()
	weapon6 = weapon.Create()
	weapon7 = weapon.Create()
	weapon8 = weapon.Create()

	armor1 = armor.Create()
	armor2 = armor.Create()
	armor3 = armor.Create()
	armor4 = armor.Create()
	armor5 = armor.Create()
	armor6 = armor.Create()
	armor7 = armor.Create()
	armor8 = armor.Create()
	armor9 = armor.Create()
	armor10 = armor.Create()
	
	love.graphics.setColor(255,255,255) 

	
end
	
function love.draw()
	--DRAW_LOGO()

	-------
	--FPS--
	-------
	love.graphics.setFont(default)
	love.graphics.setColor(255,255,0) 
	love.graphics.print(tostring(love.timer.getFPS( )), love.window.getWidth()-default:getWidth(tostring(love.timer.getFPS( ))), 0 ) 
	
	--
	love.graphics.setColor(255,255,255,255) 

	if gamestate == "main" then 
		--Draws dynamic bg
		DRAW_BACKGROUND()
		-- Draws weapons
		DRAW_WEAPON()
		--Draws Player Demo
		DRAW_PLAYERDEMO()
		--Draws armor sim
		DRAW_ARMOR()
	
		--draws companies -- MOVE INTO DRAW_MAN or something
		for i = 1,#fonts do 
			love.graphics.setFont(fonts[i])
			love.graphics.print(weapon.manufacturer[i][1], 10,30*i)
		end 

		--draws rarities MOVE INTO RARITY or something
		for i = 1,#weapon.rarity do 
			love.graphics.setFont(default)
			love.graphics.setColor(weapon.rarity[i][2][1], weapon.rarity[i][2][2], weapon.rarity[i][2][3])
			love.graphics.print(weapon.rarity[i][1], rebellionFont:getWidth("Arch-Tech") + 20,30*i)
			love.graphics.setColor(255,255,255)
		end
	end 

	-- IF INFO
	for i = 1,#weapon.manufacturer do 
		if gamestate == weapon.manufacturer[i][1].."Info" then
			drawManInfo(weapon.manufacturer[i][1], weapon.manufacturer[i][2], weapon.manufacturer[i][3] )
		end
	end  

	for i = 1,#weapon.rarity do 
		if gamestate == weapon.rarity[i][1].."Info" then
			drawRarityInfo(weapon.rarity[i][1], weapon.rarity[i][2])
		end
	end 

	--cursor is outside the "gamestate" if statement bc it should always be on
	DRAW_CURSOR()
end

function love.update(dt)
	UPDATE_CURSOR()
	--UPDATE_LOGO(dt)
	UPDATE_PLAYERDEMO(dt)
	UPDATE_BACKGROUND()
end

function love.focus(bool)
end

function love.keypressed(key, unicode)
	print(key)
	--returns to main if not on main
	if key == "escape" then 
		gamestate = "main"
	end 

	--
	if key == "r" then 
		tempVarToStop = "enabled"
	end 

	-- enables/disables wang gun
	if gamestate == "main" then 
		if demoGun == "WANGEnabled" and key == "p" then 
			demoGun = "WANG"
		elseif demoGun == "WANG" and key == "p" then 
			demoGun = "gatling"
		end 
	end 
end

function love.mousepressed(x, y, button)
	-- Checks for clicks on the manufacturers--
	if gamestate == "main" then 
		if button == "l" then 
			for i = 1,#weapon.manufacturer do 
				if insideBox(x,y, 10, 30*i, weapon.manufacturer[i][2]:getWidth(weapon.manufacturer[i][1]) ,weapon.manufacturer[i][2]:getHeight(weapon.manufacturer[i][1]) ) then 
					print("you clicked "..weapon.manufacturer[i][1])
					gamestate = weapon.manufacturer[i][1].."Info"
					print(gamestate)
				end
			end 

			-- Checks for clicks on the rarities--
			for i = 1,#weapon.rarity do 
				if insideBox(x,y, (rebellionFont:getWidth("Arch-Tech") + 20), 30*i, default:getWidth(weapon.rarity[i][1]) , default:getHeight(weapon.rarity[i][1]) ) then 
					print("you clicked "..weapon.rarity[i][1])
					gamestate = weapon.rarity[i][1].."Info"
					print(gamestate)
				end
			end 
		end

		if tempVarToStop == "enabled" then 
			if button == "wu" or button =="wd" then 
				weapon1 = weapon.Create()
				weapon2 = weapon.Create()
				weapon3 = weapon.Create()
				weapon4 = weapon.Create()
				weapon5 = weapon.Create()
				weapon6 = weapon.Create()
				weapon7 = weapon.Create()
				weapon8 = weapon.Create()
				------------------------
				armor1 = armor.Create()
				armor2 = armor.Create()
				armor3 = armor.Create()
				armor4 = armor.Create()
				armor5 = armor.Create()
				armor6 = armor.Create()
				armor7 = armor.Create()
				armor8 = armor.Create()
				armor9 = armor.Create()
				armor10 = armor.Create()

  
				counter = counter + 8
				--print(counter)
			end 
		end 
	end

	--Runs Gatling Gun 
	if button == "l" then
		--cools down gatling
		animGo = true
	elseif button == "r" then 
		animGo = false
	end 
end


--fix splunk stuff to analyze data?
function love.quit()
	splunkSave(logs)
	love.event.quit()
end

--Used for hit boxes
function insideBox( px, py, x, y, wx , wy )
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end


--USED TO STEP THROUGH TABLES AND SUB TABLES
function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

--Similar to print_r, but returns a string rather than console output
function tableToString(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        indentLevel = 0
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..tableToString(value, (indentLevel + 1))
        else 
        	print("line 281, index is "..index.." value is, ")
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end