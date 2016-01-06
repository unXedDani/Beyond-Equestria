System_run("scripts/LevelScripts/World/Generator/terrain.lua", MainScene)
System_run("Scripts/LevelScripts/World/Generator/genBuildings.lua", MainScene)
System_run("Scripts/LevelScripts/World/Generator/cityNames.lua", MainScene)

function updateChunks(posx, posy, chunksize, terrainScale)
	local chunkx = math.floor(posx/chunksize)
	local chunky = math.floor(posy/chunksize)
	local half = (chunksize/2)
	local quarter = (chunksize/4)
	if MainScene:getMetaData("CHUNK"..chunkx.."_"..chunky) ~= 1 then
		local t = createChunk(chunkx, chunky, chunksize, terrainScale)
		smoothingPassNoRebuild(MainScene:getTerrain(t), chunksize, 10)
		MainScene:getTerrain(t):rebuild()
		addChunkCollider(MainScene:getTerrain(t))
		updateChunk(t)
		generateTrees(MainScene:getTerrain(t), chunkx, chunky, chunksize, terrainScale)
	end
	
	
	-- +X
	if posx - (chunkx * chunksize) > half+quarter then
		if MainScene:getMetaData("CHUNK"..(chunkx+1).."_"..chunky) ~= 1 then
			local t2id = createChunk(chunkx+1, chunky, chunksize, terrainScale)
			local t1 = MainScene:getTerrain(MainScene:getMetaData("CHUNKID"..chunkx.."_"..chunky))
			local t2 = MainScene:getTerrain(t2id)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(chunksize, i-1)
				t2:setHeightNoRebuild(0, i-1, h1)
			end
			smoothingPassNoRebuild(t2, chunksize, 10)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(chunksize, i-1)
				t2:setHeightNoRebuild(0, i-1, h1)
			end
			t2:rebuild()
			addChunkCollider(t2)
			updateChunk(t2id)
			generateTrees(t2, chunkx+1, chunky, chunksize, terrainScale)
		end
		if MainScene:getMetaData("CHUNK"..(chunkx-1).."_"..chunky) == 1 then
			MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx-1).."_"..chunky))
			MainScene:setMetaData("CHUNK"..(chunkx-1).."_"..chunky, 0)
		end
		if MainScene:getMetaData("CITYCHUNK"..(chunkx-1).."_"..chunky) == 1 then
			local models = MainScene:getMetaData("CITYCHUNKMODELS"..(chunkx-1).."_"..chunky)
			for i=1, models do
				MainScene:removeObject(MainScene:getMetaData("CITYCHUNKID"..i.."_"..(chunkx-1).."_"..chunky))
			end
			MainScene:setMetaData("CITYCHUNK"..(chunkx-1).."_"..chunky, 0)
		end
		removeTrees(chunkx-1, chunky)
	end
	
	
	-- -X
	if posx - (chunkx * chunksize) < quarter then
		if MainScene:getMetaData("CHUNK"..(chunkx-1).."_"..chunky) ~= 1 then
			local t2id = createChunk(chunkx-1, chunky, chunksize, terrainScale)
			local t1 = MainScene:getTerrain(MainScene:getMetaData("CHUNKID"..chunkx.."_"..chunky))
			local t2 = MainScene:getTerrain(t2id)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(0, i-1)
				t2:setHeightNoRebuild(chunksize, i-1, h1)
			end
			smoothingPassNoRebuild(t2, chunksize, 10)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(0, i-1)
				t2:setHeightNoRebuild(chunksize, i-1, h1)
			end
			t2:rebuild()
			addChunkCollider(t2)
			updateChunk(t2id)
			generateTrees(t2, chunkx-1, chunky, chunksize, terrainScale)
		end
		if MainScene:getMetaData("CHUNK"..(chunkx+1).."_"..chunky) == 1 then
			MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx+1).."_"..chunky))
			MainScene:setMetaData("CHUNK"..(chunkx+1).."_"..chunky, 0)
		end
		if MainScene:getMetaData("CITYCHUNK"..(chunkx+1).."_"..chunky) == 1 then
			local models = MainScene:getMetaData("CITYCHUNKMODELS"..(chunkx+1).."_"..chunky)
			for i=1, models do
				MainScene:removeObject(MainScene:getMetaData("CITYCHUNKID"..i.."_"..(chunkx+1).."_"..chunky))
			end
			MainScene:setMetaData("CITYCHUNK"..(chunkx+1).."_"..chunky, 0)
		end
		removeTrees(chunkx+1, chunky)
	end
	
	
	-- +Y
	if posy - (chunky * chunksize) > half+quarter then
		if MainScene:getMetaData("CHUNK"..chunkx.."_"..(chunky+1)) ~= 1 then
			local t2id = createChunk(chunkx, chunky+1, chunksize, terrainScale)
			local t1 = MainScene:getTerrain(MainScene:getMetaData("CHUNKID"..chunkx.."_"..chunky))
			local t2 = MainScene:getTerrain(t2id)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(i-1, chunksize)
				t2:setHeightNoRebuild(i-1, 0, h1)
			end
			smoothingPassNoRebuild(t2, chunksize, 10)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(i-1, chunksize)
				t2:setHeightNoRebuild(i-1, 0, h1)
			end
			t2:rebuild()
			addChunkCollider(t2)
			updateChunk(t2id)
			generateTrees(t2, chunkx, chunky+1, chunksize, terrainScale)
		end
		if MainScene:getMetaData("CHUNK"..chunkx.."_"..(chunky-1)) == 1 then
			MainScene:removeObject(MainScene:getMetaData("CHUNKID"..chunkx.."_"..(chunky-1)))
			MainScene:setMetaData("CHUNK"..chunkx.."_"..(chunky-1), 0)
		end
		if MainScene:getMetaData("CITYCHUNK"..chunkx.."_"..(chunky-1)) == 1 then
			local models = MainScene:getMetaData("CITYCHUNKMODELS"..chunkx.."_"..(chunky-1))
			for i=1, models do
				MainScene:removeObject(MainScene:getMetaData("CITYCHUNKID"..i.."_"..chunkx.."_"..(chunky-1)))
			end
			MainScene:setMetaData("CITYCHUNK"..chunkx.."_"..(chunky-1), 0)
		end
		removeTrees(chunkx, chunky-1)
	end
	
	
	-- -Y
	if posy - (chunky * chunksize) < quarter then
		if MainScene:getMetaData("CHUNK"..chunkx.."_"..(chunky-1)) ~= 1 then
			local t2id = createChunk(chunkx, chunky-1, chunksize, terrainScale)
			local t1 = MainScene:getTerrain(MainScene:getMetaData("CHUNKID"..chunkx.."_"..chunky))
			local t2 = MainScene:getTerrain(t2id)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(i-1, 0)
				t2:setHeightNoRebuild(i-1, chunksize, h1)
			end
			smoothingPassNoRebuild(t2, chunksize, 10)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(i-1, 0)
				t2:setHeightNoRebuild(i-1, chunksize, h1)
			end
			t2:rebuild()
			addChunkCollider(t2)
			updateChunk(t2id)
			generateTrees(t2, chunkx, chunky-1, chunksize, terrainScale)
		end
		if MainScene:getMetaData("CHUNK"..chunkx.."_"..(chunky+1)) == 1 then
			MainScene:removeObject(MainScene:getMetaData("CHUNKID"..chunkx.."_"..(chunky+1)))
			MainScene:setMetaData("CHUNK"..chunkx.."_"..(chunky+1), 0)
		end
		if MainScene:getMetaData("CITYCHUNK"..chunkx.."_"..(chunky+1)) == 1 then
			local models = MainScene:getMetaData("CITYCHUNKMODELS"..chunkx.."_"..(chunky+1))
			for i=1, models do
				MainScene:removeObject(MainScene:getMetaData("CITYCHUNKID"..i.."_"..chunkx.."_"..(chunky+1)))
			end
			MainScene:setMetaData("CITYCHUNK"..chunkx.."_"..(chunky+1), 0)
		end
		removeTrees(chunkx, chunky+1)
	end
	
	--CORNERS
	
	if posy - (chunky*chunksize) < half+quarter and posy - (chunky*chunksize) > quarter then
		if posx - (chunkx*chunksize) < half+quarter and posx - (chunkx*chunksize) > quarter then
			if MainScene:getMetaData("CHUNK"..(chunkx-1).."_"..(chunky-1)) == 1 then
				MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx-1).."_"..(chunky-1)))
				MainScene:setMetaData("CHUNK"..(chunkx-1).."_"..(chunky-1), 0)
				removeTrees(chunkx-1, chunky-1)
			end
		
			if MainScene:getMetaData("CHUNK"..(chunkx+1).."_"..(chunky-1)) == 1 then
				MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx+1).."_"..(chunky-1)))
				MainScene:setMetaData("CHUNK"..(chunkx+1).."_"..(chunky-1), 0)
				removeTrees(chunkx+1, chunky-1)
			end
			
			if MainScene:getMetaData("CHUNK"..(chunkx-1).."_"..(chunky+1)) == 1 then
				MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx-1).."_"..(chunky+1)))
				MainScene:setMetaData("CHUNK"..(chunkx-1).."_"..(chunky+1), 0)
				removeTrees(chunkx-1, chunky+1)
			end
			
			if MainScene:getMetaData("CHUNK"..(chunkx+1).."_"..(chunky+1)) == 1 then
				MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx+1).."_"..(chunky+1)))
				MainScene:setMetaData("CHUNK"..(chunkx+1).."_"..(chunky+1), 0)
				removeTrees(chunkx-1, chunky+1)
			end
		end
	end
