flagListFrame = 0
flagListFrame = loveframes.Create("frame")
flagListFrame:SetName("Flag Lists")
flagListFrame:SetSize(love.graphics.getWidth() / 4 * 3 / 2, love.graphics.getHeight() / 3)
flagListFrame:SetPos(love.graphics.getWidth() / 4 + love.graphics.getWidth() / 4 * 3 / 2, love.graphics.getHeight() - love.graphics.getHeight() / 3)
flagListFrame:SetDraggable(false)


local flaglist = loveframes.Create("columnlist", flagListFrame)
flaglist:SetPos(5,30)
flaglist:SetSize(flagListFrame:GetWidth() - 10, flagListFrame:GetHeight() - 10)
flaglist:AddColumn("Flag Data")
flaglist:AddColumn("Flag Value")
