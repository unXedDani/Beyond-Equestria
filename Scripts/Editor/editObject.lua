function createMeshEditor(selection)
	local x, y, z = MainScene:getObject(selection):getPosition()
	local window = MainScene:addWindow(MainScene:getObject(selection):getName(), 100, 100, 300, 300, 0, "scripts/editor/editMesh.lua")
	local boxx = MainScene:addEditBox(x, 20, 30, 90, 50, 1, window, "scripts/editor/modifyX.lua")
	local boxy = MainScene:addEditBox(y, 20, 50, 90, 70, 1, window, "scripts/editor/modifyY.lua")
	local boxz = MainScene:addEditBox(z, 20, 70, 90, 90, 1, window, "scripts/editor/modifyZ.lua")
end