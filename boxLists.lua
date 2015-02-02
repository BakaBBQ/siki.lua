
boxListFrame = 0
boxListFrame = loveframes.Create("frame")
boxListFrame:SetName("Box Lists")
boxListFrame:SetSize(love.graphics.getWidth() / 4 * 3 / 2, love.graphics.getHeight() / 3)
boxListFrame:SetPos(love.graphics.getWidth() / 4, love.graphics.getHeight() - love.graphics.getHeight() / 3)
boxListFrame:SetDraggable(false)
boxListFrame:ShowCloseButton(false)


local boxlist = loveframes.Create("columnlist", boxListFrame)
boxlist.defaultcolumnwidth = (boxListFrame:GetWidth() - 10)
boxlist:SetPos(5,30)
boxlist:SetSize(boxListFrame:GetWidth() - 10, boxListFrame:GetHeight() - 60)
boxlist:AddColumn("Boxs")


local createRedButton = loveframes.Create("button",boxListFrame)
createRedButton:SetWidth((boxListFrame:GetWidth() - 10)/3)
createRedButton:SetText("Create Hitbox")
createRedButton:SetPos(8, boxListFrame:GetHeight() - 28)


local createGreenButton = loveframes.Create("button", boxListFrame)
createGreenButton:SetWidth(createRedButton:GetWidth())
createGreenButton:SetText("Create Hurtbox")
createGreenButton:SetPos(createRedButton:GetX() + createRedButton:GetWidth(), boxListFrame:GetHeight() - 28)

local deleteBox = loveframes.Create("button", boxListFrame)
deleteBox:SetWidth(createRedButton:GetWidth())
deleteBox:SetText("Delete Box")
deleteBox:SetPos(createGreenButton:GetX() + createGreenButton:GetWidth() * 2, boxListFrame:GetHeight() - 28)

function getCurrentBoxes()
  currentFrameData[]  
end
