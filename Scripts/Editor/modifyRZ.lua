function onEnter(text)
	local id = MainScene:getMetaData("LAST_SELECTION_GUI")
	local x, y, z = MainScene:getObject(id):getRotation()
	MainScene:getObject(id):setRotation(x, y, text)
end

function onChange()
end

function onMarkChange()
end