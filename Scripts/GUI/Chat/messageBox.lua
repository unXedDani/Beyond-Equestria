function onSelect(selection)
	local x = MainScene:getConfigValue("width")/2
	local y = MainScene:getConfigValue("height")/2
	local tmp = MainScene:addWindow("Message", x-100, y-100, x+100, y+100, 0, "Scripts/Editor/emptyWindow.lua")
	local txt = MainScene:addText(MainScene:getMetaString("CHAT_MESSAGE_GUI_"..selection), 20, 30, 130, 140, tmp)
	MainScene:getGUIObject(txt):setWordWrap(1)
end
function onChange()

end