end
function initTerrain(posx, posy, chunksize, terrainScale)
	chunkx = math.floor((posx)/chunksize)
	chunky = math.floor((posy)/chunksize)
	createChunk(chunkx, chunky, chunksize, terrainScale)
end
function createChunk(chunkx, chunky, chunksize, terrainScale)
	MainScene:SLog("Loading chunk: "..chunkx.."_"..chunky)
	local terrain = MainScene:addTerrain(chunkx*(chunksize*terrainScale), 0, chunky*(chunksize*terrainScale), 0, 0, 0, terrainScale, terrainScale, terrainScale)
	MainScene:getTerrain(terrain):empty(chunksize+1, chunksize+1, 64)
	local heightFactor = noise2((chunkx)/8000, (chunky)/8000) * 50
	heightFactor = interpolate(heightFactor, noise2((chunkx-1)/8000, (chunky)/8000) * 50, 0.1)
	heightFactor = interpolate(heightFactor, noise2((chunkx+1)/8000, (chunky)/8000) * 50, 0.1)
	heightFactor = interpolate(heightFactor, noise2((chunkx)/8000, (chunky-1)/8000) * 50, 0.1)
	heightFactor = interpolate(heightFactor, noise2((chunkx)/8000, (chunky+1)/8000) * 50, 0.1)
	if heightFactor < 1 then heightFactor = -heightFactor end
	generateChunk(MainScene:getTerrain(terrain), chunkx, chunky, chunksize, 1337, heightFactor)
	MainScene:getObject(terrain):setMaterialFlag("normalize_normals", 0.5)
	MainScene:getObject(terrain):setMaterialTexture(MainScene, 0, "Assets/Levels/World/textures/grass.jpg")
	MainScene:setMetaData("CHUNK"..chunkx.."_"..chunky, 1)
	MainScene:setMetaData("CHUNKID"..chunkx.."_"..chunky, terrain)
	MainScene:setMetaData("CHUNK_HEIGHT_FACTOR_"..chunkx.."_"..chunky, heightFactor)
	
	if heightFactor < 2 then
		MainScene:SLog("Generating City")
		MainScene:setMetaData("CITYCHUNK"..chunkx.."_"..chunky, 1)
		local cityBuildingModels = {}
		cityBuildingModels = generateCity(chunkx*terrainScale*chunksize, chunky*terrainScale*chunksize, 64, 64, 16, 4)
		MainScene:setMetaData("CITYCHUNKMODELS"..chunkx.."_"..chunky, 1)
		local cmesh = CMESH.new(MainScene, 0)
		for i=2, cityBuildingModels[1] do
			cmesh:addMesh(MainScene:getMesh(cityBuildingModels[i]))
			--MainScene:setMetaData("CITYCHUNKID"..(i-1)..chunkx.."_"..chunky, cityBuildingModels[i])
			--MainScene:SNLog("Found building model", cityBuildingModels[i])
		end
		local cm = MainScene:addCMesh(cmesh, 0, 0, 0, 0, 0, 0, 1, 1, 1)
		MainScene:getMesh(cm):addCollider(MainScene, "MESH_TRIMESH", 0)
		--MainScene:getObject(cm):setMaterialFlag("normalize_normals", 1)
		--MainScene:getObject(cm):useShader(MainScene, "Shaders/buildingShader.xml")
		MainScene:setMetaData("CITYCHUNKID".."1".."_"..chunkx.."_"..chunky, cm)
	end
	return terrain
