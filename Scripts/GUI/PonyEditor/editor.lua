System_run("Scripts/GUI/PonyEditor/tables.lua", MainScene)
System_run("Scripts/defs.lua", MainScene)
function onClick()
	if(MainScene:getMetaData("PONY_EDITOR_IS_OPEN") ~= 1) then
		MainScene:setMetaData("PONY_EDITOR_IS_OPEN", 1)
		window = createWindow("Pony Editor", 100, 100, 440, 520, 0, "Scripts/GUI/PonyEditor/closeEditor.lua")
		MainScene:setMetaData("PONY_EDITOR_WINDOW_ID", window)
		MainScene:addButton("Apply", "Applies current settings", 220, 20, 270, 50, window, "Scripts/GUI/PonyEditor/apply.lua")
		MainScene:addButton("Save", "Saves current Character", 280, 20, 330, 50, window, "Scripts/GUI/PonyEditor/save.lua")
		--BODY GENDER--
		MainScene:addCheckbox(10, 30, 190, 50, 0, "Gender (Checked = male)", window, "Scripts/GUI/PonyEditor/gender.lua")
		
		--RACE--
		MainScene:addText("Race", 10, 50, 90, 70, window)
		raceBox = MainScene:addListBox(10, 70, 190, 140, window, "Scripts/GUI/PonyEditor/race.lua")
		for i=0, races-1 do
			MainScene:addListItem(raceNames[i+1], raceBox)
		end
		
		--MANES--
		MainScene:addText("Upper Mane", 10, 140, 90, 160, window)
		maneBox = MainScene:addListBox(10, 160, 190, 230, window, "Scripts/GUI/PonyEditor/mane.lua")
		MainScene:addListItem("None", maneBox)
		for i=0, upperManes-1 do
			MainScene:addListItem(upperManeNames[i+1], maneBox)
		end
		
		MainScene:addText("Lower Mane", 10, 230, 90, 250, window)
		maneBox1 = MainScene:addListBox(10, 250, 190, 320, window, "Scripts/GUI/PonyEditor/lowermane.lua")
		MainScene:addListItem("None", maneBox1)
		for i=0, lowerManes-1 do
			MainScene:addListItem(lowerManeNames[i+1], maneBox1)
		end
		
		--TAILS--
		MainScene:addText("Tail", 10, 320, 40, 340, window)
		tailBox = MainScene:addListBox(10, 340, 190, 410, window, "Scripts/GUI/PonyEditor/tail.lua")
		local x = MainScene:addListItem("None", tailBox)
		for i=0, tails-1 do
			MainScene:addListItem(tailNames[i+1], tailBox)
		end
		
		--BodyColor--
		MainScene:addText("Body Color (R, G, B)", 200, 60, 330, 80, window)
		MainScene:addSlider(1, 200, 80, 330, 90, window, "Scripts/GUI/PonyEditor/bodyColorr.lua")
		MainScene:addSlider(1, 200, 100, 330, 110, window, "Scripts/GUI/PonyEditor/bodyColorg.lua")
		MainScene:addSlider(1, 200, 120, 330, 130, window, "Scripts/GUI/PonyEditor/bodyColorb.lua")
		
		--UManeColor1
		MainScene:addText("Hair Color 1 (R, G, B)", 200, 150, 330, 170, window)
		MainScene:addSlider(1, 200, 170, 330, 180, window, "Scripts/GUI/PonyEditor/umanecolorR1.lua")
		MainScene:addSlider(1, 200, 190, 330, 200, window, "Scripts/GUI/PonyEditor/umanecolorG1.lua")
		MainScene:addSlider(1, 200, 210, 330, 220, window, "Scripts/GUI/PonyEditor/umanecolorB1.lua")
		
		--UManeColor2
		MainScene:addText("Hair Color 2 (R, G, B)", 200, 240, 190, 260, window)
		MainScene:addSlider(1, 200, 260, 330, 270, window, "Scripts/GUI/PonyEditor/umanecolorR2.lua")
		MainScene:addSlider(1, 200, 280, 330, 290, window, "Scripts/GUI/PonyEditor/umanecolorG2.lua")
		MainScene:addSlider(1, 200, 300, 330, 310, window, "Scripts/GUI/PonyEditor/umanecolorB2.lua")
		
	MainScene:setMetaData("PLAYER_GENDER", 0)
	MainScene:setMetaData("PLAYER_UPPER_MANE", 0)
	MainScene:setMetaData("PLAYER_LOWER_MANE", 0)
	MainScene:setMetaData("PLAYER_TAIL", 0)
	MainScene:setMetaData("PLAYER_BODY_COLOR_R", 0)
	MainScene:setMetaData("PLAYER_BODY_COLOR_G", 0)
	MainScene:setMetaData("PLAYER_BODY_COLOR_B", 0)
	MainScene:setMetaData("PLAYER_UMANE1_COLOR_R", 0)
	MainScene:setMetaData("PLAYER_UMANE1_COLOR_G" ,0)
	MainScene:setMetaData("PLAYER_UMANE1_COLOR_B", 0)
	MainScene:setMetaData("PLAYER_UMANE2_COLOR_R", 0)
	MainScene:setMetaData("PLAYER_UMANE2_COLOR_G", 0)
	MainScene:setMetaData("PLAYER_UMANE2_COLOR_B", 0)
	
	end
end