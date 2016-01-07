function init()

end

function update()
	local x, y, z = MainScene:getObject(MainScene:getMetaData("PLAYER_COLLIDER")):getPosition()
	local doorx, doory, doorz = ParentObject:getPosition()
	if(distance(x, z, doorx, doorz) < 5) then
		print("Door in range")
	end
end

function render()

end
function distance(x1, y1, x2, y2)
	local xd = x2-x1
	local yd = y2-y1
	return math.sqrt(xd*xd+yd*yd)
end