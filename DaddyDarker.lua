-------------------------------------------------------------------------------
-- For Daddy Darker By Crackpotx (US, Lightbringer)
-------------------------------------------------------------------------------
local DD = LibStub("AceAddon-3.0"):NewAddon("DaddyDarker", "AceConsole-3.0", "AceEvent-3.0")

-- local api cache
local GetAddOnMetadata = _G["GetAddOnMetadata"]

DD.title = GetAddOnMetadata("DaddyDarker", "Title")
DD.version = GetAddOnMetadata("DaddyDarker", "Version")

local defaults = {
	global = {
		inviting = false,
	}
}

function DD:CHAT_MSG_GUILD(msg, player, ...)

end

function DD:OnEnable()
	self:RegisterEvent("CHAT_MSG_GUILD")
end

function DD:OnDisable()
	self:UnregisterEvent("CHAT_MSG_GUILD")
end

function DD:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("DaddyDarkerDB", defaults)
end