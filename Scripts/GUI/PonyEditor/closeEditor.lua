System_run("Scripts/GUI/PonyEditor/util.lua", MainScene)
function onClose()
	MainScene:setMetaData("PONY_EDITOR_IS_OPEN", 0)
	generatePlayer()
end