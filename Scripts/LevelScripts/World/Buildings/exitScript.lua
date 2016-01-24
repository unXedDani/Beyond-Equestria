function init()
	System_run("scripts/defs.lua", MainScene)
end

function update()
	local x, y, z = MainScene:getObject(MainScene:getMetaData("PLAYER_COLLIDER")):getPosition()
	local doorx, doory, doorz
	local posx, posy, posz = ParentObject:getPosition()
	doorx = ParentObject:getMetaData("EXIT_X")+posx
	doory = ParentObject:getMetaData("EXIT_Y")+posy
	doorz = ParentObject:getMetaData("EXIT_Z")+posz
	
	if(distance(x, z, doorx, doorz) < 10 and math.abs(y-doory)<10) then
		print("In Range")
		if MainScene:getKey(KEY_KEY_E) == 1 then
			MainScene:setMetaData("LEFT_DOOR", 1)
			local tpx = ParentObject:getMetaData("PARENT_X")
			local tpy = ParentObject:getMetaData("PARENT_Y")
			local tpz = ParentObject:getMetaData("PARENT_Z")
			MainScene:getObject(MainScene:getMetaData("PLAYER_COLLIDER")):setPosition(tpx, tpy, tpz)
			MainScene:removeObject(ParentObject:getID())
		end
	end
end

function render()

end

function distance(x1, y1, x2, y2)
	local xd = x2-x1
	local yd = y2-y1
	return math.sqrt(xd*xd+yd*yd)
end
