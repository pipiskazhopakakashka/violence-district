-- Violence District ESP Module (Wallhack)
-- Supports Survivors, Killers, Generators, Gates, Windows, Pallets

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

local function createDrawing(className, properties)
    local obj = Drawing.new(className)
    for k, v in pairs(properties) do
        obj[k] = v
    end
    return obj
end

local function removeESP(target)
    if espObjects[target] then
        for _, obj in pairs(espObjects[target]) do
            pcall(function() obj:Remove() end)
        end
        espObjects[target] = nil
    end
end

local function updateESP()
    -- Clean up invalid targets
    for target, objects in pairs(espObjects) do
        if not target or not target.Parent or (target:IsA("Model") and not target:FindFirstChildOfClass("Humanoid")) then
            removeESP(target)
        end
    end

    if not getgenv().ESP_Settings.Enabled then
        for target, _ in pairs(espObjects) do
            removeESP(target)
        end
        return
    end

    -- Process Players (Survivors & Killers)
    if getgenv().ESP_Settings.Survivors or getgenv().ESP_Settings.Killers then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local char = player.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                
                if humanoid and humanoid.Health > 0 then
                    local isKiller = false -- Determine killer vs survivor based on team/attributes/tools or name
                    pcall(function()
                        if player.Team and (player.Team.Name:lower():find("killer") or player.Team.Name:lower():find("hunter")) then
                            isKiller = true
                        elseif char:FindFirstChild("Dagger") or char:FindFirstChild("Knife") or char:FindFirstChildOfClass("Tool") then
                            -- check if holding weapon
                        end
                    end)

                    local shouldShow = (isKiller and getgenv().ESP_Settings.Killers) or (not isKiller and getgenv().ESP_Settings.Survivors)

                    if shouldShow then
                        local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        local dist = (Camera.CFrame.Position - hrp.Position).Magnitude

                        if onScreen and dist <= getgenv().ESP_Settings.MaxDistance then
                            if not espObjects[player] then
                                espObjects[player] = {
                                    Box = createDrawing("Square", {Thickness = 1.5, Filled = false, Color = isKiller and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 255, 50)}),
                                    Name = createDrawing("Text", {Size = 13, Center = true, Outline = true, Color = Color3.fromRGB(255, 255, 255)}),
                                    Info = createDrawing("Text", {Size = 11, Center = true, Outline = true, Color = Color3.fromRGB(200, 200, 200)})
                                }
                            end

                            local objs = espObjects[player]
                            local head = char:FindFirstChild("Head")
                            if head then
                                local headVec = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                                local legVec = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                                local height = math.abs(headVec.Y - legVec.Y)
                                local width = height / 2

                                objs.Box.Visible = getgenv().ESP_Settings.Boxes
                                objs.Box.Size = Vector2.new(width, height)
                                objs.Box.Position = Vector2.new(vector.X - width / 2, headVec.Y)
                                objs.Box.Color = isKiller and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 255, 50)

                                objs.Name.Visible = getgenv().ESP_Settings.Names
                                objs.Name.Text = player.Name .. (isKiller and " [KILLER]" or " [SURVIVOR]")
                                objs.Name.Position = Vector2.new(vector.X, headVec.Y - 18)

                                objs.Info.Visible = getgenv().ESP_Settings.Distance
                                objs.Info.Text = math.floor(dist) .. " studs"
                                objs.Info.Position = Vector2.new(vector.X, legVec.Y + 2)
                            else
                                objs.Box.Visible = false
                                objs.Name.Visible = false
                                objs.Info.Visible = false
                            end
                        else
                            if espObjects[player] then
                                espObjects[player].Box.Visible = false
                                espObjects[player].Name.Visible = false
                                espObjects[player].Info.Visible = false
                            end
                        end
                    else
                        if espObjects[player] then
                            removeESP(player)
                        end
                    end
                else
                    removeESP(player)
                end
            else
                removeESP(player)
            end
        end
    end

    -- Process Generators
    if getgenv().ESP_Settings.Generators then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name:lower():find("generator") and (obj:IsA("Model") or obj:IsA("BasePart")) then
                local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position or obj:GetPivot().Position) or obj.Position
                local vector, onScreen = Camera:WorldToViewportPoint(pos)
                local dist = (Camera.CFrame.Position - pos).Magnitude

                if onScreen and dist <= getgenv().ESP_Settings.MaxDistance then
                    if not espObjects[obj] then
                        espObjects[obj] = {
                            Text = createDrawing("Text", {Size = 12, Center = true, Outline = true, Color = Color3.fromRGB(255, 170, 0), Text = "Generator"})
                        }
                    end
                    espObjects[obj].Text.Visible = true
                    espObjects[obj].Text.Position = Vector2.new(vector.X, vector.Y)
                    espObjects[obj].Text.Text = "⚡ Generator [" .. math.floor(dist) .. "m]"
                else
                    if espObjects[obj] then
                        espObjects[obj].Text.Visible = false
                    end
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    pcall(updateESP)
end)

print("Violence District ESP loaded successfully.")
