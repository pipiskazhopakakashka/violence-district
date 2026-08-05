-- Module: Neverlose CS2 UI Panel (1-1 Pixel-Perfect Layout)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    if CoreGui:FindFirstChild("NeverloseCS2Master") then CoreGui.NeverloseCS2Master:Destroy() end
    if LocalPlayer.PlayerGui:FindFirstChild("NeverloseCS2Master") then LocalPlayer.PlayerGui.NeverloseCS2Master:Destroy() end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeverloseCS2Master"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Main Window (Neverlose CS2 Dark Theme)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 860, 0, 540)
MainFrame.Position = UDim2.new(0.5, -430, 0.5, -270)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 19)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(35, 42, 58)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 48)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 18, 25)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 6)
TopCorner.Parent = TopBar

-- Logo "NEVERLOSE"
local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(0, 160, 1, 0)
LogoLabel.Position = UDim2.new(0, 16, 0, 0)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.Text = "NEVER<font color='#2f78ff'>LOSE</font>"
LogoLabel.RichText = true
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.TextSize = 16
LogoLabel.TextXAlignment = Enum.TextXAlignment.Left
LogoLabel.Parent = TopBar

-- Save Button
local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(0, 75, 0, 28)
SaveBtn.Position = UDim2.new(0, 175, 0.5, -14)
SaveBtn.BackgroundColor3 = Color3.fromRGB(22, 27, 38)
SaveBtn.BorderSizePixel = 0
SaveBtn.Font = Enum.Font.GothamMedium
SaveBtn.Text = "Save"
SaveBtn.TextColor3 = Color3.fromRGB(200, 210, 230)
SaveBtn.TextSize = 12
SaveBtn.Parent = TopBar

local SaveCorner = Instance.new("UICorner")
SaveCorner.CornerRadius = UDim.new(0, 4)
SaveCorner.Parent = SaveBtn

SaveBtn.MouseButton1Click:Connect(function()
    SaveBtn.Text = "Saved!"
    task.delay(1, function() SaveBtn.Text = "Save" end)
end)

-- Config Dropdown Selector
local ConfigBox = Instance.new("Frame")
ConfigBox.Size = UDim2.new(0, 150, 0, 28)
ConfigBox.Position = UDim2.new(0, 260, 0.5, -14)
ConfigBox.BackgroundColor3 = Color3.fromRGB(22, 27, 38)
ConfigBox.BorderSizePixel = 0
ConfigBox.Parent = TopBar

local ConfigCorner = Instance.new("UICorner")
ConfigCorner.CornerRadius = UDim.new(0, 4)
ConfigCorner.Parent = ConfigBox

local ConfigText = Instance.new("TextLabel")
ConfigText.Size = UDim2.new(1, -12, 1, 0)
ConfigText.Position = UDim2.new(0, 10, 0, 0)
ConfigText.BackgroundTransparency = 1
ConfigText.Font = Enum.Font.GothamMedium
ConfigText.Text = "Global v1 ▾"
ConfigText.TextColor3 = Color3.fromRGB(220, 230, 250)
ConfigText.TextSize = 12
ConfigText.TextXAlignment = Enum.TextXAlignment.Left
ConfigText.Parent = ConfigBox

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 45, 45)
CloseBtn.BorderSizePixel = 0
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Draggable implementation
local dragging, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- Left Sidebar
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 175, 1, -48)
Sidebar.Position = UDim2.new(0, 0, 0, 48)
Sidebar.BackgroundColor3 = Color3.fromRGB(9, 11, 15)
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.Parent = MainFrame

local SidebarList = Instance.new("UIListLayout")
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0, 2)
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.PaddingBottom = UDim.new(0, 65)
SidebarPadding.Parent = Sidebar

-- User Profile at bottom of Sidebar
local UserProfile = Instance.new("Frame")
UserProfile.Size = UDim2.new(1, -16, 0, 52)
UserProfile.Position = UDim2.new(0, 8, 1, -60)
UserProfile.BackgroundColor3 = Color3.fromRGB(15, 19, 26)
UserProfile.BorderSizePixel = 0
UserProfile.Parent = Sidebar

