local lume = require 'lume'
local class = require 'middleclass'

-- the container for all
FrameData = {}
-- the boxes
Box = class('Box')
function Box:initialize(x,y,w,h,hurt)
  self.x = x
  self.y = y
  self.width = w
  self.height = h
  self.isHurtbox = hurt
end

function newBox(isHurtBox)
  return {
    x = lume.round(lume.random(-100,100));
    y = lume.round(lume.random(-100,100));
    w = lume.round(lume.random(30,120));
    h = lume.round(lume.random(30,120));
    isHurt = isHurtBox
  }
end

function newRedBox()
  return newBox(false)
end

function newGreenBox()
  return newBox(true)
end




function newFrameData()
  return {
    redboxes = {};
    greenboxes = {};
    flags = {};
    center = {0,0}
  }
end
