-- Module: Complete ESP & Wallhack Suite

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
    Gates = true,
    Boxes = true,
    Names = true,
    Distance = true,
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

        -- Players ESP
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
                                    Name = Drawing.new("Text"),
                                    Info = Drawing.new("Text")
                                }
                                espObjects[player].Box.Thickness = 1.5
                                espObjects[player].Box.Filled = false
                                espObjects[player].Name.Size = 12
                                espObjects[player].Name.Center = true
                                espObjects[player].Name.Outline = true
                                espObjects[player].Info.Size = 11
                                espObjects[player].Info.Center = true
                                espObjects[player].Info.Outline = true
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
                                objs.Name.Text = player.Name .. (isKiller and " [KILLER]" or " [SURVIVOR]")
                                objs.Name.Position = Vector2.new(vector.X, headVec.Y - 16)
                                objs.Name.Color = Color3.fromRGB(255, 255, 255)

                                objs.Info.Visible = getgenv().ESP_Settings.Distance
                                objs.Info.Text = math.floor(dist) .. " studs"
                                objs.Info.Position = Vector2.new(vector.X, legVec.Y + 2)
                                objs.Info.Color = Color3.fromRGB(200, 200, 200)
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

        -- Generators ESP
        if getgenv().ESP_Settings.Generators then
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("generator") and (obj:IsA("Model") or obj:IsA("BasePart")) then
                    local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position or obj:GetPivot().Position) or obj.Position
                    local vector, onScreen = Camera:WorldToViewportPoint(pos)
                    local dist = (Camera.CFrame.Position - pos).Magnitude

                    if onScreen and dist <= getgenv().ESP_Settings.MaxDistance then
                        if not espObjects[obj] then
                            espObjects[obj] = { Text = Drawing.new("Text") }
                            espObjects[obj].Text.Size = 12
                            espObjects[obj].Text.Center = true
                            espObjects[obj].Text.Outline = true
                            espObjects[obj].Text.Color = Color3.fromRGB(255, 170, 0)
                        end
                        espObjects[obj].Text.Visible = true
                        espObjects[obj].Text.Position = Vector2.new(vector.X, vector.Y)
                        espObjects[obj].Text.Text = "⚡ Generator [" .. math.floor(dist) .. "m]"
                    else
                        if espObjects[obj] then espObjects[obj].Text.Visible = false end
                    end
                end
            end
        end
    end)
end)

print("[VD Module] Advanced ESP loaded.")
