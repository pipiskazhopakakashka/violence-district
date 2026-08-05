-- Module: Features (Auto Generator & No CD Dagger)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

getgenv().AutoGenerator = false
getgenv().AutoPerfectSkillCheck = false
getgenv().NoCDDagger = false

-- 1. Auto Generator Logic with Safe Exit
task.spawn(function()
    while true do
        task.wait(0.4)
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

-- 2. No CD Dagger Logic
task.spawn(function()
    while true do
        task.wait(0.2)
        if getgenv().NoCDDagger then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    for _, tool in ipairs(char:GetChildren()) do
                        if tool:IsA("Tool") and (tool.Name:lower():find("dagger") or tool.Name:lower():find("knife")) then
                            if tool:GetAttribute("Cooldown") then tool:SetAttribute("Cooldown", 0) end
                        end
                    end
                end
            end)
        end
    end
end)

print("[VD Module] Features loaded.")
