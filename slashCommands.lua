local SkillUpProbability, core = ...

core.commands = {
}

local function cmdHandler(msg)

end

-- Register Slash Commands
function core:init(event, name)
	if (name ~= "SkillUpProbability") then return end

	-- Allows usage of arrow keys in edit box without rotating character
	for i = 1, NUM_CHAT_WINDOWS do
		_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
	end
	
	-- SLASH COMMANDS --
	
	-- Reload shortcut
	SLASH_RELOAD1 = "/rl" 
	SlashCmdList["RELOAD"] = ReloadUI

	-- Frame stack shortcut
	SLASH_FRAMESTK1 = "/fs"
	SlashCmdList["FRAMESTK"] = function()
		LoadAddOn('Blizzard_DebugTools')
		FrameStackTooltip_Toggle()
	end

	SLASH_SUP1 = "/sup"
	SlashCmdList.SkillUpProbability = cmdHandler
end
