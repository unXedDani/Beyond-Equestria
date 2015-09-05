function menuInit()
	local centerX = MainScene:getConfigValue("width")/2
	local centerY = MainScene:getConfigValue("height")/2
	local width = MainScene:getConfigValue("width")
	local height = MainScene:getConfigValue("height")
	MainScene:setMetaData("PLAYER_BODY_SPAWNED", 0)
	MainScene:setMetaData("PLAYER_MANE_SPAWNED", 0)
	MainScene:setMetaData("PLAYER_TAIL_SPAWNED", 0)
	MainScene:setMetaData("PLAYER_HORN_SPAWNED", 0)
	MainScene:setMetaData("PLAYER_BODY_ID", 0)
	MainScene:setMetaData("PLAYER_MANE_ID", 0)
	MainScene:setMetaData("PLAYER_TAIL_ID", 0)
	MainScene:setMetaData("PLAYER_HORN_ID", 0)
	MainScene:setMetaData("PLAYER_ID", -1)
	MainScene:setGUIFont("Assets/Levels/menu/textures/ponyFont.xml")
	MainScene:setGUIColor(200, 0, 0, 0)
	MainScene:setGUITextColor(255, 255, 255, 255)
	MainScene:addImage(0, 0, width, height, "Assets/Levels/world/textures/background.jpg", 0)
	local startbut = MainScene:addButton("", "Starts the game", centerX - 70, centerY - 100, centerX + 70, centerY - 40, 0, "Scripts/GUI/Menu/start.lua")
	--MainScene:getGUIObject(startbut):setImage(MainScene, "Assets/Levels/menu/textures/button.jpg", 0, 0, 100, 20)
	MainScene:addImage(0, 0, 140, 40, "Assets/Levels/menu/textures/button.jpg", startbut)
	MainScene:addImage(0, 10, 140, 40, "Assets/Levels/menu/textures/start.png", startbut)
	MainScene:getGUIObject(startbut):drawBorder(0)
	--MainScene:addButton("Open Pony Editor", "Opens Pony Editor", centerX - 50, centerY - 60, centerX + 50, centerY - 40, 0, "Scripts/GUI/PonyEditor/editor.lua")
	local opbut = MainScene:addButton("", "Opens options window", centerX - 50, centerY - 30, centerX + 50, centerY, 0, "Scripts/GUI/Menu/optionsbutton.lua")
	MainScene:addImage(0, 0, 100, 30, "Assets/Levels/menu/textures/button.jpg", opbut)
	MainScene:addImage(0, 10, 100, 30, "Assets/Levels/menu/textures/options.png", opbut)
	MainScene:getGUIObject(opbut):drawBorder(0)
	local quitbut = MainScene:addButton("", "Exits the game", centerX - 50, centerY, centerX + 50, centerY + 30, 0, "Scripts/GUI/Menu/quit.lua")
	MainScene:addImage(0, 0, 100, 30, "Assets/Levels/menu/textures/button.jpg", quitbut)
	MainScene:addImage(0, 10, 100, 30, "Assets/Levels/menu/textures/quit.png", quitbut)
	MainScene:getGUIObject(quitbut):drawBorder(0)
	MainScene:addImage(0, 0, 80, 80, "Assets/Levels/menu/textures/jcamlogo.png", 0)
	MainScene:addImage(width - 200, 0, width, 80, "Assets/Levels/menu/textures/foxclawlogo.png", 0)
	MainScene:addImage(centerX - 379, 50, centerX+379, 292, "Assets/Levels/menu/textures/logo.jpg", 0)
	
	cx, cy, cz = MainScene:getCamera():getPosition()
	s = MainScene:addSound("Assets/Levels/menu/music/atop the trees.wav", cx, cy, cz, 0)
	MainScene:getSound(s):setVolume(MainScene:getConfigValue("music_volume"))
	MainScene:addEditBox("Username...", centerX - 70, centerY - 120, centerX + 70, centerY - 100, 1, 0, "Scripts/GUI/Chat/setName.lua")
end
local overlay = 0
function menuUpdate()
	local width = MainScene:getConfigValue("width")
	local height = MainScene:getConfigValue("height")
	local mx, my = MainScene:getMousePosition()
	
	if mx > width-200 and mx < width then
		if my > 0 and my < 80 then
			if overlay == 0 then
				MainScene:addImage(width - 200, 0, width, 80, "Assets/Levels/menu/textures/overlay.png", 0)
				overlay = 1
			end
		end
	end
	
	MainScene:getSound(s):setVolume(MainScene:getConfigValue("music_volume"))
end

function menuRender()

end