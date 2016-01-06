function onSelect(selection)
end
function onChange(selection)
	local widths = {800, 1024, 1280, 1600, 1024, 1280, 1366, 1600, 1920, 1280, 1440, 1680, 1920}
	local heights = {600, 768, 960, 1200, 576, 720, 768, 900, 1080, 800, 900, 1050, 1200}
	MainScene:setConfigValue("height", heights[selection+1])
	MainScene:setConfigValue("width", widths[selection+1])
end