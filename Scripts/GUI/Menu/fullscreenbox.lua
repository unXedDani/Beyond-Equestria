function onChange(value)
	if value == 0 then
		MainScene:setConfigValue("fullscreen", 0)
	else
		MainScene:setConfigValue("fullscreen", 1)
	end
end