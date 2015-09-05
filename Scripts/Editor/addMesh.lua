function onEnter(text)
	MainScene:addMesh(text, 0, 0, 0, 0, 0, 0, 1, 1, 1)
end

function onChange()
end

function onMarkChange()
end
function onSelect(name)
	MainScene:addMesh(name, 0, 0, 0, 0, 0, 0, 1, 1, 1)
end
function onCancel()
end