function onEnter(text)
	local id = MainScene:getMetaData("LAST_SELECTION_GUI")
	local r, g, b = MainScene:getLight(id):getColor()
	MainScene:getLight(id):setColor(text, g, b)
end

function onChange()
end

function onMarkChange()
end