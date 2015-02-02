flagListFrame = 0
flagListFrame = loveframes.Create("frame")
flagListFrame:SetName("Flag Lists")
flagListFrame:SetSize(love.graphics.getWidth() / 4 * 3 / 2, love.graphics.getHeight() / 3)
flagListFrame:SetPos(love.graphics.getWidth() / 4 + love.graphics.getWidth() / 4 * 3 / 2, love.graphics.getHeight() - love.graphics.getHeight() / 3)
flagListFrame:SetDraggable(false)
flagListFrame:ShowCloseButton(false)

local flaglist = loveframes.Create("columnlist", flagListFrame)
flaglist.defaultcolumnwidth = (flagListFrame:GetWidth() - 10) / 2
flaglist:SetPos(5,30)
flaglist:SetSize(flagListFrame:GetWidth() - 10, flagListFrame:GetHeight() - 60)
flaglist:AddColumn("Flag Data")
flaglist:AddColumn("Flag Value")
local ay = flagListFrame:GetHeight() - 28
local addFlagButton = loveframes.Create("button", flagListFrame)
addFlagButton:SetSize(18, addFlagButton:GetHeight())
addFlagButton:SetText("+")
addFlagButton:SetPos(5, flagListFrame:GetHeight() - 28)

local deleteFlagButton = loveframes.Create("button", flagListFrame)
deleteFlagButton:SetSize(addFlagButton:GetSize())
deleteFlagButton:SetText("-")
deleteFlagButton:SetPos(addFlagButton:GetX() + 23, flagListFrame:GetHeight() - 28)

local flagKey = loveframes.Create("textinput", flagListFrame)
flagKey:SetPos(deleteFlagButton:GetX() + 24 + 22, ay)
flagKey:SetSize((flagListFrame:GetWidth() - 60) / 2, addFlagButton:GetHeight())

local flagValue = loveframes.Create("textinput", flagListFrame)
flagValue:SetPos(deleteFlagButton:GetX() + 24 + 26 + flagKey:GetWidth(), ay)
flagValue:SetSize(flagKey:GetSize())
