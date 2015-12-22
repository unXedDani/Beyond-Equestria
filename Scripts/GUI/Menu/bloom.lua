function onChange(value)
	if value == 0 then
		MainScene:setConfigValue("bloom", 0)
	else
		MainScene:setConfigValue("bloom", 1)
	end
end