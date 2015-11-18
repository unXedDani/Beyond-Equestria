GENTERRAIN = 1
function gameInit()

	MainScene:addCamera(2)
	MainScene:getCamera():setClipping(1, MainScene:getConfigValue("Clipping"))
	--MainScene:createCharacter( 2, 5, 3)
	--MainScene:modifyCharacter("warp", 500, 10, 500)
	MainScene:load("Empty.xml")
	if GENTERRAIN == 0 then
		MainScene:load("debug.xml")
	end
	playerCam = MainScene:addEmpty(0, -0.7, 0, 0, 0, 0, 0.2, 0.1, 0.1)
	if GENTERRAIN == 1 then
		playerCollider = MainScene:addEmpty(4600, 10, 1530, 0, 0, 0, 1, 2, 2)
	else
		playerCollider = MainScene:addEmpty(0, 10, 0, 0, 0, 0, 1, 2, 2)
	end
	MainScene:getEmpty(playerCollider):addCollider(MainScene, "SPHERE", 50)
	
	MainScene:getObject(playerCollider):getCollider():setFriction(200)
	MainScene:getObject(playerCollider):getCollider():setDamping(0.1, 5)
	MainScene:getObject(playerCollider):getCollider():setLocal(1)
	MainScene:getObject(playerCam):attachTo(MainScene:getObject(playerCollider))
	MainScene:getObject(playerCam):setName("PLAYERCAMTARGET")
	MainScene:getObject(playerCollider):setName("PLAYERCOLLIDER")
	MainScene:getCamera():setTarget(MainScene:getObject(playerCollider))
	MainScene:getCamera():setOffset(0, 2, 0)
	generatePlayer()
	local t = MainScene:getMetaData("PLAYER_BODY_ID")
	--MainScene:modifyCharacter("jumpheight", 5)
	--MainScene:modifyCharacter("jumpforce", 30)
	--MainScene:modifyCharacter("fallspeed", 20)
	MainScene:clearGUI()
	local win = createWindow("Chat", 0, 0, 300, 210, 0, "Scripts/GUI/Chat/chatWindow.lua")
	local mes = MainScene:addListBox(10, 30, 290, 160, win, "Scripts/GUI/Chat/messageBox.lua")
	MainScene:getGUIObject(mes):setAutoscroll(1)
	MainScene:setMetaData("CHATMESSAGEBOX", mes)
	MainScene:addEditBox("", 10, 160, 290, 180, 1, win, "Scripts/GUI/Chat/sendMessage.lua")
end
anim = 0
updateCycle = 0
updateOn = 1000
firstRun = 0
curTime = 500

