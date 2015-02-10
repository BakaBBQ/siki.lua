require('framedata')
local json = require("dkjson")
datautils = {}
currentFileName = 0
local filename = root .. '/' .. 'frames.json'
function getFilename()
  return root .. '/' .. 'frames.json'
end

function getProdFilename()
  return root .. '/' .. 'frames.prod.json'
end

function getFlagsProdFilename()
  return root .. '/' .. 'flags.prod.json'
end

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
    print("Find .frames")
  else
    print(".frames does not exist, creating blank data")
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

function updateRoot()
  filename = root .. '/' .. 'frames.json'
end

local function parseToPossibleInt(flagList)
  for k,v in pairs(flagList) do
    if tonumber(v) ~= nil then
      flagList[k] = tonumber(v)
    end
  end
end

local function parseToPossibleBool(flagList)
  for k,v in pairs(flagList) do
    if v == 'true' then
      flagList[k] = true
    elseif v == 'false' then
      flagList[k] = false
    end
  end
end



function datautils.getProductionVersion()




  local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
  end

  local function cleanActive(frameData) -- unclean
    for k, v in pairs(frameData.redboxes) do
      v.active = nil
    end

    for k, v in pairs(frameData.greenboxes) do
      v.active = nil
    end

    for k, v in pairs(frameData.whiteboxes) do
      v.active = nil
    end
  end

  local dupData = deepcopy(frameDatas)
  for k,v in pairs(dupData) do
    cleanActive(v) -- we do not need to save the active state
    v.flags = nil
    v.flags = nil
  end
  return dupData
end

function datautils.getSeperateFlags()
  tbl = {}
  for k,v in pairs(frameDatas) do
    tbl[k] = v.flags
    parseToPossibleBool(v.flags)
    parseToPossibleInt(v.flags)
  end

  return tbl
end


function datautils.saveCurrentState()
  datautils.saveJsonState(frameDatas, getFilename())
  datautils.saveJsonState(datautils.getProductionVersion(), getProdFilename())
  datautils.saveJsonState(datautils.getSeperateFlags(), getFlagsProdFilename())
  onSaveBufferOutput()
end

function datautils.saveJsonState(tbl, filename)
  local str = json.encode(tbl, {indent=true})
  local file = io.open(filename, "w")
  print("Save TBL to: " .. filename)
  file:write(str)
  file:close()
end
