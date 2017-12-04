require("point")

Flower = {}	--A rocket is a table
pSize = 0--STATIC

function Flower:create(size)	--Add existing
	f = {}	--p is an array of several rockets
		pSize = size
		for i = 0, pSize do 
			f[i] = Point:create()	--create size rockets
			print(f[i].seed)
		end 

	setmetatable(f, { __index = Flower })	--Yea, still no idea	

	return f
end 

function Flower:draw()
	for k, v in pairs(self) do 
    	v:draw()
  	end 
end 

function Flower:update(dt)
	for k, v in pairs(self) do --Updates all the rockets
    	v:update(dt)
  	end 

end 
