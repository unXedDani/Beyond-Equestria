function onSelect(selection)
	if selection == 0 then
		MainScene:addLight(0,0,0, 0,0,0, 1,1,1, 200, 0)
	elseif selection == 1 then
		MainScene:addLight(0,0,0, 0,0,0, 1,1,1, 200, 1)
	elseif selection == 2 then
		MainScene:addLight(0,0,0, 0,0,0, 1,1,1, 200, 2)
	else
		MainScene:SNLog("Invalid selection", selection)
	end
end

function onChange()

end