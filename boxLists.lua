
boxListFrame = 0
boxListFrame = loveframes.Create("frame")
boxListFrame:SetName("Box Lists")
boxListFrame:SetSize(love.graphics.getWidth() / 4 * 3 / 2, love.graphics.getHeight() / 3)
boxListFrame:SetPos(love.graphics.getWidth() / 4, love.graphics.getHeight() - love.graphics.getHeight() / 3)
boxListFrame:SetDraggable(false)
boxListFrame:ShowCloseButton(false)
function table_invert(t)
   local s={}
   for k,v in pairs(t) do
     s[v]=k
   end
   return s
end

boxlist = loveframes.Create("columnlist", boxListFrame)
boxlist.defaultcolumnwidth = ((boxListFrame:GetWidth() - 10) / 3)
boxlist:SetPos(5,30)
boxlist:SetSize(boxListFrame:GetWidth() - 10, boxListFrame:GetHeight() - 60)
boxlist:AddColumn("Type")
boxlist:AddColumn("Pos")
boxlist:AddColumn("Size")
boxlist.OnRowSelected = function(parent, row, data)
  
end


local createRedButton = loveframes.Create("button",boxListFrame)
createRedButton:SetWidth((boxListFrame:GetWidth() - 10)/3)
createRedButton:SetText("Create Hitbox")
createRedButton:SetPos(8, boxListFrame:GetHeight() - 28)
createRedButton.OnClick = function(object)
  addNewRedBox()
  refreshBoxList()
end



local createGreenButton = loveframes.Create("button", boxListFrame)
createGreenButton:SetWidth(createRedButton:GetWidth())
createGreenButton:SetText("Create Hurtbox")
createGreenButton:SetPos(createRedButton:GetX() + createRedButton:GetWidth(), boxListFrame:GetHeight() - 28)
createGreenButton.OnClick = function(object)
  addNewGreenBox()
  refreshBoxList()
end
local deleteBox = loveframes.Create("button", boxListFrame)
deleteBox:SetWidth(createRedButton:GetWidth())
deleteBox:SetText("Delete Box")
deleteBox:SetPos(createGreenButton:GetX() + createGreenButton:GetWidth() * 2, boxListFrame:GetHeight() - 28)

function getCurrentRedBoxes()
  return currentFrameData['redboxes']
end

function getCurrentGreenBoxes()
  return currentFrameData['greenboxes']
end

function addNewRedBox()
  table.insert(currentFrameData['redboxes'], newRedBox())
end

function addNewGreenBox()
  table.insert(currentFrameData['greenboxes'], newGreenBox())
end



function refreshBoxList()
  local function formatRect(rect)
    return ("pos " .. rect['x'] .. ',' .. rect['y'] .. ' | ' .. 'size ' .. rect['w'] .. ',' .. rect['h'])
  end

  boxlist:Clear()
  for k, v in pairs(getCurrentRedBoxes()) do
    local rect = v
    boxlist:AddRow("HitBox", rect['x'] .. ', ' .. rect['y'], rect['w'] .. ', ' .. rect['h'])
  end

  for k, v in pairs(getCurrentGreenBoxes()) do
    local rect = v
    boxlist:AddRow("HurtBox", rect['x'] .. ', ' .. rect['y'], rect['w'] .. ', ' .. rect['h'])
  end
end
