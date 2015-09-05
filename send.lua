function onClick()
end
function onEnter(text)
	print"Sending message"
	local pack = MainScene:createPacket()
	pack:writeString(text)
	MainScene:sendPacket(pack, "173.62.195.104|7777")
end

function onChange()
end

function onMarkChange()
end