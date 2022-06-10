local SkillUpProbability, core = ...

core.Name = "SkillUpProbability"

core.Events = {}
local events = core.Events

-- ef = Event Frame
events.ef = CreateFrame("Frame")

events.ef:RegisterEvent("ADDON_LOADED")
events.ef:RegisterEvent("TRADE_SKILL_UPDATE")
events.ef:RegisterEvent("TRADE_SKILL_CLOSE")
events.ef:RegisterEvent("CRAFT_UPDATE") -- For enchanting

-- Main event handling function
local function onEvent(self, event, addon)
	--core:Print("Event: "..event)
	if event == "ADDON_LOADED" and addon == core.Name then
		core.init(event)
		self:UnregisterEvent(event)
	end
end

events.ef:SetScript("OnEvent", onEvent)
