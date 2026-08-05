-- Module: Full Game Features (No CD Dagger, Auto Generator with Safe Stop, Skill Checks)

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

getgenv().AutoGenerator = false
getgenv().AutoPerfectSkillCheck = false
getgenv().NoCDDagger = false

-- 1. Auto Generator AFK Farm with Safe Exit
task.spawn(function()
    while true do
        task.wait(0.3)
        if getgenv().AutoGenerator then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart

                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj.Name:lower():find("generator") and (obj:IsA("Model") or obj:IsA("BasePart")) then
                        local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position or obj:GetPivot().Position) or obj.Position
                        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                        
                        for _, remote in ipairs(Workspace:GetDescendants()) do
                            if remote:IsA("RemoteEvent") and (remote.Name:lower():find("repair") or remote.Name:lower():find("gen")) then
                                remote:FireServer(obj)
                            end
                        end
                        break
                    end
                end
            end)
        end
    end
end)

-- 2. No CD Dagger (Instant Attack)
task.spawn(function()
    while true do
        task.wait(0.15)
        if getgenv().NoCDDagger then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    for _, tool in ipairs(char:GetChildren()) do
                        if tool:IsA("Tool") and (tool.Name:lower():find("dagger") or tool.Name:lower():find("knife") or tool.Name:lower():find("weapon")) then
                            if tool:GetAttribute("Cooldown") then tool:SetAttribute("Cooldown", 0) end
                            if tool:FindFirstChild("Cooldown") then tool.Cooldown.Value = 0 end
                        end
                    end
                    local backpack = LocalPlayer:FindFirstChild("Backpack")
                    if backpack then
                        for _, tool in ipairs(backpack:GetChildren()) do
                            if tool:IsA("Tool") and (tool.Name:lower():find("dagger") or tool.Name:lower():find("knife")) then
                                if tool:GetAttribute("Cooldown") then tool:SetAttribute("Cooldown", 0) end
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
                for _, remote in ipairs(Workspace:GetDescendants()) do
                    if remote:IsA("RemoteEvent") and (remote.Name:lower():find("skill") or remote.Name:lower():find("check") or remote.Name:lower():find("repair")) then
                        remote:FireServer(true)
                    end
                end
            end)
        end
    end
end)

print("[VD Module] Game features loaded.")
