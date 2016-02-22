while MainScene:getMetaData("GAMESTATE") == 1 do
	curTime = curTime + MainScene:deltaTime()
	if curTime > 500 then
		tx, ty, tz = MainScene:getObject(playerCollider):getPosition()
		if GENTERRAIN == 0 then updateChunks(tx/terrainScale, tz/terrainScale, chunksize, terrainScale) end
		curTime = 0
	end
end