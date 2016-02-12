BIOMES = 3
local function getBiome(x, y)
	math.randomseed(x+y)
	return math.floor(math.random(0, BIOMES))
end
function generateChunk(terrain, cx, cy, size)
	local chunk = {}
	for i=1, size+1 do chunk[i]={} end
	for x=0, size do
		for y=0, size do
			local worldx = (cx*size+x)
			local worldy = (cy*size+y)
			chunk[x+1][y+1] = noise2(math.floor(worldx/(128)), math.floor(worldy/(128)))*2
			chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(64)), math.floor(worldy/(64)))
			chunk[x+1][y+1] = chunk[x+1][y+1] * noise2(worldx, worldy)
			chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(32)), math.floor(worldy/(32)))
			chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(16)), math.floor(worldy/(16)))
			chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(8)), math.floor(worldy/(8)))
			chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(4)), math.floor(worldy/(4)))
			chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(2)), math.floor(worldy/(2)))
			chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(worldx, worldy)
		end
	end
	for x=0, size do
		for y=0, size do
			terrain:setHeightNoRebuild(x, y, chunk[x+1][y+1])
		end
	end
end
function generateChunk2(terrain, cX, cY, size, seed, heightFactor)
	local chunk = {}
	for i=1, size+1 do chunk[i]={} end
	--PASS 1
	for x=0, size do
		local x1 = 0
		if cx < 0 then
			x1 = x-(size*cX)
		else
			x1 = x+(size*cX)
		end
		for y=0, size do
			local y1 = 0
			if cY < 0 then
				y1 = y-(size*cY)
				--print(y.."-("..size.."*"..cY..")="..y1)
			else
				y1 = y+(size*cY)
				--print(y.."+("..size.."*"..cY..")="..y1)
			end
			chunk[x+1][y+1] = noise2((x1/100000), (y1/100000))*heightFactor
		end
	end
	--chunk = smoothingPassTable(chunk,size)
	--PASS 2
	for x=0, size do
		local x1 = 0
		if cx < 0 then
			x1 = x-(size*cX)
		else
			x1 = x+(size*cX)
		end
		for y=0, size do
			local y1 = 0
			if cY < 0 then
				y1 = y-(size*cY)
				--print(y.."-("..size.."*"..cY..")="..y1)
			else
				y1 = y+(size*cY)
				--print(y.."+("..size.."*"..cY..")="..y1)
			end
			chunk[x+1][y+1] = noise2(x1/9000, y1/9000)+chunk[x+1][y+1]
		end
	end
	local passes=2
	
	--chunk = smoothingPassTable(chunk,size)
	for x=0, size do
		for y=0, size do
			terrain:setHeightNoRebuild(x, y, chunk[x+1][y+1])
		end
	end
	
	
end
function smoothingPassTable(chunk, size)
	for x1=2, size do
		for y1=2, size do
			if x1 > 1 then
				chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1-1][y1], 0.5)
			end
			if y1 > 1 then
				chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1][y1-1], 0.5)
			end
			if x1 < size+1 then
				chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1+1][y1], 0.5)
			end
			if y1 < size+1 then
				chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1][y1+1], 0.5)
			end
		end
	end
	return chunk
end
function smoothingPassNoRebuild(terrain, size, passes)
	local chunk = {}
	for i=0, passes do
		for x1=1, size+1 do
			if i == 0 then chunk[x1]={} end
			for y1=1, size+1 do
				if i == 0 then chunk[x1][y1] = terrain:getHeight(x1-1, y1-1) end
				if x1 > 1 then
					chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1-1][y1], 0.5)
				end
				if y1 > 1 then
					chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1][y1-1], 0.5)
				end
				if x1 < size+1 and i > 0 then
					chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1+1][y1], 0.5)
				end
				if y1 < size+1 and i > 0 then
					chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1][y1+1], 0.5)
				end
				if i == passes-1 then terrain:setHeightNoRebuild(x1-1, y1-1, chunk[x1][y1]) end
			end
		end
	end
end
function bxor1(a,b)
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
	x = x%128
	y = y%128 
	local n = x + y * 57
	n = bxor1((n * 2^13), n);
	return ( 1.0 - ( (n * (n * n * 15731 + 789221) + 1376312589) % 2147483648) / 1073741824.0)
end

function interpolate(a, b, x)
	local ft = x*3.14159
	local f = (1-math.cos(ft))*0.5
	return a*(1-f)+b*f
end

function distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end