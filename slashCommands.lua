local SkillUpProbability, SUP = ...

local function slashHandler(msg)

end

-- Reload shortcut
SLASH_RELOAD1 = "/rl" 
SlashCmdList["RELOAD"] = ReloadUI

-- Frame stack shortcut
SLASH_FRAMESTK1 = "/fs"
SlashCmdList["FRAMESTK"] = function()
	LoadAddOn('Blizzard_DebugTools')
	FrameStackTooltip_Toggle()
end

