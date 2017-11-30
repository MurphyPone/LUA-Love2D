local inspect = require("lib/inspect")
function LOAD_SPLUNK()
	--All ever weapon that gets generated?
	logs = {}
	love.filesystem.newFile("logsFile.json")
end 

function splunkInsert(data)
	table.insert(logs, data)
end

--writes hopefully?  can't seem to write whole table 
function splunkSave(data)
	print("The # of items in log === "..#logs)
	--print_r(logs)
	local str = inspect(logs)
	for i = 1, #logs do 
		--love.filesystem.write("logsFile.json", str )
	end
end 