function gameUpdate()
	--MainScene:getObject(playerCam):setPosition(MainScene:characterData("posX"), MainScene:characterData("posY")-2, MainScene:characterData("posZ"))
	if(MainScene:getKey(KEY_ESCAPE) == 1) then
		initPause()
	end
	local DirX = 0
	local DirZ = 0
	local sprint = 0
	if MainScene:getKey(KEY_KEY_W) == 1 then
		DirZ = -1.0
	end
	if MainScene:getKey(KEY_KEY_S) == 1 then
		DirZ = 1.0
	end
	if MainScene:getKey(KEY_KEY_A) == 1 then
		DirX = 1.0
	end
	if MainScene:getKey(KEY_KEY_D) == 1 then
		DirX = -1.0
	end
	if MainScene:getKey(KEY_LSHIFT) == 1 then
		sprint = 2
	end
	if MainScene:getKey(KEY_SPACE) == 1 then
		MainScene:getObject(playerCollider):getCollider():addCentralForce(0, 1000, 0)
	end
	local cX, cY, cZ = MainScene:getCamera():getRotation()
	if DirX ~= 0 or DirZ ~= 0 then
		MainScene:getObject(playerCollider):getCollider():setState("ACTIVE")
		--MainScene:getObject(playerCam):setRotation(0, cY-180, 0)
		if anim~=1 and sprint == 0 then
			MainScene:getBoneAnimatedMesh(MainScene:getMetaData("PLAYER_BODY_ID")):setSpeed(60)
			MainScene:getBoneAnimatedMesh(MainScene:getMetaData("PLAYER_BODY_ID")):setFrameLoop(1, 60)
			MainScene:getBoneAnimatedMesh(MainScene:getMetaData("PLAYER_BODY_ID")):setAnimation("walk")
			anim = 1
		elseif anim ~= 2 and sprint > 0 then
			MainScene:getBoneAnimatedMesh(MainScene:getMetaData("PLAYER_BODY_ID")):setSpeed(120)
			MainScene:getBoneAnimatedMesh(MainScene:getMetaData("PLAYER_BODY_ID")):setFrameLoop(1, 60)
			MainScene:getBoneAnimatedMesh(MainScene:getMetaData("PLAYER_BODY_ID")):setAnimation("trot")
			anim = 2
		end
		MainScene:getObject(playerCollider):setRotation(0, cY-180, 0)
		MainScene:getObject(playerCollider):getCollider():setVelocity((DirX * (sprint+1))*15, -5, (DirZ * (sprint+1))*15)
		local p = MainScene:createPacket()
		p:writeNumber(3)
		p:writeNumber(MainScene:getMetaData("PLAYER_ID"))
		local px, py, pz = MainScene:getObject(playerCollider):getPosition()
		p:writeNumber(px)
		p:writeNumber(py-2)
		p:writeNumber(pz)
		MainScene:sendPacket(p, MainScene:getMetaString("SERVERCOMBINEDIP"))
		
		local pa = MainScene:createPacket()
		pa:writeNumber(7)
		pa:writeNumber(MainScene:getMetaData("PLAYER_ID"))
		local prx, pry, prz = MainScene:getObject(playerCollider):getRotation()
		pa:writeNumber(prx)
		pa:writeNumber(pry)
		pa:writeNumber(prz)
		MainScene:sendPacket(pa, MainScene:getMetaString("SERVERCOMBINEDIP"))
	else
		if anim > 0 then
			MainScene:getBoneAnimatedMesh(MainScene:getMetaData("PLAYER_BODY_ID")):setAnimation("idle")
			anim = 0
			MainScene:getBoneAnimatedMesh(MainScene:getMetaData("PLAYER_BODY_ID")):setSpeed(10)
			MainScene:getBoneAnimatedMesh(MainScene:getMetaData("PLAYER_BODY_ID")):setFrameLoop(1, 200)
			MainScene:getObject(playerCollider):getCollider():setVelocity(0, 0, 0)
		end
		local trx, try, trz = MainScene:getObject(playerCollider):getRotation()
		MainScene:getObject(playerCollider):setRotation(0, try, 0)
	--MainScene:moveCharacter(DirX*(sprint+1), 0, DirZ*(sprint+1), 0, cY - 180, 0, 0.1)
	end
	curTime = curTime + MainScene:deltaTime()
	if curTime > 500 then
		tx, ty, tz = MainScene:getObject(playerCollider):getPosition()
		if GENTERRAIN == 1 then updateChunks(tx/terrainScale, tz/terrainScale, chunksize, terrainScale) end
		curTime = 0
	end
	
	updateCycle =  updateCycle + MainScene:deltaTime()
	if updateCycle >= updateOn then
		updateCycle = 0
		
		local p = MainScene:createPacket()
		p:writeNumber(3)
		p:writeNumber(MainScene:getMetaData("PLAYER_ID"))
		local px, py, pz = MainScene:getObject(playerCollider):getPosition()
		p:writeNumber(px)
		p:writeNumber(py-2)
		p:writeNumber(pz)
		MainScene:sendPacket(p, MainScene:getMetaString("SERVERCOMBINEDIP"))
		
		local pa = MainScene:createPacket()
		pa:writeNumber(7)
		pa:writeNumber(MainScene:getMetaData("PLAYER_ID"))
		local prx, pry, prz = MainScene:getObject(playerCollider):getRotation()
		pa:writeNumber(prx)
		pa:writeNumber(pry)
		pa:writeNumber(prz)
		MainScene:sendPacket(pa, MainScene:getMetaString("SERVERCOMBINEDIP"))
	end
	if firstRun == 0 then
		local pack = MainScene:createPacket()
		pack:writeNumber(1)
		pack:writeString(MainScene:getMetaString("PLAYER_NAME"))
		MainScene:sendPacket(pack, MainScene:getMetaString("SERVERCOMBINEDIP"))
		local body = MainScene:getConfigValue("CharacterGender")
		local uppermane = MainScene:getConfigValue("CharacterUpperMane")
		local lowermane = MainScene:getConfigValue("CharacterLowerMane")
		local tail = MainScene:getConfigValue("CharacterTail")
		local bodyR = MainScene:getConfigValue("CharacterBodyR")
		local bodyG = MainScene:getConfigValue("CharacterBodyG")
		local bodyB = MainScene:getConfigValue("CharacterBodyB")
		
		local umane1R = MainScene:getConfigValue("CharacterManeR1")
		local umane1G = MainScene:getConfigValue("CharacterManeG1")
		local umane1B = MainScene:getConfigValue("CharacterManeB1")
		
		local umane2R = MainScene:getConfigValue("CharacterManeR2")
		local umane2G = MainScene:getConfigValue("CharacterManeG2")
		local umane2B = MainScene:getConfigValue("CharacterManeB2")
		local race = MainScene:getConfigValue("CharacterRace")
		local pack1 = MainScene:createPacket()
		pack1:writeNumber(4)
		pack1:writeNumber(-1)
		pack1:writeString(MainScene:getMetaString("PLAYER_NAME"))
		pack1:writeNumber(body)
		pack1:writeNumber(uppermane)
		pack1:writeNumber(lowermane)
		pack1:writeNumber(tail)
		pack1:writeNumber(bodyR)
		pack1:writeNumber(bodyG)
		pack1:writeNumber(bodyB)
		pack1:writeNumber(umane1R)
		pack1:writeNumber(umane1G)
		pack1:writeNumber(umane1B)
		pack1:writeNumber(umane2R)
		pack1:writeNumber(umane2G)
		pack1:writeNumber(umane2B)
		pack1:writeNumber(race)
		MainScene:sendPacket(pack1, MainScene:getMetaString("SERVERCOMBINEDIP"))
		
		firstRun = 1
	end
end

function gameRender()

end

function distance(x1, y1, x2, y2)
	local xd = x2-x1
	local yd = y2-y1
	return math.sqrt(xd*xd+yd*yd)
end