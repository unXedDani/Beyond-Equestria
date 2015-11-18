largeBuildingBottomFiles = {
	"Assets/Levels/World/Models/CityBuildingParts/base1.dae",
	"Assets/Levels/World/Models/CityBuildingParts/base2.dae",
	"Assets/Levels/World/Models/CityBuildingParts/base3.dae",
	"Assets/Levels/World/Models/CityBuildingParts/base4.dae",
	"Assets/Levels/World/Models/CityBuildingParts/base5.dae"
}
largeBuildingBottoms = 5

largeBuildingMiddleFiles = {
	"Assets/Levels/World/Models/CityBuildingParts/middle1.dae",
	"Assets/Levels/World/Models/CityBuildingParts/middle2.dae",
	"Assets/Levels/World/Models/CityBuildingParts/middle3.dae",
	"Assets/Levels/World/Models/CityBuildingParts/middle4.dae"
}
largeBuildingMiddles = 4

smallBuildingModelFiles = {
	"Assets/Levels/World/Models/CityBuildingParts/small1.dae"
}

edgeBuildingFiles = {
	"Assets/Levels/World/Models/CityBuildingParts/City/edge1.dae"
}
edgeBuildings = 1

cornerBuildingFiles = {
	"Assets/Levels/World/Models/CityBuildingParts/City/corner1.dae"
}
cornerBuildings = 1

centerBuildingFiles = {
	"Assets/Levels/World/Models/CityBuildingParts/City/center.dae"
}
centerBuildings = 1
function generateCity(startx, starty, sizex, sizey, blockSize, buildingWidth)
local models = {}
local curIndex = 2
	for x=0, sizex, buildingWidth do
		for y=0, sizey, buildingWidth do
			if x>sizex then x=sizex end
			if y>sizey then y=sizey end
			local corner = 0
			if x%blockSize > 0 and y%blockSize > 0 then
			
				-- X-
				if (x-buildingWidth)%blockSize == 0 then
					if (y-buildingWidth)%blockSize == 0 then
						local tmpModels = {}
						tmpModels = createCorner((x*blockSize)+startx, 0, (y*blockSize)+starty, 180)
						models[curIndex] = tmpModels[1]
						curIndex = curIndex + 1
					elseif (y+buildingWidth)%blockSize == 0 then
						local tmpModels = {}
						tmpModels = createCorner((x*blockSize)+startx, 0, (y*blockSize)+starty, 270)
						models[curIndex] = tmpModels[1]
						curIndex = curIndex + 1
					else
						local tmpModels = {}
						tmpModels = createEdge((x*blockSize)+startx, 0, (y*blockSize)+starty, 180)
						models[curIndex] = tmpModels[1]
						curIndex = curIndex + 1
					end
				elseif (x+buildingWidth)%blockSize == 0 then
				-- X+
					if (y-buildingWidth)%blockSize == 0 then
						local tmpModels = {}
						tmpModels = createCorner((x*blockSize)+startx, 0, (y*blockSize)+starty, 90)
						models[curIndex] = tmpModels[1]
						curIndex = curIndex + 1
					elseif (y+buildingWidth)%blockSize == 0 then
						local tmpModels = {}
						tmpModels = createCorner((x*blockSize)+startx, 0, (y*blockSize)+starty, 0)
						models[curIndex] = tmpModels[1]
						curIndex = curIndex + 1
					else
						local tmpModels = {}
						tmpModels = createEdge((x*blockSize)+startx, 0, (y*blockSize)+starty, 0)
						models[curIndex] = tmpModels[1]
						curIndex = curIndex + 1
					end
				elseif (y-buildingWidth)%blockSize == 0 then
				-- Y-
					local tmpModels = {}
					tmpModels = createEdge((x*blockSize)+startx, 0, (y*blockSize)+starty, 90)
					models[curIndex] = tmpModels[1]
					curIndex = curIndex + 1
				elseif (y+buildingWidth)%blockSize == 0 then
				-- Y+
					local tmpModels = {}
					tmpModels = createEdge((x*blockSize)+startx, 0, (y*blockSize)+starty, 270)
					models[curIndex] = tmpModels[1]
					curIndex = curIndex + 1
				end
				--[[if x%sizex < sizex*0.3 or y%sizey < sizey*0.3 or x%sizex >sizex*0.7 or y%sizey > sizey*0.7 then
					local buildingType = (noise2(x/9000, y/9000)+1)*10
					if buildingType > 10 then
						local tmpModels = {}
						tmpModels = createLargeBuilding((x*blockSize)+startx, 0, (y*blockSize)+starty)
						models[curIndex] = tmpModels[1]
						models[curIndex+1] = tmpModels[2]
						curIndex = curIndex + 2
					else
						local tmpModels = {}
						tmpModels = createSmallBuilding((x*blockSize)+startx, 0, (y*blockSize)+starty)
						models[curIndex] = tmpModels[1]
						curIndex = curIndex + 1
					end
				else
					local tmpModels = {}
					tmpModels = createSmallBuilding((x*blockSize)+startx, 0, (y*blockSize)+starty)
					models[curIndex] = tmpModels[1]
					curIndex = curIndex + 1
				end]]--
				
			
			else
				if y > 0 and y < sizey and x > 0 and x < sizex then
					if x%blockSize == 0 and y%blockSize > 0 then
						local tmpModels = {}
						tmpModels = createRoad((x*blockSize)+startx, 0, (y*blockSize)+starty, 90)
						models[curIndex] = tmpModels[1]
						curIndex = curIndex + 1
					elseif x%blockSize == 0 and y%blockSize == 0 then
						local t1 = MainScene:addMesh("Assets/Levels/world/models/CityBuildingParts/road2.dae", (x*blockSize)+startx, 0, (y*blockSize)+starty, 0, 0, 0, 8, 10, 8)
						--MainScene:getMesh(t1):addCollider(MainScene, "MESH_GIMPACT", 0)
						--MainScene:getObject(t1):setMaterialTexture(MainScene, 1, "Assets/Levels/world/textures/Detail.jpg")
						MainScene:getObject(t1):useShader(MainScene, "Shaders/buildingShader.xml")
						models[curIndex] = t1
						curIndex = curIndex + 1
					elseif y%blockSize == 0 then
						local tmpModels = {}
						tmpModels = createRoad((x*blockSize)+startx, 0, (y*blockSize)+starty, 0)
						models[curIndex] = tmpModels[1]
						curIndex = curIndex + 1
					end
				end
			end
		end
	end
	models[1] = curIndex-1
	return models
