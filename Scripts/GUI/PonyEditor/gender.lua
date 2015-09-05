function onSelect(selection)
	if(selection == 0) then
		MainScene:setMetaData("PLAYER_GENDER", 0)
	elseif(selection == 1) then
		MainScene:setMetaData("PLAYER_GENDER", 1)
	else
		MainScene:SLog("Unknown gender selection", selection)
	end
end

function onChange(selection)
	if(selection == 0) then
		MainScene:setMetaData("PLAYER_GENDER", 0)
	elseif(selection == 1) then
		MainScene:setMetaData("PLAYER_GENDER", 1)
	else
		MainScene:SLog("Unknown gender selection", selection)
	end
end