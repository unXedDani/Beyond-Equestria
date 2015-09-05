function onSelect(selection)
	if selection == 0 then
		startMeshEditor()
	elseif selection == 1 then
		startAnimatedMeshEditor()
	elseif selection == 2 then
		startLightEditor()
	elseif selection == 3 then
		MainScene:addEmpty(0, 0, 0, 0, 0, 0, 1, 1, 1)
	elseif selection == 4 then
		startParticleEditor()
	else
	MainScene:SNLog("Invalid selection", selection)
	end
end
function onChange()

end
function startMeshEditor()
	--local window = MainScene:addWindow("Add Mesh", 100, 100, 200, 200, 0, "scripts/editor/emptyWindow.lua")
	local filebox = MainScene:addFileDiag("Select Mesh File", 0, "scripts/editor/addMesh.lua")
	--local filebox = MainScene:addEditBox("FILENAME...", 30, 30, 70, 50, 0, window, "scripts/editor/addMesh.lua")
end
function startAnimatedMeshEditor()
	--local window = MainScene:addWindow("Add Animated Mesh", 100, 100, 200, 200, 0, "scripts/editor/emptyWindow.lua")
	--local filebox = MainScene:addEditBox("FILENAME...", 20, 30, 90, 50, 0, window, "scripts/editor/addAnimatedMesh.lua")
	local filebox = MainScene:addFileDiag("Select Animated Mesh File", 0, "scripts/editor/addAnimatedMesh.lua")
end
function startParticleEditor()
	local filebox = MainScene:addFileDiag("Select Particle Image File", 0, "scripts/editor/addParticle.lua")
end
function startLightEditor()
	local window = MainScene:addWindow("Add Light", 100, 100, 200, 200, 0, "scripts/editor/emptyWindow.lua")
	local t1 = MainScene:addText("Light Type", 20, 20, 90, 30, window)
	local newOb = MainScene:addListBox(20, 30, 90, 80, window, "scripts/editor/addLight.lua")
	MainScene:addListItem("POINT", newOb)
	MainScene:addListItem("SPOT", newOb)
	MainScene:addListItem("DIRECITONAL", newOb)
end