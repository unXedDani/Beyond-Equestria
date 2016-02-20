function populateWithTrees(density, chunksize, terrainScale, terrain)
	print("Populating with trees")
	for x=1, chunksize do
		for y=1, chunksize do
			local curHeight = terrain:getHeight(x, y)
			local curGen = -noise2((x*curHeight+1)/100, (y*curHeight+1))/100 * 10000
			print(curGen)
			if curGen > 0 and curGen < density then
				MainScene:addMesh("Assets/Levels/world/models/trees/CartoonTree.obj", x*terrainScale, curHeight, y*terrainScale, 0, 0, 0, 50, 50, 50)
			end
		end
	end
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