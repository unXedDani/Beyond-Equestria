BIOMES = 3
local function getBiome(x, y)
	math.randomseed(x+y)
	return math.floor(math.random(0, BIOMES))
end
function findPower(num)
	for i = 0, 16 do
		if num == math.pow(2, i) then
			return i
		end
	end
	return -1
end
function generateChunk(terrain, cx, cy, size)
	local chunk = {}
	local roughness = 0.7
	for i=1, size+1 do chunk[i]={} end
	for x=0, size do
		for y=0, size do
			chunk[x+1][y+1] = 0
		end
	end
	chunk[1][1] = noise2((cx*size),(cy*size))
	chunk[size+1][1] = noise2((cx*size+size),(cy*size))
	chunk[1][size+1] = noise2((cx*size),(cy*size+size))
	chunk[size+1][size+1] = noise2((cx*size+size),(cy*size+size))
	
	
	--chunk = divide(chunk, size+1, roughness)
	
	iter = 1
	half=size/2
	scale = roughness * size
	while iter==1 do
		half = half/2
		MainScene:SLog("TERRAINLOG"..half)
		if half < 1 then break end
		for y=half, size, size do
			for x=half, size, size do
				chunk = square(x, y, half, noise2(x+cx*size, y+cy*size)*scale * (2 - scale), chunk, size)
			end
		end
		for y=0, size, half do
			for x = (y+half)%size, size, size do
				chunk = diamond(x, y, half, noise2(x+cx*size, y+cy*size)*scale*(2-scale), chunk, size)
			end
		end
	end
	--[[for i = 0, tIter do
		for x=0, size do
			for y=0, size do
				local worldx = (cx*size+x)
				local worldy = (cy*size+y)
				--chunk[x+1][y+1] = 0
				chunk[x+1][y+1] = noise2(math.floor(worldx/(512)), math.floor(worldy/(512)))
				chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(64)), math.floor(worldy/(64)))
				chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(32)), math.floor(worldy/(32)))
				chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(16)), math.floor(worldy/(16)))
				chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(8)), math.floor(worldy/(8)))
				chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(4)), math.floor(worldy/(4)))
				chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(math.floor(worldx/(2)), math.floor(worldy/(2)))
				chunk[x+1][y+1] = chunk[x+1][y+1] + noise2(worldx, worldy)
				local river = math.sin(worldx/50)+math.sin(worldy/60)
				--if river > 1.5 then chunk[x+1][y+1] = -7 end
				if x>1 and y>1 and x < size and y < size then
					chunk[x+1][y+1] = interpolate(chunk[x][y], chunk[x+1][y+1], chunk[x][y])
					chunk[x+1][y+1] = interpolate(chunk[x][y], chunk[x+1][y+1], chunk[x][y])
				end]
			end
		end
	end]]--
	for x=0, size do
		for y=0, size do
			terrain:setHeightNoRebuild(x, y, chunk[x+1][y+1])
		end
	end
end
function diamond(x, y, size, offset, chunk, cSize)
	a = 0
	b = 0
	if x - size > 0 then a=a+chunk[x-size+1][y+1]; b=b+1 end
	if y - size > 0 then a=a+chunk[x+1][y-size+1]; b=b+1 end
	if x + size < cSize+1 then a=a+chunk[x+size+1][y+1]; b=b+1 end
	if y + size < cSize+1 then a=a+chunk[x+1][y+size+1]; b=b+1 end
	if b == 0 then return chunk end
	av = a / b
	chunk[x+1][y+1] = av + offset
	return chunk
end
function square(x, y, size, offset, chunk, cSize)
	a=0
	b=0
	if x-size > 0 and y-size > 0 then a=a+chunk[x-size+1][y-size+1]; b=b+1 end
	if x+size < cSize+1 and y-size > 0 then a=a+chunk[x+size+1][y-size+1]; b=b+1 end
	if x-size > 0 and y+size < cSize+1 then a=a+chunk[x-size+1][y+size+1]; b=b+1 end
	if x+size < cSize+1 and y+size < cSize+1 then a=a+chunk[x+size+1][y+size+1]; b=b+1 end
	if b == 0 then return chunk end
	av = a / b
	chunk[x+1][y+1] = av + offset
	return chunk
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
	--x = x%128
	--y = y%128 
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