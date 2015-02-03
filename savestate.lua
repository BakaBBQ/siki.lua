savestateButton = loveframes.Create("button")
savestateButton:SetText("Save All Data")
savestateButton:SetPos(love.graphics.getWidth() - savestateButton:GetWidth() - 10, 10)
savestateButton.OnClick = function(object)
  datautils.saveCurrentState()
end
