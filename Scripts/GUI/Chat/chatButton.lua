System_run("Scripts/defs.lua", MainScene)
function onClick()
	MainScene:getGUIObject(MainScene:getMetaData("CHAT_BUTTON_ID")):removeElement()
	
	local win = createWindow("Chat", 0, 0, 300, 210, 0, "Scripts/GUI/Chat/chatWindow.lua")
	local mes = MainScene:addListBox(10, 30, 290, 160, win, "Scripts/GUI/Chat/messageBox.lua")
	MainScene:getGUIObject(mes)
	MainScene:setMetaData("CHATMESSAGEBOX", mes)
	MainScene:addEditBox("", 10, 160, 290, 180, 1, win, "Scripts/GUI/Chat/sendMessage.lua")
end