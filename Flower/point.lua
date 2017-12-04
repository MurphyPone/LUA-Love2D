Point = {}	--A rocket is a table

function Point:create()	
	p = {}
		p.img = love.graphics.newImage("img/rocket.png") --"rocket.png"
		
		p.size = p.img:getWidth()/2 --Dimensions of the image, --Image:getWidth(), but r.img is not an image yet, just a String
		p.x = (WIDTH/2) - (p.size/2) --horizontally centered 
		p.y = (HEIGHT/2) - (p.size/2) --horizontally centered 

		p.alive = true	

		--gene counter 
		
		p.speed = 2-- pixels to move per step
		p.rotation = math.random(0, 2*math.pi) --no rotation to begin with

		p.moves = {}	--Array which stores all move TODO make me a linkedList
		p.tailpts = {p.x, p.y, p.x, p.y }	--Stores ordered pairs of previous locations

		p.hit = false
		p.agility = 50 -- higher = harder 
		p.seed = math.random(1,4) -- determines drawstyle
		p.radius = HEIGHT/2 - p.size*5

		setmetatable(p, { __index = Point })	--Yea, still no idea
				
	return p
end  

--//Rocket mechanics
function Point:isAlive() 
	if(self.alive == true) then 
		--if(self.x < self.size/2 or self.x > WIDTH-self.size or self.y < self.size or self.y > HEIGHT - self.size) then --Is on the screen
		if(getDist(self, c) > self.radius) then --Is on the screen			 
			self.alive = false
		end
	end
end 
	
function Point:move()
	--local dx = self.speed * math.cos( self.rotation )
	--local dy = self.speed * math.sin( self.rotation )	//ALT MOVEMENT METHOD

	local dx = math.cos( self.rotation )
	local dy = math.sin( self.rotation )

	self.x = self.x + dx*self.speed 
	self.y = self.y + dy*self.speed  --* 5 to make it smarter steeper
end 

function Point:calcMove()
	local rng = math.random(-self.agility,self.agility)/100
	local nextRotation = self.rotation + rng	-- small adjust

	table.insert(self.moves, nextRotation)	--adds rotation to array which tracks movements

	table.insert(self.tailpts, self.x)--adds x to the array of ordered pairs of tail pts
	table.insert(self.tailpts, self.y)--adds y to the array of ordered pairs of tail pts

	return nextRotation
end


--//Coolio graphics
function Point:drawTail()
	local dist = getDist(self, c)	--Max dist is like 1000,700
	
	local colors = self:getDrawStyle(self.seed)

	love.graphics.setColor(colors)
	
	--love.graphics.setLineWidth(dist/15)
	--love.graphics.setLineWidth(math.random(3))

	love.graphics.setLineWidth(1)
	love.graphics.polygon( "fill", self.tailpts )
	love.graphics.setColor(0,0,0)
	love.graphics.line(self.tailpts)
	love.graphics.setColor(255,255,255)
end


-----//DEFAULTS
function Point:draw()
	--love.graphics.draw(self.img, self.x, self.y, self.rotation, 1, 1, self.size/2, self.size/2)	
	self:drawTail()
end 

function Point:update(dt)
	self:isAlive(true)	--This is dumb, booleans do it better
	
	if(self.alive == true) then 
		self:move()
		self.rotation = self:calcMove()
	end

	if(self.alive == false) then
		--for i =0, #self.moves do 
			--print(self.moves[i])
		--end 
	end 
end 


function Point:getDrawStyle(int) 
	local colors = null

	if(int == 1 ) then 
		colors = { map(self.x, c.x, self.radius, 0, 255), map(self.x, c.x, self.radius, 0, 255), map(self.x, c.x, self.radius, 0, 255), 40}
	elseif(int == 2) then 
		colors = { map(self.y, c.y, self.radius, 0, 255), map(self.x, c.x, self.radius, 0, 255), map(self.x, c.x, self.radius, 0, 255), 40}
	elseif(int == 3) then 
		colors = { map(self.x, 0, self.radius, 0, 255), map(self.y, c.y, self.radius, 0, 255), map(self.x, c.x, self.radius, 0, 255), 40}
	elseif(int == 4) then 
		colors = { map(self.x, c.x, self.radius, 0, 255), map(self.x, 0, self.radius, 0, 255), map(self.y, c.y, self.radius, 0, 255), 40}
	end

	return colors
end 


