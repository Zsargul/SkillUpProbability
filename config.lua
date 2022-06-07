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
function core:CalcChance(graySkill, playerSkill, yellowSkill)
	--[[ 
	graySkill -> The level at which said spell turns gray
	yellowSkill -> The level at which said spell turns yellow
	playerSkill -> The player's current level 
	--]]
	local chance = (graySkill - playerSkill) / (graySkill - yellowSkill)
	return chance
end

-- Round to a given amount of decimal places
function core:Round(n, decimalPlaces)
	local mult = 10^(decimalPlaces or 0)
	return math.floor(n * mult + 0.5) / mult
end

function core:GetChance(skillName, skillType, profName)
	local gray = core.SpellData[core:GetProfessionName(profName)][skillName][4]
	local green = core.SpellData[core:GetProfessionName(profName)][skillName][3]
	local yellow = core.SpellData[core:GetProfessionName(profName)][skillName][2]
	local orange = core.SpellData[core:GetProfessionName(profName)][skillName][1] 
	local playerSkill = core:GetProfessionLevel()
	
	local chance
	if (playerSkill >= gray) then
		chance = 0
		return chance
	else
		chance = core:CalcChance(gray, playerSkill, yellow)
	end

	if (chance >= 1 or yellow == gray) then chance = 1 end

	chance = core:Round((chance*100), 1)
	return chance
end

-- Get number of available trade skills (without headers)
function core:TradeSkillUpdateChance()
	local skillName, skillType
	for i=1, GetNumTradeSkills(), 1 do
		local skillOffset = FauxScrollFrame_GetOffset(TradeSkillListScrollFrame);
		local skillIndex = i + skillOffset

		local profName = core:GetProfessionName()
		local skillName, skillType, numAvailable, _, _, _ = GetTradeSkillInfo(skillIndex)
		local skillButton = getglobal("TradeSkillSkill"..i)
		
		if (skillName and skillType ~= "header") then
			local chance = core:GetChance(skillName, skillType, profName)
			
			if (chance == 0) then
				break
			end

			if (numAvailable == 0) then
				skillButton:SetText(" "..skillName.." {"..chance.."} ")
			else
				skillButton:SetText(" "..skillName.." ["..numAvailable.."] {"..chance.."}")
			end

			-- Test
			--if (chance ~= 0) then
			--	core:Print("SkillName: "..skillName.." | Chance: "..chance.."%")
			--end
			-- Test
			
		end
	end
end

