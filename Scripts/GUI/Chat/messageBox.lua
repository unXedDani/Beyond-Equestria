System_run("scripts/defs.lua", MainScene)
function onSelect(selection)
	local x = MainScene:getConfigValue("width")/2
	local y = MainScene:getConfigValue("height")/2
	local tmp = createWindow("Message", x-100, y-100, x+100, y+100, 0, "Scripts/Editor/emptyWindow.lua")
	local txt = MainScene:addText(MainScene:getMetaString("CHAT_MESSAGE_GUI_"..selection), 20, 30, 180, 180, tmp)
	MainScene:getGUIObject(txt):setWordWrap(1)
end
function onChange()

end