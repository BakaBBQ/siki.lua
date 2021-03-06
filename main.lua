
currentFrameImage = nil
root = os.getenv("HOME")
require 'minibuffer'
require 'datautils'
local json = require('dkjson')
local inspect = require 'inspect'
-- frameDatas, a filename -> framedata hash
frameDatas = {}

currentFrameData = nil
require("stage")

tmp_file = 'tmp.json'
function love.load()

  if love.filesystem.exists( tmp_file ) and love.filesystem.isFile(tmp_file) then
    local contents, size = love.filesystem.read(tmp_file)
    local obj, pos, err = json.decode(contents, 1, nil)
    if err then
      print ("Error: ", err)
    else
      root = obj.root
    end
  else
    print("[WARNING] cannot find tmp file, using the user home")
    root = os.getenv("HOME")
  end
  loveframes = require("love-frames")
  loveframes.util.RemoveAll()
  require("savestate")
  require("boxLists")
  require("flagLists")
  require("filelist")
end

function loadFrame(relative_path) -- just the filename... no path...
  if #frameDatas == 0 then
    print("Blank frame data, loading json")
    frameDatas = datautils.loadJson()
  else
    print("Already inited frameData")
    print(inspect(frameDatas))
  end
  local absolute_path = root .. '/' .. relative_path
  print("Absolute Path: " .. absolute_path)
  local f = io.open(absolute_path)
  local contents = f:read('*a')
  f:close()
  currentFrameData = datautils.retrieveFrameData(relative_path)
  print("Current Frame Data: " .. inspect(frameDatas))
  image = love.graphics.newImage(love.image.newImageData(love.filesystem.newFileData(contents, 'Images/character.png')))
  datautils.saveCurrentState()
  refreshFlagList()
  refreshBoxList()
  return image
end


function love.update(dt)
    stage.updateKeyStroke()
    if love.keyboard.isDown("p") then
      print(inspect(frameDatas))
    end
    require("lurker").update()
    loveframes.update(dt)


end

function love.draw()
    decorateStage()
    drawMinibuffer()
    loveframes.draw()
end

function love.mousepressed(x, y, button)
   loveframes.mousepressed(x, y, button)
   stage.onMouseClick(x,y)
end

function love.mousereleased(x, y, button)
   stage.mousereleased(x, y, button)
   loveframes.mousereleased(x, y, button)

end

function love.keypressed(key, unicode)
    loveframes.keypressed(key, unicode)
end

function love.keyreleased(key)
    loveframes.keyreleased(key)
end

function love.textinput(text)
    loveframes.textinput(text)
end
