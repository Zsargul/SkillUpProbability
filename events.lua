local SkillUpProbability, core = ...
core.Events = {}

local events = core.Events

-- ef = Event Frame
events.ef = CreateFrame("Frame")

events.ef:RegisterEvent("PLAYER_LOGIN")
events.ef:RegisterEvent("TRADE_SKILL_UPDATE")

-- Main event handling function
local function onEvent(self, event, addon)
	core:Print("Event: "..event)
	if event == "PLAYER_LOGIN" then
		core.init(event)
		self:UnregisterEvent(event)
	elseif event == "TRADE_SKILL_UPDATE" then
		--core.GetTradeSkillsHeaderless()
		
		--core:Print("TS: "..core:GetProfessionName())
		--core:Print("LVL: "..core:GetProfessionLevel())
		--print(core.SpellData["First Aid"]["27033"][1])
		core:TradeSkillUpdateChance()	
	end
end

events.ef:SetScript("OnEvent", onEvent)

