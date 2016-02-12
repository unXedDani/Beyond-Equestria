function initPause()
	local p = MainScene:getMetaData("PAUSED")
	if p ~= 1 then
		local x = MainScene:getConfigValue("width")/2
		local y = MainScene:getConfigValue("height")/2
		local window = createWindow("Paused", x-85, y-100, x+85, y+100, 0, "Scripts/GUI/pauseWindow.lua")
		local oButton = MainScene:addButton("", "Opens options window", 20, 30, 150, 60, window, "Scripts/GUI/Menu/optionsbutton.lua")
		MainScene:addImage(0, 0, 130, 30, "Assets/Levels/menu/textures/button.jpg", oButton)
		MainScene:addText("Options", 10, 5, 120, 25, oButton)
		local exitButton = MainScene:addButton("", "Exits the game", 20, 70, 150, 100, window, "Scripts/GUI/Menu/quit.lua")
		MainScene:addImage(0, 0, 130, 30, "Assets/Levels/menu/textures/button.jpg", exitButton)
		MainScene:addText("Exit to Desktop", 10, 5, 120, 25, exitButton)
		local editorButton = MainScene:addButton("", "Opens Pony Editor", 20, 110, 150, 140, window, "Scripts/GUI/PonyEditor/editor.lua")
		MainScene:addImage(0, 0, 130, 30, "Assets/Levels/menu/textures/button.jpg", editorButton)
		MainScene:addText("Open Editor", 10, 5, 120, 25, editorButton)
		MainScene:getGUIObject(oButton):drawBorder(0)
		MainScene:getGUIObject(exitButton):drawBorder(0)
		MainScene:getGUIObject(editorButton):drawBorder(0)
		p=1
	end
	MainScene:setMetaData("PAUSED", p)
	MainScene:setMouseVisibility(1)
end