local UserCorner = Instance.new("UICorner")
UserCorner.CornerRadius = UDim.new(0, 4)
UserCorner.Parent = UserProfile

local AvatarCircle = Instance.new("Frame")
AvatarCircle.Size = UDim2.new(0, 32, 0, 32)
AvatarCircle.Position = UDim2.new(0, 8, 0.5, -16)
AvatarCircle.BackgroundColor3 = Color3.fromRGB(47, 120, 255)
AvatarCircle.Parent = UserProfile

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarCircle

local AvatarText = Instance.new("TextLabel")
AvatarText.Size = UDim2.new(1, 0, 1, 0)
AvatarText.BackgroundTransparency = 1
AvatarText.Font = Enum.Font.GothamBold
AvatarText.Text = "PAK"
AvatarText.TextColor3 = Color3.fromRGB(255, 255, 255)
AvatarText.TextSize = 11
AvatarText.Parent = AvatarCircle

local UserName = Instance.new("TextLabel")
UserName.Size = UDim2.new(0, 100, 0, 16)
UserName.Position = UDim2.new(0, 46, 0, 10)
UserName.BackgroundTransparency = 1
UserName.Font = Enum.Font.GothamBold
UserName.Text = "PAKETA"
UserName.TextColor3 = Color3.fromRGB(240, 245, 255)
UserName.TextSize = 12
UserName.TextXAlignment = Enum.TextXAlignment.Left
UserName.Parent = UserProfile

local UserStatus = Instance.new("TextLabel")
UserStatus.Size = UDim2.new(0, 100, 0, 14)
UserStatus.Position = UDim2.new(0, 46, 0, 26)
UserStatus.BackgroundTransparency = 1
UserStatus.Font = Enum.Font.GothamMedium
UserStatus.Text = "Till: <font color='#2f78ff'>01.01 03:00</font>"
UserStatus.RichText = true
UserStatus.TextColor3 = Color3.fromRGB(130, 145, 170)
UserStatus.TextSize = 10
UserStatus.TextXAlignment = Enum.TextXAlignment.Left
UserStatus.Parent = UserProfile

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -175, 1, -48)
ContentArea.Position = UDim2.new(0, 175, 0, 48)
ContentArea.BackgroundColor3 = Color3.fromRGB(12, 14, 19)
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

-- Right Bones Preview Panel (Neverlose CS2 style)
local RightPreview = Instance.new("Frame")
RightPreview.Name = "RightPreview"
RightPreview.Size = UDim2.new(0, 260, 1, -16)
RightPreview.Position = UDim2.new(1, -268, 0, 8)
RightPreview.BackgroundColor3 = Color3.fromRGB(15, 18, 25)
RightPreview.BorderSizePixel = 0
RightPreview.Parent = ContentArea

local PreviewCorner = Instance.new("UICorner")
PreviewCorner.CornerRadius = UDim.new(0, 6)
PreviewCorner.Parent = RightPreview

local PreviewStroke = Instance.new("UIStroke")
PreviewStroke.Color = Color3.fromRGB(30, 38, 52)
PreviewStroke.Thickness = 1
PreviewStroke.Parent = RightPreview

local PreviewTitle = Instance.new("TextLabel")
PreviewTitle.Size = UDim2.new(1, 0, 0, 32)
PreviewTitle.Position = UDim2.new(0, 0, 0, 5)
PreviewTitle.BackgroundTransparency = 1
PreviewTitle.Font = Enum.Font.GothamBold
PreviewTitle.Text = "Legitbot Bones"
PreviewTitle.TextColor3 = Color3.fromRGB(190, 205, 230)
PreviewTitle.TextSize = 13
PreviewTitle.Parent = RightPreview

local BonesBox = Instance.new("Frame")
BonesBox.Size = UDim2.new(1, -20, 1, -45)
BonesBox.Position = UDim2.new(0, 10, 0, 35)
BonesBox.BackgroundColor3 = Color3.fromRGB(9, 11, 15)
BonesBox.BorderSizePixel = 0
BonesBox.Parent = RightPreview

local BonesCorner = Instance.new("UICorner")
BonesCorner.CornerRadius = UDim.new(0, 4)
BonesCorner.Parent = BonesBox

