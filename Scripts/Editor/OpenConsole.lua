MainScene:setMetaData("RUNNING_CONSOLE", 0)
function onClick()
	if MainScene:getMetaData("RUNNING_CONSOLE") == 0 then
		local window = MainScene:addWindow("Live Lua Console", 50, 50, 300, 110, 0, "scripts/editor/closeConsole.lua")
		local box = MainScene:addEditBox("Input lua...", 2, 20, 250, 40, 1, window, "scripts/editor/liveConsole.lua")
	end
end