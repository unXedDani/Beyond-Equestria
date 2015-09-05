function onEnter(text)
	local pack = MainScene:createPacket()
	pack:writeNumber(8)
	pack:writeString(MainScene:getMetaString("PLAYER_NAME"))
	pack:writeString(text)
	MainScene:sendPacket(pack, "173.62.195.104|7777")
	current:setText("")
end

function onChange()
end

function onMarkChange()
end