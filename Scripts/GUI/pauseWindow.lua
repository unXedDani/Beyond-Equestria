function onClose()
	MainScene:setMetaData("PAUSED", 0)
	local CameraState = MainScene:getMetaData("CameraToggleState")
	if CameraState == 1 then
		MainScene:setMouseVisibility(0)
	end
end