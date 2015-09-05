function onChange(value)
	if value == 0 then
		MainScene:setConfigValue("postfx", 0)
	else
		MainScene:setConfigValue("postfx", 1)
	end
end