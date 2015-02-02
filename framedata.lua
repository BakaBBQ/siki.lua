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




function newFrameData()
  return {
    redboxes = {};
    greenboxes = {};
    flags = {};
    center = {0,0}
  }
end
