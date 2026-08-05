-- Violence District Features Module (Auto Generator Fix & No CD Dagger)

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

getgenv().AutoGenerator = false
getgenv().AutoPerfectSkillCheck = false
getgenv().NoCDDagger = false
getgenv().AutoEscape = false

-- 1. Auto Generator Fix & Implementation with Safe Stop / Exit
local function findNearestGenerator()
    local nearest = nil
    local shortestDist = math.huge
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local hrp = char.HumanoidRootPart

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name:lower():find("generator") and (obj:IsA("Model") or obj:IsA("BasePart")) then
            local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position or obj:GetPivot().Position) or obj.Position
            local dist = (hrp.Position - pos).Magnitude
            if dist < shortestDist then
                shortestDist = dist
                nearest = obj
            end
        end
    end
    return nearest
end

task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().AutoGenerator then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                local gen = findNearestGenerator()
                if gen then
                    local genPos = gen:IsA("Model") and (gen.PrimaryPart and gen.PrimaryPart.Position or gen:GetPivot().Position) or gen.Position
                    
                    -- Teleport close to generator safely
                    hrp.CFrame = CFrame.new(genPos + Vector3.new(0, 3, 0))
                    
                    -- Simulate repair interaction or fire remote
                    for _, remote in ipairs(Workspace:GetDescendants()) do
                        if remote:IsA("RemoteEvent") and (remote.Name:lower():find("repair") or remote.Name:lower():find("gen") or remote.Name:lower():find("interaction")) then
                            pcall(function()
                                remote:FireServer(gen)
                            end)
                        end
                    end
                end
            end)
        else
            -- Ensure when auto generator is turned off, player controls and movement are fully normal
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character.Humanoid.PlatformStand = false
                end
            end)
        end
    end
end)

-- 2. No CD Dagger Implementation
task.spawn(function()
    while true do
        task.wait(0.2)
        if getgenv().NoCDDagger then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    for _, tool in ipairs(char:GetChildren()) do
                        if tool:IsA("Tool") and (tool.Name:lower():find("dagger") or tool.Name:lower():find("knife") or tool.Name:lower():find("weapon")) then
                            -- Remove or reset cooldown attributes/values if present
                            if tool:GetAttribute("Cooldown") then
                                tool:SetAttribute("Cooldown", 0)
                            end
                            if tool:FindFirstChild("Cooldown") then
                                tool.Cooldown.Value = 0
                            end
                        end
                    end
                    local backpack = LocalPlayer:FindFirstChild("Backpack")
                    if backpack then
                        for _, tool in ipairs(backpack:GetChildren()) do
                            if tool:IsA("Tool") and (tool.Name:lower():find("dagger") or tool.Name:lower():find("knife") or tool.Name:lower():find("weapon")) then
                                if tool:GetAttribute("Cooldown") then
                                    tool:SetAttribute("Cooldown", 0)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- 3. Auto Perfect Skill-Check
task.spawn(function()
    while true do
        task.wait(0.1)
        if getgenv().AutoPerfectSkillCheck then
            pcall(function()
                for _, ui in ipairs(LocalPlayer.PlayerGui:GetDescendants()) do
                    if ui:IsA("TextButton") or ui:IsA("Frame") then
                        if ui.Name:lower():find("skillcheck") or ui.Name:lower():find("circle") or ui.Name:lower():find("check") then
                            -- Simulate click or remote fire for skillcheck success
                            for _, remote in ipairs(Workspace:GetDescendants()) do
                                if remote:IsA("RemoteEvent") and (remote.Name:lower():find("skill") or remote.Name:lower():find("check") or remote.Name:lower():find("repair")) then
                                    pcall(function() remote:FireServer(true) end)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

print("Violence District Features loaded successfully.")
