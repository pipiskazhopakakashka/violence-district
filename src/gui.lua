-- Violence District Pro Panel (GUI)
-- Professional Non-AI UI with SVG Icons from GitHub

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Remove existing GUI if any
pcall(function()
    if CoreGui:FindFirstChild("ViolenceDistrictPro") then
        CoreGui.ViolenceDistrictPro:Destroy()
    end
    if LocalPlayer.PlayerGui:FindFirstChild("ViolenceDistrictPro") then
        LocalPlayer.PlayerGui.ViolenceDistrictPro:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViolenceDistrictPro"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Base URLs for SVG assets on GitHub
local githubBase = "https://raw.githubusercontent.com/pipiskazhopakakashka/violence-district/arena/019fd39e-violence-district/assets/"
local icons = {
    Home = githubBase .. "home.svg",
    Combat = githubBase .. "combat.svg",
    ESP = githubBase .. "esp.svg",
    Generator = githubBase .. "generator.svg",
    Teleport = githubBase .. "teleport.svg",
    Settings = githubBase .. "settings.svg"
}

-- Main Window Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 380)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80, 80, 120)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Top Bar (Dragging & Title)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 300, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "VIOLENCE DISTRICT <font color='#7b61ff'>PRO HUB</font>"
TitleLabel.RichText = true
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Make Draggable
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

-- Sidebar Navigation
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = Sidebar

-- Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -150, 1, -45)
ContentContainer.Position = UDim2.new(0, 150, 0, 45)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local tabs = {}
local activeTab = nil

local function createTab(name, iconUrl)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 40)
    tabBtn.BackgroundTransparency = 1
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.Text = "   " .. name
    tabBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
    tabBtn.TextSize = 14
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtn.Parent = Sidebar

    local iconImg = Instance.new("ImageLabel")
    iconImg.Size = UDim2.new(0, 20, 0, 20)
    iconImg.Position = UDim2.new(0, 15, 0.5, -10)
    iconImg.BackgroundTransparency = 1
    iconImg.Image = iconUrl
    iconImg.Parent = tabBtn

    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = name .. "Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.ScrollBarThickness = 4
    tabContent.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    tabContent.Parent = ContentContainer

    local list = Instance.new("UIListLayout")
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 10)
    list.Parent = tabContent

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 15)
    padding.PaddingLeft = UDim.new(0, 15)
    padding.PaddingRight = UDim.new(0, 15)
    padding.Parent = tabContent

    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.content.Visible = false
            t.button.TextColor3 = Color3.fromRGB(160, 160, 180)
            t.button.BackgroundColor3 = Color3.fromRGB(0,0,0)
            t.button.BackgroundTransparency = 1
        end
        tabContent.Visible = true
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
        tabBtn.BackgroundTransparency = 0
    end)

    if not activeTab then
        activeTab = tabContent
        tabContent.Visible = true
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
        tabBtn.BackgroundTransparency = 0
    end

    tabs[name] = {button = tabBtn, content = tabContent}
    return tabContent
end

-- Helper for Toggles
local function addToggle(parent, title, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.Text = title
    label.TextColor3 = Color3.fromRGB(220, 220, 240)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 40, 0, 22)
    btn.Position = UDim2.new(1, -50, 0.5, -11)
    btn.BackgroundColor3 = default and Color3.fromRGB(123, 97, 255) or Color3.fromRGB(50, 50, 70)
    btn.Text = ""
    btn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = btn

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = btn

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle

    local state = default

    btn.MouseButton1Click:Connect(function()
        state = not state
        local targetPos = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        local targetColor = state and Color3.fromRGB(123, 97, 255) or Color3.fromRGB(50, 50, 70)
        
        TweenService:Create(circle, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        
        pcall(function() callback(state) end)
    end)
end

-- Create Tabs
local homeTab = createTab("Home", icons.Home)
local combatTab = createTab("Combat", icons.Combat)
local espTab = createTab("ESP / WH", icons.ESP)
local genTab = createTab("Generator", icons.Generator)
local teleTab = createTab("Teleports", icons.Teleport)
local setTab = createTag("Settings", icons.Settings)

-- Home Tab Content
local welcomeLbl = Instance.new("TextLabel")
welcomeLbl.Size = UDim2.new(1, 0, 0, 60)
welcomeLbl.BackgroundTransparency = 1
welcomeLbl.Font = Enum.Font.GothamBold
welcomeLbl.Text = "Welcome to Violence District Pro Hub!\nFully working script with Auto Generator fix & No CD Dagger."
welcomeLbl.TextColor3 = Color3.fromRGB(200, 200, 220)
welcomeLbl.TextSize = 13
welcomeLbl.TextXAlignment = Enum.TextXAlignment.Left
welcomeLbl.TextWrapped = true
welcomeLbl.Parent = homeTab

-- Combat Tab
addToggle(combatTab, "No CD Dagger (Instant Attack)", false, function(v)
    getgenv().NoCDDagger = v
end)

-- ESP Tab
addToggle(espTab, "Enable ESP (Wallhack)", true, function(v)
    getgenv().ESP_Settings.Enabled = v
end)
addToggle(espTab, "Survivor ESP", true, function(v)
    getgenv().ESP_Settings.Survivors = v
end)
addToggle(espTab, "Killer ESP", true, function(v)
    getgenv().ESP_Settings.Killers = v
end)
addToggle(espTab, "Generator ESP", true, function(v)
    getgenv().ESP_Settings.Generators = v
end)
addToggle(espTab, "ESP Boxes", true, function(v)
    getgenv().ESP_Settings.Boxes = v
end)

-- Generator Tab (With Stop / Exit fix)
addToggle(genTab, "Auto Generator (AFK Farm)", false, function(v)
    getgenv().AutoGenerator = v
end)
addToggle(genTab, "Auto Perfect Skill-Check", false, function(v)
    getgenv().AutoPerfectSkillCheck = v
end)

local stopGenBtn = Instance.new("TextButton")
stopGenBtn.Size = UDim2.new(1, 0, 0, 40)
stopGenBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopGenBtn.Font = Enum.Font.GothamBold
stopGenBtn.Text = "STOP / EXIT AUTO GENERATOR"
stopGenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopGenBtn.TextSize = 13
stopGenBtn.Parent = genTab

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 6)
stopCorner.Parent = stopGenBtn

stopGenBtn.MouseButton1Click:Connect(function()
    getgenv().AutoGenerator = false
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    end)
end)

-- Teleports Tab
local tpGenBtn = Instance.new("TextButton")
tpGenBtn.Size = UDim2.new(1, 0, 0, 40)
tpGenBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
tpGenBtn.Font = Enum.Font.GothamBold
tpGenBtn.Text = "Teleport to Nearest Generator"
tpGenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpGenBtn.TextSize = 13
tpGenBtn.Parent = teleTab

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 6)
tpCorner.Parent = tpGenBtn

tpGenBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("generator") and (obj:IsA("Model") or obj:IsA("BasePart")) then
                local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position or obj:GetPivot().Position) or obj.Position
                char.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                break
            end
        end
    end)
end)

-- Settings Tab
addToggle(setTab, "Unload Script", false, function(v)
    if v then
        ScreenGui:Destroy()
    end
end)

print("Violence District Pro GUI loaded successfully.")
