function onEnter(text)
	MainScene:addParticle(0, 0, 0, 0, 1, 0, 1, 1, 1, text)
end

function onChange()
end

function onMarkChange()
end

function onSelect(name)
	MainScene:addParticle(0, 0, 0, 0, 1, 0, 1, 1, 1, name)
end
function onCancel()
end