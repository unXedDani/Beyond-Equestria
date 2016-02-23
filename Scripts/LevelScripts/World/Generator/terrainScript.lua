function init()
	ParentObject:setMetaData("REMOVE", 0)
end

function distance(x1, y1, x2, y2)
	local xd = x2-x1
	local yd = y2-y1
	return math.sqrt(xd*xd+yd*yd)
end

function update()
	x, y, z = ParentObject:getPosition()
	local ppx, ppy, ppz = MainScene:getObject(MainScene:getMetaData("PLAYER_COLLIDER")):getPosition()
	if distance(x, z, ppx, ppz) > 1000 then ParentObject:setMetaData("REMOVE", 1) end
end

function render()

end