function love.load()
	--Dunno why the tables can't be created here, but it errors saying they're all nil...
end

--Declaring stuff to put in tables
	simpleVar = love.timer.getDelta()

	simpleTable = {
			[1] = 1,
			[2] = "Simple String",
			[3] = "true",
			[4] = simpleVar
	}

	--creates file to be written to, --MAKE FUNCTION TO SELECT WHAT FILETYPE TO SAVE TO
	love.filesystem.newFile("output.json")
	outputFile = {}

	complexTable = {
			[1] = "A Test String",
			[2] = {"Part one of 3 Strings", "Part Two of 3 Strings", "Part 3 of 3 Strings"},
			[3] = simpleTable,
			[4] = { {0, 200, 60}, {"yes", "no", "maybe so"}}
	}

	complexTable.boolean = "true"

--Internet's solution
function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        --print(print_r(arr, 0))
        indentLevel = 0
        --return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else 
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end

output = print_r(complexTable, 0)

--functions to insert and save data to file
function splunkInsert(data)
	table.insert(outputFile, data)
end

--writes hopefully?  Can't seem to write whole table 
function splunkSave(data)
	print("The # of items in outputFile === "..#outputFile)
	--print(tableToString(outputFile))

	for i = 1, #outputFile do 
		love.filesystem.write("output.json", output) --tostring?
	end
end 

splunkInsert(output)





--My  function that doesn;t work 
--[[function outputTable(fTable)
	local resultString = ""
	
	for i = 1,#fTable do 
		if type(fTable[i]) == "table" then
			for k,v in pairs(fTable) do 
				if type(v) == "table" then 
					--somehow call self again and again and again?
				else
			   	 print(k,v)
			   	 resultString = resultString..k..", "..v
				end
			end 

		else 
			print(fTable[i])
			resultString = resultString..fTable[i]
		end
	end 

	--somehow concatinate all the outputs to a string with indents???
	return resultString
end 

--outputTable(complexTable)]]--
	
function love.draw()
	love.graphics.print(output, 200, 200)
end

function love.update(dt)
	
end

function love.quit()
	splunkSave(outputFile)
	love.event.quit()
end