end

function createChunk1(chunkx, chunky, chunksize, terrainScale)
	MainScene:SLog("Loading chunk: "..chunkx.."_"..chunky)
	local terrain = MainScene:addTerrain(chunkx*(chunksize*terrainScale), 0, chunky*(chunksize*terrainScale), 0, 0, 0, terrainScale, terrainScale, terrainScale)
	MainScene:getTerrain(terrain):empty(chunksize+1, chunksize+1, 64)
	generateChunk(MainScene:getTerrain(terrain), chunkx, chunky, chunksize, 1337)
	MainScene:getObject(terrain):setMaterialFlag("normalize_normals", 0.5)
	MainScene:getObject(terrain):setMaterialTexture(MainScene, 0, "Assets/Levels/World/textures/grass.jpg")
	MainScene:getObject(curBody):useShader(MainScene, "Shaders/buildingShader.xml")
	MainScene:setMetaData("CHUNK"..chunkx.."_"..chunky, 1)
	MainScene:setMetaData("CHUNKID"..chunkx.."_"..chunky, terrain)
	return terrain
end
function createChunkWithCollider(chunkx, chunky, chunksize, terrainScale)
	local t = createChunk(chunkx, chunky, chunksize, terrainScale)
	MainScene:getTerrain(t):addCollider(MainScene, "MESH_TRIMESH", 0)
	MainScene:getObject(t):getCollider():setFriction(100.0)
	return t
