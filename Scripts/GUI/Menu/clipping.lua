function onScroll(val)
	MainScene:setConfigValue("Clipping", (val/100)*5000)
end	