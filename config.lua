local SkillUpProbability, core = ...
core.Config = {}

local Config = core.config

-- Print with color
function core:Print(...)
	color = "cff00ccff"
	local prefix = string.format('\124' .. color .. "SkillUpProbability:" .. '\124r')
	DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, tostringall(...)))
end

-- Get name of currently open trade skill
function core:GetProfessionName()
	return select(1, GetTradeSkillLine())
end

-- Get level of currently open trade skill
function core:GetProfessionLevel()
	return select(2, GetTradeSkillLine())
end

-- Get table length
function core:GetTableLength(table)
	local count = 0
	for _ in pairs(table) do count = count + 1 end
	return count
end

-- Get percentage chance of skill-up
function core:GetChance(graySkill, playerSkill, yellowSkill)
	--[[ 
	graySkill -> The level at which said spell turns gray
	yellowSkill -> The level at which said spell turns yellow
	playerSkill -> The player's current level 
	--]]
	local chance = (graySkill - playerSkill) / (graySkill - yellowSkill)
	return chance
end

-- Get ID for spell (craftable item)
function core:GetSpellID(spell)
	return select(7, GetSpellInfo(spell))
end

-- Get number of available trade skills (without headers)
function core:GetTradeSkillsHeaderless(...)
	local skillName, skillType
	for i=1, GetNumTradeSkills() do
		skillName, skillType, _, _, _, _ = GetTradeSkillInfo(i)
		if (skillName and skillType ~= "header") then

		end
	end
end

