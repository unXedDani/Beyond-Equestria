function onClick()
	MainScene:setPort(7777)
	MainScene:setIP("127.0.0.1")
	MainScene:setMaxClients(2)
	MainScene:setNetMode(1)
	MainScene:initNet("receive.lua")
	MainScene:setMetaData("NETRUNNING", 1)
end