function onChange(value)
	if value == 0 then
		MainScene:setConfigValue("poster", 0)
	else
		MainScene:setConfigValue("poster", 1)
	end
end