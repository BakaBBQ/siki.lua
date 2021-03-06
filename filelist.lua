require("filesystem")

local json = require('dkjson')
frame = 0
frame = loveframes.Create("frame")
frame:SetName("FileList")
frame:SetSize(love.graphics.getWidth() / 4, love.graphics.getHeight())
frame:SetPos(0,0)
frame:SetDraggable(false)
frame:ShowCloseButton(false)

local filelist = loveframes.Create("columnlist", frame)
filelist.defaultcolumnwidth = 175
filelist:SetPos(5,30)
filelist:SetSize(frame:GetWidth() - 10, frame:GetHeight() - 85)

filelist:SetColumnName(1,".w.")
filelist:Clear()

filelist:AddColumn("PNG Files")

files = scandir(root)
function refreshFiles()
  print(root)
  files = scandir(root)
  filelist:Clear()
  for k, v in pairs(files) do
    if string.find(v, '.+png') then
      filelist:AddRow(v)
    end
  end
  filelist.OnRowClicked = function(parent, row, rowdata)
    for k, v in ipairs(rowdata) do
      currentFrameImage = loadFrame(v)
      print(currentFrameImage)
    end

  end
end

rootTextbox = loveframes.Create("textinput", frame)
rootTextbox:SetPos(5, 30 + frame:GetHeight() - 80)
rootTextbox:SetWidth(filelist:GetWidth())
rootTextbox:SetText(root)

local refreshButton = loveframes.Create("button", frame)
refreshButton:SetPos(5, 30 + frame:GetHeight() - 60 + 3)
refreshButton:SetSize(filelist:GetWidth(), 23)
refreshButton:SetText("Refresh Files")
refreshButton.OnClick = function(obj)
  root = rootTextbox:GetText()
  updateRoot()
  file = love.filesystem.newFile(tmp_file, 'w')
  tmp_tbl = {root=root}
  file:write(json.encode(tmp_tbl, {indent = true}))
  refreshFiles()
end


refreshFiles()
