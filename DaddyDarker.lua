-------------------------------------------------------------------------------
-- For Daddy Darker By Crackpotx (US, Lightbringer)
-------------------------------------------------------------------------------
local DD = LibStub("AceAddon-3.0"):NewAddon("DaddyDarker", "AceConsole-3.0", "AceEvent-3.0")

-- local api cache
local C_PartyInfo_InviteUnit = C_PartyInfo.InviteUnit
local GetAddOnMetadata = _G["GetAddOnMetadata"]
local UnitName = _G["UnitName"]

DD.title = GetAddOnMetadata("DaddyDarker", "Title")
DD.version = GetAddOnMetadata("DaddyDarker", "Version")

local defaults = {
	global = {
		inviting = false,
		players = {}
	}
}

local function FindInArray(toFind, arraySearch)
	if #arraySearch == 0 then return false end
	for _, value in pairs(arraySearch) do
		if value == toFind then
			return true
		end
	end
	return false
end

function DD:Print(msg)
	print(("|cffC41F3BDaddyDarker|r |cffffffff%s|r"):format(msg))
end

function DD:CHAT_MSG_GUILD(evemt, msg, player, ...)
	local temp = {strsplit("-", player)}
	local playerName = temp[1]
	if self.db.global.inviting and msg:match("[xX]+") and playerName:lower() ~= UnitName("player"):lower() and not FindInArray(playerName:lower(), self.db.global.players) then
		self:Print(("Inviting %s"):format(playerName))
		C_PartyInfo_InviteUnit(playerName)
		self.db.global.players[#self.db.global.players + 1] = playerName:lower()
	end
end

function DD:OnEnable()
	self:RegisterEvent("CHAT_MSG_GUILD")
end

function DD:OnDisable()
	self:UnregisterEvent("CHAT_MSG_GUILD")
end

function DD:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("DaddyDarkerDB", defaults)

	self:RegisterChatCommand("darker", function(args)
		self.db.global.inviting = not self.db.global.inviting
		self:Print(self.db.global.inviting and "Raid invites have started!" or "Raid invites have stopped!")
		if self.db.global.inviting then
			SendChatMessage("Type XX for a raid invite!", "GUILD")
		else
			self.db.global.players = {}
		end
	end)
end