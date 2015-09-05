function onClick()
	if MainScene:getMetaData("NETRUNNING") == 1 then
		local p = MainScene:createPacket()
		p:writeNumber(2)
		p:writeNumber(MainScene:getMetaData("PLAYER_ID"))
		p:writeString(MainScene:getMetaString("PLAYER_NAME"))
		MainScene:sendPacket(p, "173.62.195.104|7777")
		MainScene:disconnect()
	end
	MainScene:quit()
end