function onChange(value)
	if value == 0 then
		MainScene:setConfigValue("vsync", 0)
	else
		MainScene:setConfigValue("vsync", 1)
	end
end