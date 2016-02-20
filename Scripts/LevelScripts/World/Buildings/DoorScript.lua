

shopFiles = {
			"Assets/Levels/world/models/CityBuildingParts/Interiors/CandyStore.obj"
			}
shopExitX = {0.5}
shopExitY = {0}
shopExitZ = {17}

lobbyFiles = {
			"Assets/Levels/world/models/CityBuildingParts/Interiors/Hotel_Lobby.obj"
}
lobbyExitX = {3.7}
lobbyExitY = {0}
lobbyExitZ = {38.5}

function init()
	System_run("scripts/defs.lua", MainScene)
	MainScene:setMetaData("LEFT_DOOR", 0)
end
local timer = 0
local delay = 1
local onDelay = 0
function update()
	local x, y, z = MainScene:getObject(MainScene:getMetaData("PLAYER_COLLIDER")):getPosition()
	local doorx, doory, doorz = ParentObject:getPosition()
	local ax, ay, az = ParentObject:getPosition()
	if(distance(x, z, doorx, doorz) < 10 and math.abs(y-doory)<10) then
		if onDelay == 0 and MainScene:getMetaData("LEFT_DOOR") == 1 then
			onDelay = 1
			MainScene:setMetaData("LEFT_DOOR", 0)
		end
		if onDelay == 1 then
			if timer >= delay then
				onDelay = 0
				timer = 0
			else
				timer = timer + (MainScene:deltaTime() / 1000)
				return
			end
		end
		if MainScene:getKey(KEY_KEY_E) == 1 and onDelay == 0 then
			local btype = ParentObject:getMetaData("BUILDING_TYPE")
			local id
			if btype == 1 then
				id = spawnInterior(shopFiles[1])
				MainScene:getObject(id):setMetaData("EXIT_X", shopExitX[1])
				MainScene:getObject(id):setMetaData("EXIT_Y", shopExitY[1])
				MainScene:getObject(id):setMetaData("EXIT_Z", shopExitZ[1])
				
				MainScene:getObject(id):setMetaData("PARENT_X", x)
				MainScene:getObject(id):setMetaData("PARENT_Y", y)
				MainScene:getObject(id):setMetaData("PARENT_Z", z)
				MainScene:getObject(MainScene:getMetaData("PLAYER_COLLIDER")):setPosition(ax, -95, az)
				MainScene:getObject(id):addScript(MainScene, "Scripts/LevelScripts/World/Buildings/exitScript.lua")
			elseif btype == 2 then
				id = spawnInterior(lobbyFiles[1])
				MainScene:getObject(id):setMetaData("EXIT_X", lobbyExitX[1])
				MainScene:getObject(id):setMetaData("EXIT_Y", lobbyExitY[1])
				MainScene:getObject(id):setMetaData("EXIT_Z", lobbyExitZ[1])
				
				MainScene:getObject(id):setMetaData("PARENT_X", x)
				MainScene:getObject(id):setMetaData("PARENT_Y", y)
				MainScene:getObject(id):setMetaData("PARENT_Z", z)
				MainScene:getObject(MainScene:getMetaData("PLAYER_COLLIDER")):setPosition(ax, -95, az)
				MainScene:getObject(id):addScript(MainScene, "Scripts/LevelScripts/World/Buildings/exitScript.lua")
			end
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

function spawnInterior(file)
	local x, y, z = ParentObject:getPosition()
	local t1 = MainScene:addMesh(file, x, -100, z, 0, 0, 0, 1, 1, 1)
	MainScene:getMesh(t1):addCollider(MainScene, "MESH_GIMPACT", 0)
	for i=0, MainScene:getObject(t1):getMaterialCount() do
		MainScene:getObject(t1):setMaterialData(i, "texture", MainScene, 0, "Assets/Levels/world/textures/buildingWhite.png")
		--MainScene:getObject(t1):useShaderOnMaterial(MainScene, "Shaders/buildingShaderSolid.xml", i)
	end
	
	return t1
end