end
function updateChunk(terrain)
	MainScene:getObject(terrain):setMaterialFlag("normalize_normals", 1)
	MainScene:getObject(terrain):setMaterialTexture(MainScene, 0, "Assets/Levels/World/textures/grass.jpg")
end
function addChunkCollider(terrain)
	terrain:addCollider(MainScene, "MESH_TRIMESH", 0)
	MainScene:getObject(terrain:getID()):getCollider():setFriction(100.0)
end
function noise2(x, y)
	local n = x + y * 57
	n = bxor((n * 2^13), n);
	return ( 1.0 - ( (n * (n * n * 15731 + 789221) + 1376312589) % 2147483648) / 1073741824.0)
end
function generateTrees(terrain, chunkx, chunky, chunksize, terrainScale)
	MainScene:setMetaData("TREES_IN_"..chunkx.."_"..chunky, 0)
	local heightFactor = MainScene:getMetaData("CHUNK_HEIGHT_FACTOR_"..chunkx.."_"..chunky)
	if heightFactor > 2 and heightFactor < 20 then
		local trees = 0
		local cmnum = 1
		local c = CMESH.new(MainScene, 1000)
		local cmeshs = {}
		for x=1, chunksize-1 do
			for y=1, chunksize-1 do
				local modX = x+(chunksize*chunkx)
				local modY = y+(chunksize*chunky)
				local createTree = noise2(math.abs(modX)/9000, math.abs(modY)/9000)
				
				if createTree > 0.5 then
					local rotation = noise2(math.abs(modX)/10000, math.abs(modY)/7000)*180
					MainScene:SLog(rotation)
					local treeType = math.floor((noise2(math.abs(modX)/8000, math.abs(modY)/8000)*enviroObjects)+(enviroObjects/2))
					if treeType < 1 then
						treeType = 1
					end
					if treeType > enviroObjects then
						treeType = enviroObjects
					end
					local posX
					if chunkx < 0 then
						posX = (x*terrainScale)+(((chunksize*math.abs(chunkx))*(-1))*terrainScale)
					else
						posX = (x*terrainScale)+((chunksize*math.abs(chunkx))*terrainScale)
					end
					local posY
					if chunky < 0 then
						posY = (y*terrainScale)+(((chunksize*math.abs(chunky))*(-1))*terrainScale)
					else
						posY = (y*terrainScale)+((chunksize*math.abs(chunky))*terrainScale)
					end
					local offsetX = (rotation/180)*(terrainScale/2)
					local offsetY = (rotation/180)*(terrainScale/2)
					posX = posX + offsetX
					posY = posY + offsetY
					local treeID = MainScene:addMesh(enviroFilenames[treeType], posX, (terrain:getHeight(x, y)*5)-2, posY, 0, rotation, 0, 2, 2, 2)
					MainScene:getObject(treeID):setMaterialFlag("gouraud_shading", 1)
					MainScene:getObject(treeID):setMaterialFlag("mip_maps", 0)
					MainScene:getObject(treeID):setMaterialData(0, "texture", MainScene, 0, "Assets/Levels/world/textures/mane.jpg")
					MainScene:getObject(treeID):setMaterialData(1, "texture", MainScene, 0, "Assets/Levels/world/textures/mane.jpg")
					c:addMesh(MainScene:getMesh(treeID))
					cmeshs[cmnum] = treeID
					cmnum = cmnum + 1
					local e = MainScene:addEmpty(posX, terrain:getHeight(x, y)*5 + 10, posY, 0, 0, 0, 3,10, 3)
					MainScene:getMesh(e):addCollider(MainScene, "CUBE", 0)
					MainScene:setMetaData("TREES_ID_"..chunkx.."_"..chunky.."_"..trees, e)
					--MainScene:setMetaData("TREES_ID_"..chunkx.."_"..chunky.."_"..trees, treeID)
					trees = trees + 1
					
				elseif createTree < -0.5 then
					local rotation = noise2(math.abs(modX)/8001, math.abs(modY)/7000)*180
					MainScene:SLog(rotation)
					local treeType = math.floor((noise2(math.abs(modX)/8000, math.abs(modY)/8000)*rocks)+(rocks/2))
					if treeType < 1 then
						treeType = 1
					end
					if treeType > rocks then
						treeType = rocks
					end
					local posX
					if chunkx < 0 then
						posX = (x*terrainScale)+(((chunksize*math.abs(chunkx))*(-1))*terrainScale)
					else
						posX = (x*terrainScale)+((chunksize*math.abs(chunkx))*terrainScale)
					end
					local posY
					if chunky < 0 then
						posY = (y*terrainScale)+(((chunksize*math.abs(chunky))*(-1))*terrainScale)
					else
						posY = (y*terrainScale)+((chunksize*math.abs(chunky))*terrainScale)
					end
					local offsetX = (rotation/180)*(terrainScale/2)
					local offsetY = (rotation/180)*(terrainScale/2)
					posX = posX + offsetX
					posY = posY + offsetY
					local treeID = MainScene:addMesh(rockFilenames[treeType], posX, (terrain:getHeight(x, y)*5)-2, posY, 0, rotation, 0, 2,2, 2)
					MainScene:getObject(treeID):setMaterialFlag("gouraud_shading", 1)
					MainScene:getObject(treeID):setMaterialFlag("mip_maps", 0)
					MainScene:getObject(treeID):setMaterialData(0, "texture", MainScene, 0, "Assets/Levels/world/textures/mane.jpg")
					c:addMesh(MainScene:getMesh(treeID))
					cmeshs[cmnum] = treeID
					cmnum = cmnum + 1
					local e = MainScene:addEmpty(posX, (terrain:getHeight(x, y)*5) + 3, posY, 0, 0, 0, 3,3, 3)
					MainScene:getMesh(e):addCollider(MainScene, "CUBE", 0)
					MainScene:setMetaData("TREES_ID_"..chunkx.."_"..chunky.."_"..trees, e)
					trees = trees + 1
				end
			end
		end
		local posX = 0
		local posY = 0
		local cm = MainScene:addCMesh(c, posX, 0, posY, 0, 0, 0, 1, 1, 1)
		MainScene:getObject(cm):setMaterialFlag("normalize_normals", 1)
		
		--MainScene:getObject(cm):setMaterialFlag("mip_maps", 1)
		--MainScene:getObject(cm):setMaterialFlag("ansiotropic", 1)
		--MainScene:getObject(cm):setMaterialData(0, "texture", MainScene, 0, "Assets/Levels/world/textures/mane.jpg")
		--MainScene:getObject(cm):setMaterialData(1, "texture", MainScene, 0, "Assets/Levels/world/textures/mane.jpg")
		--MainScene:getObject(cm):setMaterialData(2, "texture", MainScene, 0, "Assets/Levels/world/textures/mane.jpg")
		MainScene:getObject(cm):setMaterialFlag("gouraud_shading", 1)
		MainScene:getObject(cm):setMaterialFlag("bilinear", 1)
		for i=1, cmnum-1 do
			--MainScene:removeObject(cmeshs[i])
		end
		MainScene:setMetaData("TREES_ID_"..chunkx.."_"..chunky.."_"..trees, cm)
		MainScene:setMetaData("TREES_IN_"..chunkx.."_"..chunky, trees)
	end
end

function removeTrees(chunkx, chunky)
	local tree = MainScene:getMetaData("TREES_IN_"..chunkx.."_"..chunky)
	if tree <= 0 then
		return
	end
	for i=0, tree do
		MainScene:removeObject(MainScene:getMetaData("TREES_ID_"..chunkx.."_"..chunky.."_"..i))
	end
	MainScene:setMetaData("TREES_IN_"..chunkx.."_"..chunky, 0)
end