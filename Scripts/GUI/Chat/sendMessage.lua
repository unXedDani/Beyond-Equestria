function onEnter(text)
	if(text == "") then return end
	local pack = MainScene:createPacket()
	pack:writeNumber(8)
	pack:writeString(MainScene:getMetaString("PLAYER_NAME"))
	pack:writeString(text)
	MainScene:sendPacket(pack, MainScene:getMetaString("SERVERCOMBINEDIP"))
	current:setText("")
end

function onChange()
end

function onMarkChange()
end