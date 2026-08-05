-- Module: ESP (Wallhack)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

getgenv().ESP_Settings = getgenv().ESP_Settings or {
    Enabled = true,
    Survivors = true,
    Killers = true,
    Generators = true,
    Boxes = true,
    Names = true,
    MaxDistance = 5000,
}

local espObjects = {}

local function removeESP(target)
    if espObjects[target] then
        for _, obj in pairs(espObjects[target]) do
            pcall(function() obj:Remove() end)
        end
        espObjects[target] = nil
    end
end

RunService.RenderStepped:Connect(function()
    pcall(function()
        if not getgenv().ESP_Settings.Enabled then
            for t, _ in pairs(espObjects) do removeESP(t) end
            return
        end

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local char = player.Character
                local hrp = char.HumanoidRootPart
                local hum = char:FindFirstChildOfClass("Humanoid")
                
                if hum and hum.Health > 0 then
                    local isKiller = false
                    pcall(function()
                        if player.Team and player.Team.Name:lower():find("killer") then isKiller = true end
                    end)

                    local shouldShow = (isKiller and getgenv().ESP_Settings.Killers) or (not isKiller and getgenv().ESP_Settings.Survivors)
                    if shouldShow then
                        local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        local dist = (Camera.CFrame.Position - hrp.Position).Magnitude

                        if onScreen and dist <= getgenv().ESP_Settings.MaxDistance then
                            if not espObjects[player] then
                                espObjects[player] = {
                                    Box = Drawing.new("Square"),
                                    Name = Drawing.new("Text")
                                }
                                espObjects[player].Box.Thickness = 1
                                espObjects[player].Box.Filled = false
                                espObjects[player].Name.Size = 12
                                espObjects[player].Name.Center = true
                                espObjects[player].Name.Outline = true
                            end

                            local objs = espObjects[player]
                            local head = char:FindFirstChild("Head")
                            if head then
                                local headVec = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                                local legVec = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                                local h = math.abs(headVec.Y - legVec.Y)
                                local w = h / 2

                                objs.Box.Visible = getgenv().ESP_Settings.Boxes
                                objs.Box.Size = Vector2.new(w, h)
                                objs.Box.Position = Vector2.new(vector.X - w / 2, headVec.Y)
                                objs.Box.Color = isKiller and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 255, 50)

                                objs.Name.Visible = getgenv().ESP_Settings.Names
                                objs.Name.Text = player.Name
                                objs.Name.Position = Vector2.new(vector.X, headVec.Y - 16)
                                objs.Name.Color = Color3.fromRGB(255, 255, 255)
                            end
                        else
                            removeESP(player)
                        end
                    else
                        removeESP(player)
                    end
                else
                    removeESP(player)
                end
            else
                removeESP(player)
            end
        end
    end)
end)

print("[VD Module] ESP loaded.")
