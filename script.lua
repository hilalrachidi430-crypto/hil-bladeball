-- [[ CONFIGURATION AND UI ADAPTATION ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ParryButton = Instance.new("TextButton")
local MenuButton = Instance.new("TextButton") -- Minimize/Restore Toggle
local UICornerMain = Instance.new("UICorner")
local UICornerButton = Instance.new("UICorner")
local UICornerMenu = Instance.new("UICorner")
local CloseBtn = Instance.new("TextButton")

-- Root Setup
ScreenGui.Name = "BladeBallVip"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Panel Design
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true -- Enable dragging anywhere

UICornerMain.CornerRadius = UDim.new(0, 12)
UICornerMain.Parent = MainFrame

-- Auto Parry Button (Purple)
ParryButton.Name = "ParryButton"
ParryButton.Parent = MainFrame
ParryButton.BackgroundColor3 = Color3.fromRGB(110, 38, 174)
ParryButton.Position = UDim2.new(0.1, 0, 0.25, 0)
ParryButton.Size = UDim2.new(0, 180, 0, 80)
ParryButton.Font = Enum.Font.SourceSansBold
ParryButton.Text = "AUTO PARRY: OFF"
ParryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ParryButton.TextScaled = true

UICornerButton.CornerRadius = UDim.new(0, 10)
UICornerButton.Parent = ParryButton

-- Close/Minimize Button (X)
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent