DNA = {}

function DNA:cdnaeate(genes) 
	dna = {}

		dna.agility = math.pi/100

		
		if(genes) then --if genes are passed in
			dna.genes = genes
		else 
			dna.genes = {}
			
			for i = 0, WIDTH do 
				dna.genes[i] = love.math.random(-dna.agility, dna.agility)	-- + - 10 degrees from current rotation
			end
		end 

		setmetatable(dna, { __index = DNA })	--Yea, still no idea
		
		--table.insert(population, dna)	--This is weidnad, but it adds the cudnadnaent dnaocket to the population
		
		return dna
end 
