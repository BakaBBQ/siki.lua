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

  local function drawSingleBox(x, y, w, h, c1, c2)
    love.graphics.setColor(c1)
    love.graphics.rectangle("line", x + stageMidX, y + stageMidY, w, h)
    love.graphics.setColor(c2)
    love.graphics.rectangle("fill", x + stageMidX, y + stageMidY, w, h)
  end


  -- I know, I know, all hacked up code, but what the h*ll
  local inactive_alpha = 40
  local active_alpha = 120
  local function drawActiveHitBox(x,y,w,h)
    drawSingleBox(x,y,w,h,{240,10,10,active_alpha + 40},{240,10,10,active_alpha})
  end

  local function drawInactiveHitBox(x,y,w,h)
    drawSingleBox(x,y,w,h,{240,10,10,inactive_alpha + 40},{240,10,10,inactive_alpha})
  end

  local function drawActiveHurtBox(x,y,w,h)
    drawSingleBox(x,y,w,h,{10,240,10,active_alpha + 40},{10,240,10,active_alpha})
  end

  local function drawInactiveHurtBox(x,y,w,h)
    drawSingleBox(x,y,w,h,{10,240,10,inactive_alpha + 40},{10,240,10,inactive_alpha})
  end

  local function drawAllBoxes()
    for k,v in pairs(getCurrentRedBoxes()) do
      if v.active then
        drawActiveHitBox(v.x,v.y,v.w,v.h)
      else
        drawInactiveHitBox(v.x,v.y,v.w,v.h)
      end

    end

    for k,v in pairs(getCurrentGreenBoxes()) do
      if v.active then
        drawActiveHurtBox(v.x,v.y,v.w,v.h)
      else
        drawInactiveHurtBox(v.x,v.y,v.w,v.h)
      end

    end

  end



  drawLines()
  drawMouseCoord()
  drawFrameImage()
  if currentFrameData then
    drawAllBoxes()
  end
end
