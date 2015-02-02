
currentFrameImage = nil
root = "/Users/Cheryl/Desktop/actor/mamizou"
require("datautils")
-- frameDatas, a filename -> framedata hash
frameDatas = {}
frameDatas = datautils.loadJson()
currentFrameData = nil
require("stage")
function love.load()
  loveframes = require("love-frames")
  loveframes.util.RemoveAll()
  require("boxLists")
  require("flagLists")
  require("filelist")
end

function loadFrame(relative_path)
  local absolute_path = root .. '/' .. relative_path
  print(absolute_path)
  local f = io.open(absolute_path)
  local contents = f:read('*a')
  f:close()
  currentFrameData = datautils.retrieveFrameData(relative_path)
  print(currentFrameData)
  image = love.graphics.newImage(love.image.newImageData(love.filesystem.newFileData(contents, 'Images/character.png')))
  datautils.saveCurrentState()
  refreshFlagList()
  refreshBoxList()
  return image
end


function love.update(dt)

    -- your code
    require("lurker").update()
    loveframes.update(dt)

end

function love.draw()
    decorateStage()
    -- your code

    loveframes.draw()

end

function love.mousepressed(x, y, button)

    -- your code

    loveframes.mousepressed(x, y, button)

end

function love.mousereleased(x, y, button)

    -- your code

    loveframes.mousereleased(x, y, button)

end

function love.keypressed(key, unicode)

    -- your code

    loveframes.keypressed(key, unicode)

end

function love.keyreleased(key)

    -- your code

    loveframes.keyreleased(key)

end

function love.textinput(text)

    -- your code

    loveframes.textinput(text)

end
