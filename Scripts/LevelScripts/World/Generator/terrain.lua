BIOMES = 3
function generateChunk1( terrain, cX, cY, size, seed, heightFactor)
	local chunk = {}
	local passes = 7
	for i=1, size+1 do chunk[i]={} end
	for j=0, passes do
		for x1=1, size+1 do
			for y1=1, size+1 do
				if j == 0 then 
					local center = (size)/2

					chunk[x1][y1] = noise2((x1+(cX*size))/(9000+seed), (y1+(cY*size))/(9000+seed))*heightFactor
					--chunk[x1][y1] = noise2((((x1+cX)*size-seed+seed)/90000), ((y1+cY)*size+seed)/90000)*heightFactor
				end
				
				if x1 > 1 then
					chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1-1][y1], 0.3)
				end
				if y1 > 1 then
					chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1][y1-1], 0.3)
				end
				terrain:setHeightNoRebuild(x1-1, y1-1, chunk[x1][y1])
			end
		end
	end
	terrain:rebuild()
	print("done")
end


local function getBiome(x, y)
	math.randomseed(x+y)
	return math.floor(math.random(0, BIOMES))
end

function generateChunk(terrain, cX, cY, size, seed, heightFactor)
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
			chunk[x+1][y+1] = noise2(x1/9000, y1/9000)*chunk[x+1][y+1]
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
	for x1=1, size+1 do
		for y1=1, size+1 do
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