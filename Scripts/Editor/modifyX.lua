function onEnter(text)
	local id = MainScene:getMetaData("LAST_SELECTION_GUI")
	local x, y, z = MainScene:getObject(id):getPosition()
	MainScene:getObject(id):setPosition(text, y, z)
end

function onChange()
end

function onMarkChange()
end