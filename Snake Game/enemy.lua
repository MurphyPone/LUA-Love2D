require("player")

enemy = {}
enemy.timer = 0
enemy.timerLim = math.random(3,5)
enemy.wave = 1
enemy.amount = math.random(1,5+ enemy.wave)
enemy.side = math.random(1,4)

function enemy.generate(dt)
	enemy.timer = enemy.timer + dt
	if enemy.timer > enemy.timerLim then 
		--Spawn 
		for i =1, enemy.amount do 
			if enemy.side == 1 then -- Left
				enemy.spawn(-50, screenHeight/2 -25)
			end 
			if enemy.side == 2 then -- Top
				enemy.spawn(screenWidth/2 -25, -50)
			end
			if enemy.side == 3 then -- right
				enemy.spawn(screenWidth,screenHeight/2 -25)
			end  
			if enemy.side == 4 then -- bottom
				enemy.spawn(screenWidth/2 -25, screenHeight)
			end   
			enemy.side = math.random(1,4) 

		end 
		enemy.wave = enemy.wave + 1

		enemy.amount =  math.random(1+enemy.wave,5+ enemy.wave)
		print(enemy.amount)
		enemy.timerLim = math.random(3,5)
		enemy.timer = 0
	end 
end 

enemy.width = 30
enemy.height = 30
enemy.speed = 1000
enemy.friction = 7.5
enemy.hit = false

function enemy.spawn(x,y)
	table.insert(enemy, {x=x, y=y, xvel=0, yvel=0, health = math.random(2,5), width = enemy.width, height = enemy.height})
end 


function enemy.draw()
	for i,v in ipairs(enemy) do
		love.graphics.setColor(61, 145, 64)
		love.graphics.rectangle("fill", v.x, v.y, enemy.width, enemy.height)
	end
end 

function enemy.physics(dt)
	for i,v in ipairs(enemy)do 
		v.x = v.x + v.xvel*dt
		v.y = v.y + v.yvel*dt
		v.xvel = v.xvel * (1 - math.min(dt*enemy.friction, 1))
		v.yvel = v.yvel * (1 - math.min(dt*enemy.friction, 1))
	end
end 

function enemy.AI(dt)
	for i,v in ipairs(enemy) do
		if o.x +o.w/2 < v.x+v.width/2 then 
			if v.xvel > -enemy.speed then 
				v.xvel = v.xvel - enemy.speed*dt 
			end 
		end

		if o.x +o.w/2 > v.x+v.width/2 then 
			if v.xvel < enemy.speed then 
				v.xvel = v.xvel + enemy.speed*dt 
			end 
		end
		---
		---
		if o.y + o.h/2 < v.y + v.height/2 then 
			if v.yvel > -enemy.speed then 
				v.yvel = v.yvel - enemy.speed*dt
			end 
		end  

		if o.y + o.h/2 > v.y + v.height/2 then 
			if v.yvel < enemy.speed then 
				v.yvel = v.yvel + enemy.speed*dt
			end 
		end   
	end 
end 

--[[function enemy.bullet_collide()
	for i,v in ipairs(enemy) do 
		for ia, va in ipairs(bullet) do 
			if va.x + va.width >v.x and 
			va.x < v.x + v.width and
			va.y + va.height >v.y and
			va.y < v.y + v.height then 
				v.health = v.health-1
				v.hit = true
				table.remove(bullet, ia)
				if v.health == 0 then
					table.remove(enemy, i)
				end
			end 
		end 
	end 
end ]]--

function enemy.player_collide()
	for i,v in ipairs(enemy) do 
		for ia, va in ipairs(o) do 
			if va.x + va.width >v.x and 
			va.x < v.x + v.w and
			va.y + va.h >v.y and
			va.y < v.y + v.height then 
				table.remove(enemy, i)
				--player.health = player.health - 1
				print("you dying") 
				if player.health == 0 then 
					player.isAlive = false
					print("you DIed")
				end  
				print(player.health)
			end 
		end 
	end 
end



--PARENT FUNCTION
function DRAW_ENEMY()
	enemy.draw()
end 

function UPDATE_ENEMY(dt)
	enemy.physics(dt)
	enemy.AI(dt)
	enemy.generate(dt)
	--enemy.bullet_collide()
	enemy.player_collide()
end 