local function addBoneDot(x, y)
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = UDim2.new(x, -5, y, -5)
    dot.BackgroundColor3 = Color3.fromRGB(47, 120, 255)
    dot.BorderSizePixel = 0
    dot.Parent = BonesBox
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = dot
end

addBoneDot(0.5, 0.2)
addBoneDot(0.5, 0.32)
addBoneDot(0.5, 0.45)
addBoneDot(0.5, 0.58)
addBoneDot(0.35, 0.45)
addBoneDot(0.65, 0.45)

-- Left Tabs Container
local TabsContainer = Instance.new("Frame")
TabsContainer.Size = UDim2.new(1, -275, 1, 0)
TabsContainer.Position = UDim2.new(0, 0, 0, 0)
TabsContainer.BackgroundTransparency = 1
TabsContainer.Parent = ContentArea

local tabs = {}
local activeTabContent = nil

local function createCategoryHeader(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "  " .. text:upper()
    lbl.TextColor3 = Color3.fromRGB(80, 95, 120)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = Sidebar
end

local function createTabButton(tabName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundTransparency = 1
    btn.Font = Enum.Font.GothamMedium
    btn.Text = "     " .. tabName
    btn.TextColor3 = Color3.fromRGB(140, 155, 180)
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 3, 0, 16)
    indicator.Position = UDim2.new(0, 0, 0.5, -8)
    indicator.BackgroundColor3 = Color3.fromRGB(47, 120, 255)
    indicator.BorderSizePixel = 0
    indicator.BackgroundTransparency = 1
    indicator.Parent = btn

    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = tabName .. "Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.ScrollBarThickness = 3
    tabContent.CanvasSize = UDim2.new(0, 0, 1.4, 0)
    tabContent.Parent = TabsContainer

    local list = Instance.new("UIListLayout")
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 12)
    list.Parent = tabContent

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 15)
    padding.PaddingLeft = UDim.new(0, 15)
    padding.PaddingRight = UDim.new(0, 15)
    padding.Parent = tabContent

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.content.Visible = false
            t.button.TextColor3 = Color3.fromRGB(140, 155, 180)
            t.button.BackgroundTransparency = 1
            t.indicator.BackgroundTransparency = 1
        end
        tabContent.Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
        btn.BackgroundTransparency = 0
        indicator.BackgroundTransparency = 0
        activeTabContent = tabContent
    end)

    if not activeTabContent then
        activeTabContent = tabContent
        tabContent.Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
        btn.BackgroundTransparency = 0
        indicator.BackgroundTransparency = 0
    end

    tabs[tabName] = {button = btn, content = tabContent, indicator = indicator}
    return tabContent
end

-- Build Neverlose CS2 Sidebar Hierarchy
createCategoryHeader("Aimbot")
local rageTab = createTabButton("Ragebot")
local antiAimTab = createTabButton("Anti Aim")
local legitTab = createTabButton("Legitbot")

createCategoryHeader("Visuals")
local playersTab = createTabButton("Players")
local weaponTab = createTabButton("Weapon")
local worldTab = createTabButton("World")

createCategoryHeader("Miscellaneous")
local mainMiscTab = createTabButton("Main")
local inventoryTab = createTabButton("Inventory")
local scriptsTab = createTabButton("Scripts")
local configsTab = createTabButton("Configs")

