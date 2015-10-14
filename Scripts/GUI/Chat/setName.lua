function onEnter(text)
	MainScene:setMetaString("PLAYER_NAME", text)
	MainScene:clearGUI()
	MainScene:setMetaData("MENUCAMERATRACK", 3)
	MainScene:setPort(MainScene:getMetaData("SERVERPORT"))
	MainScene:setIP(MainScene:getMetaString("SERVERIP"))
	MainScene:setMaxClients(1)
	MainScene:setNetMode(0)
	MainScene:initNet("Scripts/receive.lua")
	MainScene:setMetaData("NETRUNNING", 1)
end

function onChange()
end

function onMarkChange()
end