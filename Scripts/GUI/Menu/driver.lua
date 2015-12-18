function onSelect(selection)
end
function onChange(selection)
	if(selection == 0) then
		MainScene:setConfigValue("driver", 2)
	end	
	if(selection == 1) then
		MainScene:setConfigValue("driver", 1)
	end
	if(selection == 2) then
		MainScene:setConfigValue("driver", 3)
	end
end