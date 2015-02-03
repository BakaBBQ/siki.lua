require('framedata')
local json = require("dkjson")
datautils = {}
currentFileName = 0
local filename = root .. '/' .. 'frames.json'
function readAll(file)
    local f = io.open(file, "rb")
    local content = f:read("*all")
    f:close()
    return content
end

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end



-- entry point #1
-- it shouldn't check for file existence... too lazy to fix that design flaw
function datautils.loadJson()
  local function createBlankJson()
    print(filename)
    local file = io.open(filename, "w")
    local blank_tbl = {}
    local str = json.encode(blank_tbl, {indent=true})
    file:write(str)
    file:close()
  end



  if file_exists(filename) then
  else
    createBlankJson()
  end

  local c = readAll(filename)
  local obj, pos, err = json.decode(c, 1, nil)
  if err then
    print ("Json Error: ", err)
  else
    return obj
  end

end

function datautils.retrieveFrameData(filename)
  print("Retrieving frame data for: " .. filename)
  if frameDatas[filename] then
    print(frameDatas[filename])
  else
    print("Creating new frame data for: " .. filename)
    frameDatas[filename] = newFrameData()
  end
  return frameDatas[filename]
end




function datautils.saveCurrentState()
  local str = json.encode(frameDatas, {indent=true})
  local file = io.open(filename, "w")
  print("===========")
  print(str)
  print("===========")
  file:write(str)
  file:close()
  onSaveBufferOutput()
end
