
Rocket = {}	--A rocket is a table

function Rocket:create()	
	r = {}
		r.img = love.graphics.newImage("img/rocket.png") --"rocket.png"
		
		r.size = 10--r.img:getWidth() --Dimensions of the image, --Image:getWidth(), but r.img is not an image yet, just a String
		r.x = 0 --Left side of the screen
		r.y = (HEIGHT/2) - (r.size/2) --horizontally centered 

		r.alive = true	

		--gene counter 
		r.gene = 0 --/////can be property of population class 
		r.speed = 3-- pixels to move per step
		r.rotation = 0 --no rotation to begin with

		r.moves = {}	--Array which stores all move TODO make me a linkedList
		r.tailpts = {0, 0, 0, 0 }	--Stores ordered pairs of previous locations

		r.fitness = 0

		setmetatable(r, { __index = Rocket })	--Yea, still no idea
		
		--table.insert(population, r)	--This is weird, but it adds the current rocket to the population
		
	return r
end 

--//Rocket mechanics
function Rocket:isAlive() 
	if(self.x < WIDTH-self.size and self.y > self.size and self.y < HEIGHT - self.size) then
		 self.alive = true
	else 
		self.alive = false
	end 
end 
	
function Rocket:move()
	self:isAlive()	--This is dumb, booleans do it better
	if(self.alive == true) then 
		local dx = self.speed * math.cos( self.rotation )
		local dy = self.speed * math.sin( self.rotation )

		self.x = self.x + dx
		self.y = self.y + dy 
	end
end 

function Rocket:calcMove()
	local rng = math.random(-5,5)/100
	local nextRotation = self.rotation + rng	-- small adjust

	table.insert(self.moves, nextRotation)	--adds rotation to array which tracks movements

	table.insert(self.tailpts, self.x)--adds x to the array of ordered pairs of tail pts
	table.insert(self.tailpts, self.y)--adds y to the array of ordered pairs of tail pts

	return nextRotation
end


--//Coolio graphics
function Rocket:drawTail()
	love.graphics.line(self.tailpts)
end


-----//DEFAULTS
function Rocket:draw()
	love.graphics.draw(self.img, self.x, self.y, self.rotation, 1, 1, self.size/2, self.size/2)	
	self:drawTail()
end 

function Rocket:update(dt)
	self:move()
	self.rotation = self:calcMove()

	if(r.alive == false) then
		--for i =0, #self.moves do 
			--print(self.moves[i])
		--end 
	end 
end 


