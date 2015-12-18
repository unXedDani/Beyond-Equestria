function onSelect(selection)
end
function onChange(selection)
	if(selection == 0) then
		MainScene:setConfigValue("height", 768)
		MainScene:setConfigValue("width", 1024)
	end	
	if(selection == 1) then
		MainScene:setConfigValue("height", 800)
		MainScene:setConfigValue("width", 1280)
	end
	if(selection == 2) then
		MainScene:setConfigValue("height", 900)
		MainScene:setConfigValue("width", 1440)
	end
	if(selection == 3) then
		MainScene:setConfigValue("height", 900)
		MainScene:setConfigValue("width", 1600)
	end
	if(selection == 4) then
		MainScene:setConfigValue("height", 1200)
		MainScene:setConfigValue("width", 1600)
	end
end