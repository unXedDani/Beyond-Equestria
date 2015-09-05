function onEnter(text)
	local id = MainScene:getMetaData("LAST_SELECTION_GUI")
	MainScene:getObject(id):setName(text)
end

function onChange()
end

function onMarkChange()
end