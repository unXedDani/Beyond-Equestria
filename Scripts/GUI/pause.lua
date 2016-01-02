function initPause()
	local p = MainScene:getMetaData("PAUSED")
	if p ~= 1 then
		local x = MainScene:getConfigValue("width")/2
		local y = MainScene:getConfigValue("height")/2
		local window = createWindow("Paused", x-85, y-100, x+85, y+100, 0, "Scripts/GUI/pauseWindow.lua")
		MainScene:addButton("Options", "Opens options window", 20, 30, 150, 60, window, "Scripts/GUI/Menu/optionsbutton.lua")
		MainScene:addButton("Exit to desktop", "Exits the game", 20, 70, 150, 100, window, "Scripts/GUI/Menu/quit.lua")
		MainScene:addButton("Open Pony Editor", "Opens Pony Editor", 20, 110, 150, 140, window, "Scripts/GUI/PonyEditor/editor.lua")
		p=1
	end
	MainScene:setMetaData("PAUSED", p)
	MainScene:setMouseVisibility(1)
end
