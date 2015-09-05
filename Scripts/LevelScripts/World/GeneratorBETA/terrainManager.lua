System_run("scripts/LevelScripts/World/Generator/terrain.lua", MainScene)
System_run("Scripts/LevelScripts/World/Generator/genBuildings.lua", MainScene)
function updateChunks(posx, posy, chunksize, terrainScale)
	local chunkx = math.floor(posx/chunksize)
	local chunky = math.floor(posy/chunksize)
	local half = (chunksize/2)
	local quarter = (chunksize/4)
	if MainScene:getMetaData("CHUNK"..chunkx.."_"..chunky) ~= 1 then
		local t = createChunk(chunkx, chunky, chunksize, terrainScale)
		smoothingPassNoRebuild(MainScene:getTerrain(t), chunksize, 7)
		MainScene:getTerrain(t):rebuild()
		addChunkCollider(MainScene:getTerrain(t))
		updateChunk(t)
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
			smoothingPassNoRebuild(t2, chunksize, 7)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(chunksize, i-1)
				t2:setHeightNoRebuild(0, i-1, h1)
			end
			t2:rebuild()
			addChunkCollider(t2)
			updateChunk(t2id)
		end
		if MainScene:getMetaData("CHUNK"..(chunkx-1).."_"..chunky) == 1 then
			MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx-1).."_"..chunky))
			MainScene:setMetaData("CHUNK"..(chunkx-1).."_"..chunky, 0)
		end
		if MainScene:getMetaData("CITYCHUNK"..(chunkx-1).."_"..chunky) == 1 then
			local models = MainScene:getMetaData("CITYCHUNKMODELS"..(chunkx-1).."_"..chunky)
			for i=1, models do
				MainScene:removeObject(MainScene:getMetaData("CITYCHUNKID"..i..(chunkx-1).."_"..chunky))
			end
			MainScene:setMetaData("CITYCHUNK"..(chunkx-1).."_"..chunky, 0)
		end
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
			smoothingPassNoRebuild(t2, chunksize, 7)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(0, i-1)
				t2:setHeightNoRebuild(chunksize, i-1, h1)
			end
			t2:rebuild()
			addChunkCollider(t2)
			updateChunk(t2id)
		end
		if MainScene:getMetaData("CHUNK"..(chunkx+1).."_"..chunky) == 1 then
			MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx+1).."_"..chunky))
			MainScene:setMetaData("CHUNK"..(chunkx+1).."_"..chunky, 0)
		end
		if MainScene:getMetaData("CITYCHUNK"..(chunkx+1).."_"..chunky) == 1 then
			local models = MainScene:getMetaData("CITYCHUNKMODELS"..(chunkx+1).."_"..chunky)
			for i=1, models do
				MainScene:removeObject(MainScene:getMetaData("CITYCHUNKID"..i..(chunkx+1).."_"..chunky))
			end
			MainScene:setMetaData("CITYCHUNK"..(chunkx+1).."_"..chunky, 0)
		end
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
			smoothingPassNoRebuild(t2, chunksize, 7)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(i-1, chunksize)
				t2:setHeightNoRebuild(i-1, 0, h1)
			end
			t2:rebuild()
			addChunkCollider(t2)
			updateChunk(t2id)
		end
		if MainScene:getMetaData("CHUNK"..chunkx.."_"..(chunky-1)) == 1 then
			MainScene:removeObject(MainScene:getMetaData("CHUNKID"..chunkx.."_"..(chunky-1)))
			MainScene:setMetaData("CHUNK"..chunkx.."_"..(chunky-1), 0)
		end
		if MainScene:getMetaData("CITYCHUNK"..chunkx.."_"..(chunky-1)) == 1 then
			local models = MainScene:getMetaData("CITYCHUNKMODELS"..chunkx.."_"..(chunky-1))
			for i=1, models do
				MainScene:removeObject(MainScene:getMetaData("CITYCHUNKID"..i..chunkx.."_"..(chunky-1)))
			end
			MainScene:setMetaData("CITYCHUNK"..chunkx.."_"..(chunky-1), 0)
		end
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
			smoothingPassNoRebuild(t2, chunksize, 7)
			for i=1, chunksize+1 do
				local h1 = t1:getHeight(i-1, 0)
				t2:setHeightNoRebuild(i-1, chunksize, h1)
			end
			t2:rebuild()
			addChunkCollider(t2)
			updateChunk(t2id)
		end
		if MainScene:getMetaData("CHUNK"..chunkx.."_"..(chunky+1)) == 1 then
			MainScene:removeObject(MainScene:getMetaData("CHUNKID"..chunkx.."_"..(chunky+1)))
			MainScene:setMetaData("CHUNK"..chunkx.."_"..(chunky+1), 0)
		end
		if MainScene:getMetaData("CITYCHUNK"..chunkx.."_"..(chunky+1)) == 1 then
			local models = MainScene:getMetaData("CITYCHUNKMODELS"..chunkx.."_"..(chunky+1))
			for i=1, models do
				MainScene:removeObject(MainScene:getMetaData("CITYCHUNKID"..i..chunkx.."_"..(chunky+1)))
			end
			MainScene:setMetaData("CITYCHUNK"..chunkx.."_"..(chunky+1), 0)
		end
	end
	
	--CORNERS
	
	if posy - (chunky*chunksize) < half+quarter and posy - (chunky*chunksize) > quarter then
		if posx - (chunkx*chunksize) < half+quarter and posx - (chunkx*chunksize) > quarter then
			if MainScene:getMetaData("CHUNK"..(chunkx-1).."_"..(chunky-1)) == 1 then
				MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx-1).."_"..(chunky-1)))
				MainScene:setMetaData("CHUNK"..(chunkx-1).."_"..(chunky-1), 0)
			end
		
			if MainScene:getMetaData("CHUNK"..(chunkx+1).."_"..(chunky-1)) == 1 then
				MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx+1).."_"..(chunky-1)))
				MainScene:setMetaData("CHUNK"..(chunkx+1).."_"..(chunky-1), 0)
			end
			
			if MainScene:getMetaData("CHUNK"..(chunkx-1).."_"..(chunky+1)) == 1 then
				MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx-1).."_"..(chunky+1)))
				MainScene:setMetaData("CHUNK"..(chunkx-1).."_"..(chunky+1), 0)
			end
			
			if MainScene:getMetaData("CHUNK"..(chunkx+1).."_"..(chunky+1)) == 1 then
				MainScene:removeObject(MainScene:getMetaData("CHUNKID"..(chunkx+1).."_"..(chunky+1)))
				MainScene:setMetaData("CHUNK"..(chunkx+1).."_"..(chunky+1), 0)
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
	local heightFactor = noise2(10+chunkx, 10+chunky) * 30
	if heightFactor < 1 then heightFactor = -heightFactor end
	print(heightFactor)
	generateChunk(MainScene:getTerrain(terrain), chunkx, chunky, chunksize, 1337, heightFactor)
	MainScene:getObject(terrain):setMaterialFlag("normalize_normals", 0.5)
	MainScene:getObject(terrain):setMaterialTexture(MainScene, 0, "Assets/Levels/World/textures/grass.jpg")
	MainScene:setMetaData("CHUNK"..chunkx.."_"..chunky, 1)
	MainScene:setMetaData("CHUNKID"..chunkx.."_"..chunky, terrain)
	if heightFactor < 2 then
		MainScene:SLog("Generating City")
		MainScene:setMetaData("CITYCHUNK"..chunkx.."_"..chunky, 1)
		local cityBuildingModels = {}
		cityBuildingModels = generateCity(chunkx*terrainScale*chunksize, chunky*terrainScale*chunksize, 64, 64, 16, 4)
		MainScene:setMetaData("CITYCHUNKMODELS"..chunkx.."_"..chunky, cityBuildingModels[1]-1)
		for i=2, cityBuildingModels[1] do
			MainScene:setMetaData("CITYCHUNKID"..(i-1)..chunkx.."_"..chunky, cityBuildingModels[i])
			MainScene:SNLog("Found building model", cityBuildingModels[i])
		end
	end
	return terrain
end
function createChunkWithCollider(chunkx, chunky, chunksize, terrainScale)
	local t = createChunk(chunkx, chunky, chunksize, terrainScale)
	MainScene:getTerrain(t):addCollider(MainScene, "MESH_GIMPACT", 0)
	return t
end
function updateChunk(terrain)
	MainScene:getObject(terrain):setMaterialFlag("normalize_normals", 1)
	MainScene:getObject(terrain):setMaterialTexture(MainScene, 0, "Assets/Levels/World/textures/grass.jpg")
end
function addChunkCollider(terrain)
	terrain:addCollider(MainScene, "MESH_GIMPACT", 0)
end
function noise2(x, y)
	local n = x + y * 57
	n = bxor((n * 2^13), n);
	return ( 1.0 - ( (n * (n * n * 15731 + 789221) + 1376312589) % 2147483648) / 1073741824.0)
end
