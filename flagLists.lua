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
flaglist.OnRowClicked = function(parent, row, rowdata)
  print('row clicked')
  for k, v in ipairs(rowdata) do
    print("" ..k.. ": " ..v)


  end
  flagKey:SetText(rowdata[1])
  flagValue:SetText(rowdata[2])
end

local ay = flagListFrame:GetHeight() - 28

local addFlagButton = loveframes.Create("button", flagListFrame)
addFlagButton:SetSize(18, addFlagButton:GetHeight())
addFlagButton:SetText("+")
addFlagButton:SetPos(5, flagListFrame:GetHeight() - 28)

addFlagButton.OnClick = function(object)
  if currentFrameData then
    addNewFlag()
    refreshFlagList()
  end

end

local deleteFlagButton = loveframes.Create("button", flagListFrame)
deleteFlagButton:SetSize(addFlagButton:GetSize())
deleteFlagButton:SetText("-")
deleteFlagButton:SetPos(addFlagButton:GetX() + 23, flagListFrame:GetHeight() - 28)

deleteFlagButton.OnClick = function(object)
  if flaglist:GetSelectedRows()[1] then
    getCurrentFlags()[flaglist:GetSelectedRows()[1].columndata[1]] = nil -- get rid of the flag in the model
    refreshFlagList() -- then simply refresh
  end
end


flagKey = loveframes.Create("textinput", flagListFrame)
flagKey:SetPos(deleteFlagButton:GetX() + 24 + 22, ay)
flagKey:SetSize((flagListFrame:GetWidth() - 60) / 2, addFlagButton:GetHeight())
flagKey.OnTextChanged = function(object, text)
  if flaglist:GetSelectedRows()[1] then
    local r = flaglist:GetSelectedRows()
    getCurrentFlags()[r[1].columndata[1]] = nil
    r[1].columndata[1] = flagKey:GetText()
    getCurrentFlags()[flagKey:GetText()] = flagValue:GetText()
  end


end


flagValue = loveframes.Create("textinput", flagListFrame)
flagValue:SetPos(deleteFlagButton:GetX() + 24 + 26 + flagKey:GetWidth(), ay)
flagValue:SetSize(flagKey:GetSize())
flagValue.OnTextChanged = function(object, text)
  if flaglist:GetSelectedRows()[1] then
    local r = flaglist:GetSelectedRows()
    r[1].columndata[2] = flagValue:GetText()
    getCurrentFlags()[flagKey:GetText()] = flagValue:GetText()
  end
end
function getCurrentFlags()
  return currentFrameData['flags']
end

function refreshFlagList()
  flaglist:Clear()
  for k, v in pairs(getCurrentFlags()) do
    flaglist:AddRow(k, v)
  end
  flagKey:Clear()
  flagValue:Clear()
end

function addNewFlag()
  print(getCurrentFlags()["NewFlag"])
  getCurrentFlags()["NewFlag"] = "Demo Value"
end
