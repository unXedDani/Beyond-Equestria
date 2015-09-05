function onClick()
	MainScene:getGUIObject(MainScene:getMetaData("EDITOR_REFRESH_ID")):removeElement()
	local list = MainScene:addListBox(10, 40, 190, 250, MainScene:getMetaData("EDITOR_WINDOW_ID"), "scripts/editor/listObjects.lua")
	MainScene:setMetaData("EDITOR_REFRESH_ID", list)
	local Objects = MainScene:Objects()
	MainScene:SNLog("Objects", Objects)
	if Objects > -1 then
		for i=0, Objects do
			if MainScene:getObject(i) ~= nil then
				local item = MainScene:addListItem(MainScene:getObject(i):getName().." ID:"..i, list)
				MainScene:getObject(i):setMetaData("GUIKEY", item)
			end
		end
	end
end