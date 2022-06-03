local SkillUpProbability, core = ...

core.Commands = {
}

local function cmdHandler(msg)

end

-- Register Slash Commands
function core:init(event)
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

	-- Clear chat
	SLASH_CLEARCHAT1 = "/clear"
	SlashCmdList["CLEARCHAT"] = function()
		SELECTED_CHAT_FRAME:Clear()
	end

	SLASH_SUP1 = "/sup"
	SlashCmdList.SkillUpProbability = cmdHandler

	core:Print("Add-on Loaded")
end
