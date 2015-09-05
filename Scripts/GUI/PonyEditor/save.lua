function onClick()

	local body = MainScene:getMetaData("PLAYER_GENDER")
	local uppermane = MainScene:getMetaData("PLAYER_UPPER_MANE")
	local lowermane = MainScene:getMetaData("PLAYER_LOWER_MANE")
	local tail = MainScene:getMetaData("PLAYER_TAIL")
	local bodyR = MainScene:getMetaData("PLAYER_BODY_COLOR_R")
	local bodyG = MainScene:getMetaData("PLAYER_BODY_COLOR_G")
	local bodyB = MainScene:getMetaData("PLAYER_BODY_COLOR_B")
	
	local umane1R = MainScene:getMetaData("PLAYER_UMANE1_COLOR_R")
	local umane1G = MainScene:getMetaData("PLAYER_UMANE1_COLOR_G")
	local umane1B = MainScene:getMetaData("PLAYER_UMANE1_COLOR_B")
	
	local umane2R = MainScene:getMetaData("PLAYER_UMANE2_COLOR_R")
	local umane2G = MainScene:getMetaData("PLAYER_UMANE2_COLOR_G")
	local umane2B = MainScene:getMetaData("PLAYER_UMANE2_COLOR_B")
	local race = MainScene:getMetaData("PLAYER_RACE")
	
	MainScene:setConfigValue("HasCharacter", 1)
	MainScene:setConfigValue("CharacterGender", body)
	MainScene:setConfigValue("CharacterUpperMane", uppermane)
	MainScene:setConfigValue("CharacterLowerMane", lowermane)
	MainScene:setConfigValue("CharacterTail", tail)
	MainScene:setConfigValue("CharacterBodyR", bodyR)
	MainScene:setConfigValue("CharacterBodyG", bodyG)
	MainScene:setConfigValue("CharacterBodyB", bodyB)
	MainScene:setConfigValue("CharacterManeR1", umane1R)
	MainScene:setConfigValue("CharacterManeG1", umane1G)
	MainScene:setConfigValue("CharacterManeB1", umane1B)
	MainScene:setConfigValue("CharacterManeR2", umane2R)
	MainScene:setConfigValue("CharacterManeG2", umane2G)
	MainScene:setConfigValue("CharacterManeB2", umane2B)
	MainScene:setConfigValue("CharacterRace", race)
	MainScene:saveConfig("config.xml")
	
end