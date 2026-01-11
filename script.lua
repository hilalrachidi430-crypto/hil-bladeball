-- Kavo UI Library Loader (Lightweight for mobile)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Blade Ball Pro", "DarkTheme")

-- Main Tab for the Auto Parry functionality
local Main = Window:NewTab("Main")
local Section = Main:NewSection("Parry Settings")

-- Core Variables
local autoParryEnabled = false
local parryDistance = 15 -- Initial default parry distance
local minVelocityThreshold = 30 -- Minimum ball velocity to consider for smart parry

-- Auto Parry Toggle Button
Section:NewToggle("Auto Parry", "Toggles intelligent auto parry.", function(state)
    autoParryEnabled = state
    if state then
        print("Auto Parry Activated!")
    else
        print("Auto Parry Deactivated.")
    end
end)

-- Slider for adjustable Parry Distance
Section:NewSlider("Parry Distance", "Adjusts how far the script parries.", 10, 50, parryDistance, false, function(value)
    parryDistance = value
    print("Parry Distance set to: " .. parryDistance)
end)

-- Keybind to Hide/Show UI (using Right Control as default, can be changed for mobile)
-- For mobile, you might want to use a Floating Button (explained below) instead of a keybind.
Section:NewKeybind("Toggle UI Visibility", "Press to hide or show the UI.", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)

-- Main Auto Parry Logic (Highly Optimized)
spawn(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local ParryRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Parry") -- Find the actual Parry Remote

    while RunService.RenderStepped:Wait() do
        if autoParryEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local root = LocalPlayer.Character.HumanoidRootPart
            local ballsFolder = workspace:FindFirstChild("Balls") -- Assuming balls are in a folder called "Balls"

            if root and ballsFolder then
                for _, ball in ipairs(ballsFolder:GetChildren()) do
                    if ball:IsA("Part") and ball.Name == "Ball" then -- Basic check for the actual ball
                        local distance = (ball.Position - root.Position).Magnitude
                        local velocity = ball.Velocity.Magnitude

                        -- Advanced Parry Logic:
                        -- Parry if ball is within adjustable 'parryDistance' OR
                        -- Parry if ball is very fast AND within a calculated "smart parry" range.
                        -- The '0.15' here is a fine-tuned time-to-impact factor.
                        local smartParryRange = velocity * 0.15 -- Example: fast ball = earlier parry

                        if distance <= parryDistance or (velocity > minVelocityThreshold and distance <= smartParryRange) then
                            if ParryRemote then
                                ParryRemote:FireServer()
                                -- Optional: A small cooldown to prevent spamming parry and looking suspicious
                                -- task.wait(0.05) 
                            end
                            break -- Parry one ball at a time to avoid multiple parries
                        end
                    end
                end
            end
        end
    end
end)