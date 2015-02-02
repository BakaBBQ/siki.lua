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

function newBox()
  return {
    x = lume.round(lume.random(-100,100));
    y = lume.round(lume.random(-100,100));
    w = lume.round(lume.random(30,120));
    h = lume.round(lume.random(30,120));
    active = false
  }
end

function newRedBox()
  return newBox()
end

function newGreenBox()
  return newBox()
end




function newFrameData()
  return {
    redboxes = {};
    greenboxes = {};
    flags = {};
    center = {0,0}
  }
end
