local SkillUpProbability, SUP = ...

local createFrame = function()
	local mainFrame = CreateFrame("Frame", "CraftProbFrame", PaperDollItemsFrame, "BasicFrameTemplateWithInset");

	mainFrame:SetSize(250, 250); -- Width, Height
	mainFrame:SetPoint("LEFT", PaperDollItemsFrame, "RIGHT");

	mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY")
	mainFrame.title:SetFontObject("GameFontHighlight")
	mainFrame.title:SetPoint("CENTER", mainFrame.TitleBg, "CENTER")
	mainFrame.title:SetText("Skill-up Probability")
end

local printColor = function(text, color)
	print('\124'.. color .. text .. '\124r')
end

local loadedNotif = function()
	printColor("Loaded SkillUpProbability", "cffFF63B4")
end

-- Main
createFrame()
loadedNotif()
