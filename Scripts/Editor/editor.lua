--EDITOR SCRIPT
MainScene:setMetaData("RUNNING_EDITOR", 0)
function promptEditor()
	MainScene:getMouseControl()
	MainScene:setMetaData("LAST_SELECTION_GUI", -1)
	if MainScene:getMetaData("RUNNING_EDITOR") == 0 then
		MainScene:setMetaData("RUNNING_EDITOR", 1)
		MainScene:setMetaData("PREVTIME", MainScene:getTimeScale())
		local window = MainScene:addWindow("Editor", 100, 100, 300, 500, 0, "scripts/editor/closeEditor.lua")
		local refBut = MainScene:addButton("Refresh", "Refreshs object list", 10, 20, 190, 40, window, "scripts/editor/refresh.lua")
		local newOb = MainScene:addListBox(10, 260, 190, 290, window, "scripts/editor/addObject.lua")
		MainScene:setMetaData("EDITOR_WINDOW_ID", window)
		MainScene:addListItem("MESH", newOb)
		MainScene:addListItem("ANIMATED MESH", newOb)
		MainScene:addListItem("LIGHT", newOb)
		MainScene:addListItem("EMPTY OBJECT", newOb)
		MainScene:addListItem("PARTICLE", newOb)
		
		local openConsole = MainScene:addButton("Open Console", "Opens the live lua console", 10, 300, 190, 330, window, "scripts/editor/OpenConsole.lua")
		local openLev = MainScene:addEditBox("Open Level...", 10, 340, 190, 360, 1, window, "scripts/editor/loadLevel.lua")
		local saveLev = MainScene:addEditBox("Save Level...", 10, 370, 190, 390, 1, window, "scripts/editor/saveLevel.lua")
		--MainScene:addSlider(1, 10, 80, 190, 100, window, "scripts/testscroll.lua")
		--MainScene:addEditBox("Type text...", 10, 110, 190, 130, 1, window, "scripts/testeditbox.lua")
		local list = MainScene:addListBox(10, 40, 190, 250, window, "scripts/editor/listObjects.lua")
		MainScene:setMetaData("EDITOR_REFRESH_ID", list)
		local Objects = MainScene:Objects()
		MainScene:SNLog("Objects", Objects)
		if Objects > 0 then
			for i=0, Objects do
				if MainScene:getObject(i) ~= nil then
					local item = MainScene:addListItem(MainScene:getObject(i):getName().." ID:"..i, list)
					MainScene:getObject(i):setMetaData("GUIKEY", item)
				end
			end
		end
	end
end
