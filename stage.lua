local stageStartX = love.graphics.getWidth() / 4
local stageStartY = 0
local stageEndX = love.graphics.getWidth()
local stageEndY = love.graphics.getHeight() - love.graphics.getHeight() / 3
local stageWidth = love.graphics.getWidth() - stageStartX
local stageHeight = love.graphics.getHeight() - love.graphics.getHeight() / 3
local stageMidX = stageWidth / 2 + stageStartX
local stageMidY = stageHeight / 2 + stageStartY

function getStageMouseX()
  return love.mouse.getX() - stageMidX
end

function getStageMouseY()
  return stageMidY - love.mouse.getY()
end

function decorateStage()
  local font = love.graphics.newFont(14)
  local function drawLines()
    love.graphics.setColor{255, 0, 0, 140}
    love.graphics.line(stageStartX, stageMidY, stageEndX, stageMidY)
    love.graphics.line(stageMidX, stageStartY, stageMidX, stageEndY)
  end

  local function drawMouseCoord()
    love.graphics.setColor{255,255,255,230}
    love.graphics.setFont(font)
    love.graphics.print("Mouse: (" .. getStageMouseX() .. ", " .. getStageMouseY() .. ")", stageStartX + 10, stageStartY + 3)
  end

  local function drawFrameImage()
    if currentFrameImage then
      local rx = stageMidX - currentFrameImage:getWidth() / 2
      local ry = stageMidY - currentFrameImage:getHeight() / 2
      love.graphics.draw(currentFrameImage, rx, ry)
    end
  end


  drawLines()
  drawMouseCoord()
  drawFrameImage()
end
