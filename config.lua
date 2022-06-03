local SkillUpProbability, core = ...
core.Config = {}

local Config = core.config

-- Print with color
function core:Print(...)
	color = "cff00ccff"
	local prefix = string.format('\124' .. color .. "SkillUpProbability:" .. '\124r')
	DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, tostringall(...)))
end

-- Get number of available trade skills (without headers)
function core:GetTradeSkillsHeaderless(...)
	local skillName, skillType
	for i=1, GetNumTradeSkills() do
		skillName, skillType, _, _, _, _ = GetTradeSkillInfo(i)
		if (skillName and skillTyoe ~= "header") then
			core:Print("Skill: "..skillName.." Dif: "..skillType)
		end
	end
end
