function onSelect(selection)
	if(selection == 0) then
		MainScene:setConfigValue("driver", 2)
	end	
	if(selection == 1) then
		MainScene:setConfigValue("driver", 1)
	end
	if(selection == 2) then
		MainScene:setConfigValue("driver", 3)
	end
	MainScene:saveConfig("config.xml")
end
function onChange(selection)
end