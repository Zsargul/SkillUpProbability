local SkillUpProbability, core = ...
core.Config = {}

local Config = core.config

-- HELPER FUNCTIONS --
function core:Print(...)
	color = "cff00ccff"
	local prefix = string.format('\124' .. color .. "SkillUpProbability:" .. '\124r')
	DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, tostringall(...)))
end
