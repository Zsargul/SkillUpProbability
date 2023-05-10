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

-- Check if a profession/spell pair exists
function core:TableHas(table, key)
	return core.SpellData[table][key] ~= nil
end

-- Calculate the percentage chance of a spell giving a skill-up
function core:GetChance(skillName, profName, playerSkill)
	--[[ Sometimes the hook on TradeSkillFrame_Update attempts to index profession/spell pairs that do not
	-- exist, for example "Blacksmithing:Heavy Silk Bandage" or "First Aid:Silver Skeleton Key". I do not
	-- know why this happens but I have added this check here to prevent it from throwing an error in-game,
	-- as it does not actually affect the calculations of the add-on and is trivial ]]--
	if (core:TableHas(profName, skillName) ~= true) then
		return 0
	else

		local gray = core.SpellData[profName][skillName][4]
		local green = core.SpellData[profName][skillName][3]
		local yellow = core.SpellData[profName][skillName][2]
		local orange = core.SpellData[profName][skillName][1] 
		
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
end

-- For some reason, the skill header "other" is sometimes not recognised as a header, and causes a bug if not accounted for
function core:SkillIsOther(skillName, skillType)
    if (skillName == 'Other' or skillType == 'Other') then
		core:Print("Is other "..skillName)
        return 1 
    else 
        return 0
    end
end

-- Find out if skill is a header
function core:SkillIsHeader(skillName, skillType)
    if (skillName == 'header' or skillType == 'header') then
        return 1
    else
        return 0
    end
end

-- For updating profession information
function core:UpdateTradeSkill(i, profName)
	local skillButton = _G['TradeSkillSkill'..i]
	local skillIndex = skillButton:GetID()
	local skillName, skillType, _, _, _, _ = GetTradeSkillInfo(skillIndex)
	local playerSkill = core:GetProfessionLevel()
	local chance

	local isHeader = core:SkillIsHeader(skillName, skillType)
	local isOther = core:SkillIsOther(skillName, skillType)

	if (isHeader ~= 0 or isOther ~= 0 or not skillName) then
		return 
	end

	if (skillButton:IsShown()) then
		chance = core:GetChance(skillName, profName, playerSkill)
		if (chance > 0) then
			skillButton:SetText(" "..skillName.." ("..chance.."%)")
			return
		end
	end
end

-- For updating craft information (Enchanting)
function core:UpdateCraftSkill(i, profName)
	--[[ Enchanting is the only profession that I am aware of that uses the craft API, but
	--   I am not taking any chances. ]]--
	if (profName ~= "Enchanting") then 
		return
	end

	local craftButton = _G['Craft'..i]
	local craftIndex = craftButton:GetID()
	local craftBtnSubText = _G['Craft'..i..'SubText']
	local craftBtnText = _G['Craft'..i..'Text']
	local craftName, craftSubName, craftType, numAv, _, _, _ = GetCraftInfo(craftIndex)
	local craftLevel = select(2, GetCraftDisplaySkillLine())
	local chance

	local isHeader = core:SkillIsHeader(craftName, craftType)
	local isOther = core:SkillIsOther(craftName, craftType)

	if (isHeader ~= 0 or isOther ~= 0 or not craftName) then
		return
	end

	if (craftButton:IsShown()) then
		chance = core:GetChance(craftName, profName, craftLevel)
		if (chance > 0) then
			if (numAv == 0) then
				craftButton:SetText(" "..craftName.." ("..chance.."%)")
			else
				craftButton:SetText(" "..craftName.." ["..numAv.."] ("..chance.."%)")
			end
			return
		end
	end
end
