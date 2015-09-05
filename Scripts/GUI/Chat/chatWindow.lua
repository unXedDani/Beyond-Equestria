function onClose()
	local but = MainScene:addButton("Open Chat", "Opens Chat", 20, 50, 130, 70, 0, "Scripts/GUI/Chat/chatButton.lua")
	MainScene:setMetaData("CHAT_BUTTON_ID", but)
end