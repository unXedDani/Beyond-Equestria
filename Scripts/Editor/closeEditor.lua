function onClose()
	MainScene:setMetaData("RUNNING_EDITOR", 0)
	MainScene:setTimeScale(MainScene:getMetaData("PREVTIME"))
	MainScene:giveMouseControl()
end