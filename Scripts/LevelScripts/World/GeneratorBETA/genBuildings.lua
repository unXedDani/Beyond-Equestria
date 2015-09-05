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
function generateCity(startx, starty, sizex, sizey, blockSize, buildingWidth)
local models = {}
local curIndex = 2
	for x=0, sizex, buildingWidth do
		for y=0, sizey, buildingWidth do
			if x>sizex then x=sizex end
			if y>sizey then y=sizey end
			
			if x%blockSize > 0 and y%blockSize > 0 then
				--Generate Buildings
				--MainScene:addMesh(SmallBuildingFiles[2], (x*blockSize)+startx, 0, (y*blockSize)+starty, 0, 0, 0, 30, 30, 30)
				local tmpModels = {}
				tmpModels = createLargeBuilding((x*blockSize)+startx, 0, (y*blockSize)+starty)
				models[curIndex] = tmpModels[1]
				models[curIndex+1] = tmpModels[2]
				curIndex = curIndex + 2
			else
				--Generate Roads
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
	local t1 = MainScene:addMesh(largeBuildingBottomFiles[buildingBottom], x, 0, z, 0, rotation*90, 0, 10, 10, 10)
	local t2 = MainScene:addMesh(largeBuildingMiddleFiles[buildingMiddle], x, 0, z, 0, rotation*90, 0, 10, 10, 10)
	--MainScene:getObject(t1):setMaterialTexture(MainScene, 0, "Assets/Levels/World/Textures/building_texture.jpg")
	--MainScene:getObject(t2):setMaterialTexture(MainScene, 0, "Assets/Levels/World/Textures/building_texture.jpg")
	MainScene:getMesh(t1):addCollider(MainScene, "MESH_GIMPACT", 0)
	MainScene:getObject(t1):useShader(MainScene, "Shaders/buildingShader.xml")
	MainScene:getObject(t2):useShader(MainScene, "Shaders/buildingShader.xml")
	local tmp = {}
	tmp[1] = t1
	tmp[2] = t2
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
