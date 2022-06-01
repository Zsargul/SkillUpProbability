local SkillUpProbability, SUP = ...
SUP.Config = {}

local Config = SUP.config

local window = {
	xOffset = 10,
	yOffset = 10
}

-- Allows usage of arrow keys in edit box without rotating character
for i = 1, NUM_CHAT_WINDOWS do
	_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
end
