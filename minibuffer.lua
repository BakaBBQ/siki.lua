minibuffer = 'minibuffer'
function drawMinibuffer()
  love.graphics.setColor{0, 240, 0, 230}
  local h =love.graphics.getHeight() - love.graphics.getHeight() / 3
  love.graphics.printf(minibuffer,love.graphics.getWidth() - 210, h - 20, 200,"right")
end
function onSaveBufferOutput()
  minibuffer = 'saved at ' .. os.date("%H:%M:%S")
end