-- UI Helpers: Section Card & Toggle
local function createSectionCard(parent, title, height)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, height)
    card.BackgroundColor3 = Color3.fromRGB(15, 18, 25)
    card.BorderSizePixel = 0
    card.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    card.Parent = card

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(30, 38, 52)
    stroke.Thickness = 1
    stroke.Parent = card

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -20, 0, 30)
    titleLbl.Position = UDim2.new(0, 12, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.Text = title
    titleLbl.TextColor3 = Color3.fromRGB(220, 230, 250)
    titleLbl.TextSize = 12
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = card

    local innerList = Instance.new("UIListLayout")
    innerList.SortOrder = Enum.SortOrder.LayoutOrder
    innerList.Padding = UDim.new(0, 10)
    innerList.Parent = card

    local innerPadding = Instance.new("UIPadding")
    innerPadding.PaddingTop = UDim.new(0, 35)
    innerPadding.PaddingLeft = UDim.new(0, 12)
    innerPadding.PaddingRight = UDim.new(0, 12)
    innerPadding.Parent = card

    return card
end

local function addToggleToCard(card, title, default, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 28)
    row.BackgroundTransparency = 1
    row.Parent = card

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -50, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamMedium
    lbl.Text = title
    lbl.TextColor3 = Color3.fromRGB(180, 195, 220)
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 36, 0, 20)
    btn.Position = UDim2.new(1, -36, 0.5, -10)
    btn.BackgroundColor3 = default and Color3.fromRGB(47, 120, 255) or Color3.fromRGB(28, 35, 48)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = row

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = btn

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = btn

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle

    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        circle.Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        btn.BackgroundColor3 = state and Color3.fromRGB(47, 120, 255) or Color3.fromRGB(28, 35, 48)
        pcall(function() callback(state) end)
    end)
end

-- Populate All Neverlose Tabs with Features

-- 1. Legitbot Tab (Dagger & Skillchecks)
local legitCard = createSectionCard(legitTab, "Legitbot Dagger & Combat", 130)
addToggleToCard(legitCard, "No CD Dagger (Instant Attack)", false, function(v) getgenv().NoCDDagger = v end)
addToggleToCard(legitCard, "Auto Perfect Skill-Check", false, function(v) getgenv().AutoPerfectSkillCheck = v end)

-- 2. Players Tab (ESP Suite)
local espCard = createSectionCard(playersTab, "Players ESP & Wallhack", 200)
addToggleToCard(espCard, "Enable ESP (Wallhack)", true, function(v) getgenv().ESP_Settings.Enabled = v end)
addToggleToCard(espCard, "Survivor ESP", true, function(v) getgenv().ESP_Settings.Survivors = v end)
addToggleToCard(espCard, "Killer ESP", true, function(v) getgenv().ESP_Settings.Killers = v end)
addToggleToCard(espCard, "ESP Boxes", true, function(v) getgenv().ESP_Settings.Boxes = v end)

-- 3. World Tab (Generators ESP)
local worldCard = createSectionCard(worldTab, "World & Objective ESP", 100)
addToggleToCard(worldCard, "Generator ESP", true, function(v) getgenv().ESP_Settings.Generators = v end)

-- 4. Main Tab (Auto Generator Farm & Safe Exit)
local farmCard = createSectionCard(mainMiscTab, "Auto Generator Farm", 140)
addToggleToCard(farmCard, "Auto Generator (AFK Farm)", false, function(v) getgenv().AutoGenerator = v end)

local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(1, 0, 0, 32)
stopBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
stopBtn.BorderSizePixel = 0
stopBtn.Font = Enum.Font.GothamBold
stopBtn.Text = "STOP / EXIT AUTO GENERATOR"
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.TextSize = 11
stopBtn.Parent = mainMiscTab

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 4)
stopCorner.Parent = stopBtn

stopBtn.MouseButton1Click:Connect(function()
    getgenv().AutoGenerator = false
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    end)
end)

-- 5. Scripts Tab (Teleports)
local tpCard = createSectionCard(scriptsTab, "Teleport Utility", 100)
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(1, 0, 0, 34)
tpBtn.BackgroundColor3 = Color3.fromRGB(47, 120, 255)
tpBtn.BorderSizePixel = 0
tpBtn.Font = Enum.Font.GothamBold
tpBtn.Text = "Teleport to Nearest Generator"
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.TextSize = 12
tpBtn.Parent = scriptsTab

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 4)
tpCorner.Parent = tpBtn

tpBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name:lower():find("generator") and (obj:IsA("Model") or obj:IsA("BasePart")) then
                local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position or obj:GetPivot().Position) or obj.Position
                char.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                break
            end
        end
    end)
end)

-- 6. Configs Tab (Unload)
local confCard = createSectionCard(configsTab, "Config & Script Management", 100)
addToggleToCard(confCard, "Unload Script & GUI", false, function(v)
    if v then ScreenGui:Destroy() end
end)

print("[VD Module] Neverlose CS2 Master Panel loaded.")
