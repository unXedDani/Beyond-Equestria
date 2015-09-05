function onClick()
	MainScene:setPort(7777)
	MainScene:setIP("173.62.195.104")
	MainScene:setMaxClients(1)
	MainScene:setNetMode(0)
	MainScene:initNet("receive.lua")
	MainScene:setMetaData("NETRUNNING", 1)
end