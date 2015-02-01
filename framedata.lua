local class = require 'middleclass'

-- the container for all
local FrameData = class('FrameData')
-- the boxes
local Box = class('Box')
function Box:initialize(x,y,w,h,hurt)
  self.x = x
  self.y = y
  self.width = w
  self.height = h
  self.isHurtbox = hurt
end

function Box:isHurtBox()
  return self.hurtbox
end

function Box:isHitBox()
  r = not self.isHurtBox()
  return r
end


function FrameData:initialize()
  self.redboxes = {}
  self.greenboxes = {}
  self.flags = {}
  self.center = {0,0}
end

function FrameData:setFlag(data, value)
  self.flags[data] = value
end
