System_run("scripts/defs.lua", MainScene)
function onClick()
	local x = MainScene:getConfigValue("width")/2
	local y = MainScene:getConfigValue("height")/2
	local tmp = createWindow("", x-100, y-30, x+100, y+30, 0, "Scripts/GUI/Menu/start.lua")
	MainScene:getGUIObject(tmp):drawTitlebar(0)
	MainScene:addEditBox("Username...", 20, 15, 180, 45, 0, tmp, "Scripts/GUI/Chat/setName.lua")
	MainScene:setMetaData("MENUCAMERATRACK", 2)
end
function onClose()
	MainScene:setMetaData("MENUCAMERATRACK", 1)
end
