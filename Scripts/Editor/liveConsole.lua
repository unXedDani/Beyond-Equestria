function onEnter(text)
	assert(loadstring(text))()
	MainScene:SSLog("Ran ", text)
end

function onChange()
end

function onMarkChange()
end