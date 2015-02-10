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

  local function drawHelp()
    love.graphics.setColor{255,255,255,230}
    love.graphics.setFont(font)
    love.graphics.print("wasd : move active box", stageStartX + 10, stageEndY - 20 - 16 * 3)
    love.graphics.print("ujhk: resize active box", stageStartX + 10, stageEndY - 20 - 16 * 2)
    love.graphics.print("mouse click: select active box", stageStartX + 10, stageEndY - 20 - 16 * 1)
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
    love.graphics.rectangle("line", x + stageMidX, stageMidY - y, w, h)
    love.graphics.setColor(c2)
    love.graphics.rectangle("fill", x + stageMidX, stageMidY - y, w, h)
  end


  -- I know, I know, all hacked up code, but what the h*ll
  local inactive_alpha = 80
  local active_alpha = 120
  local function drawActiveHitBox(x,y,w,h)
    drawSingleBox(x,y,w,h,{240,10,10,active_alpha + 40},{240,10,10,active_alpha})
  end

  -- i need to refactor this
  local function drawInactiveHitBox(x,y,w,h)
    drawSingleBox(x,y,w,h,{240,10,10,inactive_alpha + 40},{240,10,10,inactive_alpha})
  end

  local function drawActiveHurtBox(x,y,w,h)
    drawSingleBox(x,y,w,h,{10,240,10,active_alpha + 40},{10,240,10,active_alpha})
  end

  local function drawInactiveHurtBox(x,y,w,h)
    drawSingleBox(x,y,w,h,{10,240,10,inactive_alpha + 40},{10,240,10,inactive_alpha})
  end

  local function drawActiveCollisionBox(x,y,w,h)
    drawSingleBox(x,y,w,h,{240,240,240,active_alpha + 40},{240,240,240,active_alpha})
  end

  local function drawInactiveCollisionBox(x,y,w,h)
    drawSingleBox(x,y,w,h,{240,240,240,inactive_alpha + 40},{240,240,240,inactive_alpha})
  end


  local function drawAllBoxes()
    for k,v in pairs(getCurrentWhiteBoxes()) do
      if v.active then
        drawActiveCollisionBox(v.x,v.y,v.w,v.h)
      else
        drawInactiveCollisionBox(v.x,v.y,v.w,v.h)
      end

    end




    for k,v in pairs(getCurrentGreenBoxes()) do
      if v.active then
        drawActiveHurtBox(v.x,v.y,v.w,v.h)
      else
        drawInactiveHurtBox(v.x,v.y,v.w,v.h)
      end

    end

    for k,v in pairs(getCurrentRedBoxes()) do
      if v.active then
        drawActiveHitBox(v.x,v.y,v.w,v.h)
      else
        drawInactiveHitBox(v.x,v.y,v.w,v.h)
      end
    end



  end



  drawLines()
  drawMouseCoord()
  drawHelp()
  drawFrameImage()
  if currentFrameData then
    drawAllBoxes()
  end
end

stage = {}
function stage.getActiveBox()
   local active = nil
   if not currentFrameData then
     return nil
   end

   for k,v in pairs(getCurrentGreenBoxes()) do
      if v.active then
	       return v
      end
   end

   for k,v in pairs(getCurrentRedBoxes()) do
      if v.active then
         return v
      end
   end

   for k,v in pairs(getCurrentWhiteBoxes()) do
      if v.active then
         return v
      end
   end
end

function tableMerge(t1, t2)
    for k,v in pairs(t2) do
    	if type(v) == "table" then
    		if type(t1[k] or false) == "table" then
    			tableMerge(t1[k] or {}, t2[k] or {})
    		else
    			t1[k] = v
    		end
    	else
    		t1[k] = v
    	end
    end
    return t1
end

function stage.getAllBoxes()
   return tableMerge(getCurrentGreenBoxes(), getCurrentRedBoxes())
end

function stage.mousereleased(x,y,button)
end



function stage.mouseWithinStage()
  local wx = (love.mouse.getX() > stageStartX and love.mouse.getX() < (stageStartX + stageWidth))
  local wy = (love.mouse.getY() > stageStartY and love.mouse.getY() < (stageStartY + stageHeight))
  return wx and wy
end

function stage.onMouseClick(x,y)
  if currentFrameData and stage.mouseWithinStage() then
    local fx = getStageMouseX()
    local fy = getStageMouseY()
    print("x " .. tostring(fx) .. "| y" .. tostring(fy))
    local active_one = nil

    for k,v in pairs(getCurrentGreenBoxes()) do
      local rect = v
      v.active = false
      print(rect.x .. " " .. rect.y)
      if (fx > rect.x and fx < (rect.x + rect.w)) and (fy < rect.y and fy > (rect.y - rect.h)) then
        print("within find range")
        v.active = true
        print(v == rect)
      end
    end

    for k,v in pairs(getCurrentRedBoxes()) do
      local rect = v
      v.active = false
      print(rect.x .. " " .. rect.y)
      if (fx > rect.x and fx < (rect.x + rect.w)) and (fy < rect.y and fy > (rect.y - rect.h)) then
        print("within find range")
        v.active = true
        print(v == rect)
      end
    end

    for k,v in pairs(getCurrentWhiteBoxes()) do
      local rect = v
      v.active = false
      print(rect.x .. " " .. rect.y)
      if (fx > rect.x and fx < (rect.x + rect.w)) and (fy < rect.y and fy > (rect.y - rect.h)) then
        print("within find range")
        v.active = true
        print(v == rect)
      end
    end
    if active_one then
      active_one.active = true
    else
      print("did not find active")
    end
    refreshBoxList()
  end
end

function stage.updateKeyStroke()
  if stage.getActiveBox() then
    local function updateMove()
      if love.keyboard.isDown("w") then
        stage.getActiveBox().y = stage.getActiveBox().y + 1
        refreshBoxList()
      end
      if love.keyboard.isDown("s") then
        stage.getActiveBox().y = stage.getActiveBox().y - 1
        refreshBoxList()
      end
      if love.keyboard.isDown("a") then
        stage.getActiveBox().x = stage.getActiveBox().x - 1
        refreshBoxList()
      end
      if love.keyboard.isDown("d") then
        stage.getActiveBox().x = stage.getActiveBox().x + 1
        refreshBoxList()
      end
    end

    local function updateResize()
      if love.keyboard.isDown("u") then
        stage.getActiveBox().h = stage.getActiveBox().h - 1
        refreshBoxList()
      end
      if love.keyboard.isDown("j") then
        stage.getActiveBox().h = stage.getActiveBox().h + 1
        refreshBoxList()
      end
      if love.keyboard.isDown("h") then
        stage.getActiveBox().w = stage.getActiveBox().w - 1
        refreshBoxList()
      end
      if love.keyboard.isDown("k") then
        stage.getActiveBox().w = stage.getActiveBox().w + 1
        refreshBoxList()
      end
    end

    local function updateDelete()
      if love.keyboard.isDown("backspace") or love.keyboard.isDown("delete") then
        deleteActiveBox()
      end
    end

    local function updateSave()
      local sys = love.keyboard.isDown("rctrl") or love.keyboard.isDown("lctrl") or love.keyboard.isDown("rgui") or love.keyboard.isDown("lgui")
      if love.keyboard.isDown("s") and (sys) then
        datautils.saveCurrentState()
        return true
      end
    end



    if(updateSave()) then
    else
      updateMove()
    end

    

    updateResize()
    updateDelete()

  end
end