end

function createLargeBuilding(x, y, z)
	local buildingBottom = noise2(x/9000, z/9000)+1
	local buildingMiddle = noise2(x/9000, 2*z/9000)+1
	local rotation = noise2(x/9000, 3*z/9000)+1
	rotation = rotation * 10
	rotation = math.floor(rotation%4)+1
	buildingBottom = buildingBottom * 10
	buildingMiddle = buildingMiddle * 10
	buildingBottom = math.floor(buildingBottom%largeBuildingBottoms)+1
	buildingMiddle = math.floor(buildingMiddle%largeBuildingMiddles)+1
	local t1 = MainScene:addMesh(largeBuildingBottomFiles[buildingBottom], x, 0, z, 0, rotation*90, 0, 8, 10, 8)
	local t2 = MainScene:addMesh(largeBuildingMiddleFiles[buildingMiddle], x, 0, z, 0, rotation*90, 0, 8, 10, 8)
	--MainScene:getMesh(t1):addCollider(MainScene, "MESH_TRIMESH", 0)
	MainScene:getObject(t1):setMaterial("solid")
	MainScene:getObject(t2):setMaterial("solid")
	MainScene:getObject(t1):setMaterialTexture(MainScene, 0, "Assets/Levels/world/textures/Building_texture.jpg")
	MainScene:getObject(t2):setMaterialTexture(MainScene, 0, "Assets/Levels/world/textures/Building_texture.jpg")
	MainScene:getObject(t1):useShader(MainScene, "Shaders/buildingShader.xml")
	MainScene:getObject(t2):useShader(MainScene, "Shaders/buildingShader.xml")
	local tmp = {}
	tmp[1] = t1
	tmp[2] = t2
	return tmp
