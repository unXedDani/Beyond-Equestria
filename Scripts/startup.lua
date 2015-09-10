version = "0.1.0"
System_run("scripts/Editor/editor.lua", MainScene)
System_run("scripts/defs.lua", MainScene)
System_run("scripts/LevelScripts/World/Generator/terrain.lua", MainScene)
System_run("scripts/LevelScripts/World/Generator/terrainManager.lua", MainScene)
System_run("scripts/LevelScripts/Menu/menu.lua", MainScene)
System_run("scripts/LevelScripts/World/game.lua", MainScene)
System_run("scripts/GUI/PonyEditor/util.lua", MainScene)
System_run("scripts/GUI/pause.lua", MainScene)
MainScene:setDebug(2)
MainScene:setPhysicsDebug(0)

chunksize = 32
terrainScale = 32
playerCam = 0
testx = 0
testy = 0

GameState = 0

postFX = 0
function init()
	MainScene:SLog("Launching Beyond Equestria "..version)
	MainScene:addCamera(1)
	menuInit()
	MainScene:setMetaData("GAMESTATE", GameState)
	postFX = MainScene:getConfigValue("postfx")
	MainScene:setMetaData("GAMESTATECHANGED", 0)
	MainScene:setMetaData("NETRUNNING", 0)
	for chunkx = -10, 10 do
		for chunky = -10, 10 do
			local heightFactor = noise2((chunkx)/8000, (chunky)/8000) * 50
			heightFactor = interpolate(heightFactor, noise2((chunkx-1)/8000, (chunky)/8000) * 50, 0.1)
			heightFactor = interpolate(heightFactor, noise2((chunkx+1)/8000, (chunky)/8000) * 50, 0.1)
			heightFactor = interpolate(heightFactor, noise2((chunkx)/8000, (chunky-1)/8000) * 50, 0.1)
			heightFactor = interpolate(heightFactor, noise2((chunkx)/8000, (chunky+1)/8000) * 50, 0.1)
			if heightFactor < 1 then heightFactor = -heightFactor end
			if heightFactor < 2 then
				MainScene:SLog("City at"..chunkx.."_"..chunky)
			end
		end
	end
end

function update()
	if MainScene:getMetaData("NETRUNNING") == 1 then
		MainScene:updateNet()
	end
	if(MainScene:getKey(KEY_OEM_3) == 1) then
		promptEditor()
	end
	GameState = MainScene:getMetaData("GAMESTATE")
	postFX = MainScene:getConfigValue("postfx")
	if MainScene:getMetaData("GAMESTATECHANGED") == 1 then
		if GameState == 1 then
			gameInit()
		end
		MainScene:setMetaData("GAMESTATECHANGED", 0)
	end
	if GameState == 0 then
		menuUpdate()
	elseif GameState == 1 then
		gameUpdate()
	end
end
function render()
	if postFX == 1 then
		MainScene:RenderEffect(5)
		MainScene:RenderEffect(24)
	end
end