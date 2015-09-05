--[[
function generateChunk( terrain, cX, cY, size, seed, heightFactor)
	local chunk = {}
	local passes = 4
	print "genning terrain"
	for i=1, size+3 do chunk[i]={} end
	for j=0, passes do
		for x1=1, size+3 do
			for y1=1, size+3 do
				if j == 0 then 
					chunk[x1][y1] = noise2(((x1+(cX*size))/9000), (y1+(cY*size))/9000)*heightFactor
				end
				
				if x1 > 1 then
					chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1-1][y1], 0.3)
				end
				if y1 > 1 then
					chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1][y1-1], 0.3)
				end
				if x1 < size+3 and j > 0 then
					chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1+1][y1], 0.3)
				end
				if y1 < size+3 and j > 0 then
					chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1][y1+1], 0.3)
				end
				if x1 > 2 and y1 > 2 and x1 < size+3 and y1 < size+3 then
					terrain:setHeightNoRebuild(x1-2, y1-2, chunk[x1][y1])
				end
			end
		end
	end
	terrain:rebuild()
	print("done")
end
]]--

function generateChunk(terrain, cX, cY, sizee, seed)
	local passes = 5
	local chunk = {}
	local size = sizee + 2
	for x=1, size*3 do
		chunk[x] = {}
		for y=1, size*3 do
			local heightFactor = noise2(10+cX + (math.floor(x/size+1)-1)/9000, 10+cY + (math.floor(y/size+1)-1)/9000) * 30
			if heightFactor < 1 then heightFactor = -heightFactor end
			local ccx = cX + (math.floor(x/(size+1))-1)
			local ccy = cY + (math.floor(y/(size+1))-1)
			chunk[x][y] = noise2((x+(ccx*size))/100000, (y+(ccy*size))/100000) * heightFactor
		end
	end
	for i=1, passes do
		for x=1, size*3 do
			for y=1, size*3 do
				if x > 1 then
					chunk[x][y] = interpolate(chunk[x][y], chunk[x-1][y], 0.3)
				end
				if y > 1 then
					chunk[x][y] = interpolate(chunk[x][y], chunk[x][y-1], 0.3)
				end
				if x < size*3 then
					chunk[x][y] = interpolate(chunk[x][y], chunk[x+1][y], 0.3)
				end
				if y < size*3 then
					chunk[x][y] = interpolate(chunk[x][y], chunk[x][y+1], 0.3)
				end
				if x > size and y > size and x < size*2 and y < size*2 then
					terrain:setHeightNoRebuild(x-size-1, y-size-1, chunk[x][y])
				end
			end
		end
	end
	terrain:rebuild()
end
function smoothingPassNoRebuild(terrain, size, passes)
	local chunk = {}
	for j=1, size do
		chunk[j]={}
	end
	for i=0, passes do
		for x1=1, size do
			for y1=1, size do
				if i==0 then
					chunk[x1][y1] = terrain:getHeight(x1, y1)
				else
					if x1 > 1 then
						chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1-1][y1], 0.2)
						
						if x1 < size and i > 0 then
							chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1+1][y1], 0.2)
						end
					end
					if y1 > 1 then
						chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1][y1-1], 0.2)
						if y1 < size and i > 0 then
							chunk[x1][y1] = interpolate(chunk[x1][y1], chunk[x1][y1+1], 0.2)
						end
					end
				end
				terrain:setHeightNoRebuild(x1-1, y1-1, chunk[x1][y1])
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

function interpolate(a, b, x)
	local ft = x*3.14159
	local f = (1-math.cos(ft))*0.5
	return a*(1-f)+b*f
end