end
function createSmallBuilding(x, y, z)
	local buildingBottom = noise2(x/9000, z/9000)+1
	local rotation = noise2(x/9000, 3*z/9000)+1
	rotation = rotation * 10
	rotation = math.floor(rotation%4)+1
	buildingBottom = buildingBottom * 10
	buildingBottom = math.floor(buildingBottom%largeBuildingBottoms)+1
	local t1 = MainScene:addMesh(largeBuildingBottomFiles[buildingBottom], x, 0, z, 0, rotation*90, 0, 8, 10, 8)
	--MainScene:getMesh(t1):addCollider(MainScene, "MESH_GIMPACT", 0)
	MainScene:getObject(t1):setMaterialTexture(MainScene, 1, "Assets/Levels/world/textures/Detail.jpg")
	MainScene:getObject(t1):useShader(MainScene, "Shaders/buildingShader.xml")
	local tmp = {}
	tmp[1] = t1
	tmp[2] = t2
	return tmp
end
function createCorner(x, y, z, ry)
	local t1 = MainScene:addMesh(cornerBuildingFiles[1], x, 0, z, 0, ry, 0, 13, 13, 13)
	--MainScene:getMesh(t1):addCollider(MainScene, "MESH_GIMPACT", 0)
	MainScene:getObject(t1):setMaterialTexture(MainScene, 1, "Assets/Levels/world/textures/Detail.jpg")
	MainScene:getObject(t1):useShader(MainScene, "Shaders/buildingShader.xml")
	local tmp = {}
	tmp[1] = t1
	tmp[2] = t2
	return tmp
end
function createEdge(x, y, z, ry)
	local t1 = MainScene:addMesh(edgeBuildingFiles[1], x, 0, z, 0, ry, 0, 13, 13, 13)
	--MainScene:getMesh(t1):addCollider(MainScene, "MESH_GIMPACT", 0)
	MainScene:getObject(t1):setMaterialTexture(MainScene, 1, "Assets/Levels/world/textures/Detail.jpg")
	MainScene:getObject(t1):useShader(MainScene, "Shaders/buildingShader.xml")
	local tmp = {}
	tmp[1] = t1
	tmp[2] = t2
	return tmp
end

function createCenter(x, y, z, ry)
	local t1 = MainScene:addMesh(centerBuildingFiles[1], x, 0, z, 0, ry, 0, 8, 10, 8)
	--MainScene:getMesh(t1):addCollider(MainScene, "MESH_GIMPACT", 0)
	MainScene:getObject(t1):setMaterialTexture(MainScene, 1, "Assets/Levels/world/textures/Detail.jpg")
	MainScene:getObject(t1):useShader(MainScene, "Shaders/buildingShader.xml")
	local tmp = {}
	tmp[1] = t1
	tmp[2] = t2
	return tmp
end

function createRoad(x, y, z, rot)
	local t1 = MainScene:addMesh("Assets/Levels/world/models/CityBuildingParts/road1.dae", x, 0, z, 0, rot, 0, 8, 10, 8)
	--MainScene:getMesh(t1):addCollider(MainScene, "MESH_GIMPACT", 0)
	--MainScene:getObject(t1):setMaterialTexture(MainScene, 1, "Assets/Levels/world/textures/Detail.jpg")
	MainScene:getObject(t1):useShader(MainScene, "Shaders/buildingShader.xml")
	local tmp = {}
	tmp[1] = t1
	return tmp
end
function bxor(a,b)
  local r = 0
  for i = 0, 31 do
    local x = a / 2 + b / 2
    if x ~= math.floor (x) then
      r = r + 2^i
    end
    a = math.floor (a / 2)
    b = math.floor (b / 2)
  end
  return r
end

function noise2(x, y)
	local n = x + y * 57
	n = bxor((n * 2^13), n);
	return ( 1.0 - ( (n * (n * n * 15731 + 789221) + 1376312589) % 2147483648) / 1073741824.0)
end
