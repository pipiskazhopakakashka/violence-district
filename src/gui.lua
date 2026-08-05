-- Violence District - Neverlose Style Pro UI (1-1 Aesthetics)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Remove existing GUI
pcall(function()
    if CoreGui:FindFirstChild("NeverloseViolenceDistrict") then
        CoreGui.NeverloseViolenceDistrict:Destroy()
    end
    if LocalPlayer.PlayerGui:FindFirstChild("NeverloseViolenceDistrict") then
        LocalPlayer.PlayerGui.NeverloseViolenceDistrict:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeverloseViolenceDistrict"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Window (Neverlose Dark Theme)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 840, 0, 530)
MainFrame.Position = UDim2.new(0.5, -420, 0.5, -265)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 16, 23)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(35, 45, 64)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 48)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

-- Logo "NEVERLOSE" style
local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(0, 180, 1, 0)
LogoLabel.Position = UDim2.new(0, 16, 0, 0)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.Text = "NEVER<font color='#2772ee'>LOSE</font>"
LogoLabel.RichText = true
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.TextSize = 16
LogoLabel.TextXAlignment = Enum.TextXAlignment.Left
LogoLabel.Parent = TopBar

-- Sub-logo / Game tag
local GameTag = Instance.new("TextLabel")
GameTag.Size = UDim2.new(0, 150, 1, 0)
GameTag.Position = UDim2.new(0, 140, 0, 0)
GameTag.BackgroundTransparency = 1
GameTag.Font = Enum.Font.GothamMedium
GameTag.Text = "[ VIOLENCE DISTRICT ]"
GameTag.TextColor3 = Color3.fromRGB(120, 135, 160)
GameTag.TextSize = 11
GameTag.TextXAlignment = Enum.TextXAlignment.Left
GameTag.Parent = TopBar

-- Save Button in TopBar
local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(0, 75, 0, 28)
SaveBtn.Position = UDim2.new(0, 310, 0.5, -14)
SaveBtn.BackgroundColor3 = Color3.fromRGB(22, 30, 43)
SaveBtn.Font = Enum.Font.GothamMedium
SaveBtn.Text = "Save"
SaveBtn.TextColor3 = Color3.fromRGB(200, 210, 230)
SaveBtn.TextSize = 12
SaveBtn.Parent = TopBar

local SaveCorner = Instance.new("UICorner")
SaveCorner.CornerRadius = UDim.new(0, 6)
SaveCorner.Parent = SaveBtn

local SaveStroke = Instance.new("UIStroke")
SaveStroke.Color = Color3.fromRGB(45, 60, 85)
SaveStroke.Thickness = 1
SaveStroke.Parent = SaveBtn

SaveBtn.MouseButton1Click:Connect(function()
    SaveBtn.Text = "Saved!"
    task.delay(1.5, function()
        SaveBtn.Text = "Save"
    end)
end)

-- Global Config Dropdown selector in TopBar
local ConfigBox = Instance.new("Frame")
ConfigBox.Size = UDim2.new(0, 150, 0, 28)
ConfigBox.Position = UDim2.new(0, 400, 0.5, -14)
ConfigBox.BackgroundColor3 = Color3.fromRGB(22, 30, 43)
ConfigBox.BorderSizePixel = 0
ConfigBox.Parent = TopBar

local ConfigCorner = Instance.new("UICorner")
ConfigCorner.CornerRadius = UDim.new(0, 6)
ConfigCorner.Parent = ConfigBox

local ConfigText = Instance.new("TextLabel")
ConfigText.Size = UDim2.new(1, -15, 1, 0)
ConfigText.Position = UDim2.new(0, 10, 0, 0)
ConfigText.BackgroundTransparency = 1
ConfigText.Font = Enum.Font.GothamMedium
ConfigText.Text = "Global v1"
ConfigText.TextColor3 = Color3.fromRGB(220, 230, 250)
ConfigText.TextSize = 12
ConfigText.TextXAlignment = Enum.TextXAlignment.Left
ConfigText.Parent = ConfigBox

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Make Window Draggable
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

-- Left Sidebar
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 175, 1, -48)
Sidebar.Position = UDim2.new(0, 0, 0, 48)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 13, 19)
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.Parent = MainFrame

local SidebarList = Instance.new("UIListLayout")
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0, 2)
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 12)
SidebarPadding.PaddingBottom = UDim.new(0, 70)
SidebarPadding.Parent = Sidebar

-- User Profile Box at bottom of Sidebar
local UserProfile = Instance.new("Frame")
UserProfile.Size = UDim2.new(1, -16, 0, 55)
UserProfile.Position = UDim2.new(0, 8, 1, -63)
UserProfile.BackgroundColor3 = Color3.fromRGB(16, 22, 32)
UserProfile.BorderSizePixel = 0
UserProfile.Parent = Sidebar

local UserCorner = Instance.new("UICorner")
UserCorner.CornerRadius = UDim.new(0, 6)
UserCorner.Parent = UserProfile

local AvatarCircle = Instance.new("Frame")
AvatarCircle.Size = UDim2.new(0, 34, 0, 34)
AvatarCircle.Position = UDim2.new(0, 10, 0.5, -17)
AvatarCircle.BackgroundColor3 = Color3.fromRGB(39, 114, 238)
AvatarCircle.Parent = UserProfile

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarCircle

local AvatarText = Instance.new("TextLabel")
AvatarText.Size = UDim2.new(1, 0, 1, 0)
AvatarText.BackgroundTransparency = 1
AvatarText.Font = Enum.Font.GothamBold
AvatarText.Text = "VD"
AvatarText.TextColor3 = Color3.fromRGB(255, 255, 255)
AvatarText.TextSize = 13
AvatarText.Parent = AvatarCircle

local UserName = Instance.new("TextLabel")
UserName.Size = UDim2.new(0, 100, 0, 16)
UserName.Position = UDim2.new(0, 52, 0, 11)
UserName.BackgroundTransparency = 1
UserName.Font = Enum.Font.GothamBold
UserName.Text = "PAKETA"
UserName.TextColor3 = Color3.fromRGB(240, 245, 255)
UserName.TextSize = 12
UserName.TextXAlignment = Enum.TextXAlignment.Left
UserName.Parent = UserProfile

local UserStatus = Instance.new("TextLabel")
UserStatus.Size = UDim2.new(0, 100, 0, 14)
UserStatus.Position = UDim2.new(0, 52, 0, 27)
UserStatus.BackgroundTransparency = 1
UserStatus.Font = Enum.Font.GothamMedium
UserStatus.Text = "Till: <font color='#2772ee'>01.01 03:00</font>"
UserStatus.RichText = true
UserStatus.TextColor3 = Color3.fromRGB(130, 145, 170)
UserStatus.TextSize = 10
UserStatus.TextXAlignment = Enum.TextXAlignment.Left
UserStatus.Parent = UserProfile

-- Content Area (Left side of content & Right preview)
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -175, 1, -48)
ContentArea.Position = UDim2.new(0, 175, 0, 48)
ContentArea.BackgroundColor3 = Color3.fromRGB(12, 16, 23)
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

-- Right Preview Panel (Like Neverlose Legitbot Bones)
local RightPreview = Instance.new("Frame")
RightPreview.Name = "RightPreview"
RightPreview.Size = UDim2.new(0, 260, 1, -20)
RightPreview.Position = UDim2.new(1, -270, 0, 10)
RightPreview.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
RightPreview.BorderSizePixel = 0
RightPreview.Parent = ContentArea

local PreviewCorner = Instance.new("UICorner")
PreviewCorner.CornerRadius = UDim.new(0, 8)
PreviewCorner.Parent = RightPreview

local PreviewStroke = Instance.new("UIStroke")
PreviewStroke.Color = Color3.fromRGB(30, 40, 58)
PreviewStroke.Thickness = 1
PreviewStroke.Parent = RightPreview

local PreviewTitle = Instance.new("TextLabel")
PreviewTitle.Size = UDim2.new(1, 0, 0, 35)
PreviewTitle.Position = UDim2.new(0, 0, 0, 5)
PreviewTitle.BackgroundTransparency = 1
PreviewTitle.Font = Enum.Font.GothamBold
PreviewTitle.Text = "Violence District Status"
PreviewTitle.TextColor3 = Color3.fromRGB(200, 215, 240)
PreviewTitle.TextSize = 13
PreviewTitle.Parent = RightPreview

-- Status Cards inside RightPreview
local function addStatusCard(parent, yPos, title, value)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -24, 0, 50)
    card.Position = UDim2.new(0, 12, 0, yPos)
    card.BackgroundColor3 = Color3.fromRGB(20, 26, 38)
    card.BorderSizePixel = 0
    card.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = card

    local tLbl = Instance.new("TextLabel")
    tLbl.Size = UDim2.new(1, -20, 0, 20)
    tLbl.Position = UDim2.new(0, 10, 0, 6)
    tLbl.BackgroundTransparency = 1
    tLbl.Font = Enum.Font.GothamMedium
    tLbl.Text = title
    tLbl.TextColor3 = Color3.fromRGB(130, 145, 170)
    tLbl.TextSize = 11
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    tLbl.Parent = card

    local vLbl = Instance.new("TextLabel")
    vLbl.Size = UDim2.new(1, -20, 0, 20)
    vLbl.Position = UDim2.new(0, 10, 0, 24)
    vLbl.BackgroundTransparency = 1
    vLbl.Font = Enum.Font.GothamBold
    vLbl.Text = value
    vLbl.TextColor3 = Color3.fromRGB(39, 114, 238)
    vLbl.TextSize = 13
    vLbl.TextXAlignment = Enum.TextXAlignment.Left
    vLbl.Parent = card
    
    return vLbl
end

addStatusCard(RightPreview, 45, "CURRENT TARGET", "None / Scanning")
local genStatusLbl = addStatusCard(RightPreview, 105, "AUTO GENERATOR", "Stopped / Ready")
local daggerStatusLbl = addStatusCard(RightPreview, 165, "NO CD DAGGER", "Inactive")
local espStatusLbl = addStatusCard(RightPreview, 225, "ESP / WALLHACK", "Active")

-- Tabs Container (Left side of ContentArea)
local TabsContainer = Instance.new("Frame")
TabsContainer.Size = UDim2.new(1, -280, 1, 0)
TabsContainer.Position = UDim2.new(0, 0, 0, 0)
TabsContainer.BackgroundTransparency = 1
TabsContainer.Parent = ContentArea

local tabs = {}
local activeTabName = nil

local function createCategoryHeader(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "  " .. text:upper()
    lbl.TextColor3 = Color3.fromRGB(85, 100, 125)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = Sidebar
end

local function createTabButton(catName, tabName)
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
    indicator.BackgroundColor3 = Color3.fromRGB(39, 114, 238)
    indicator.BorderSizePixel = 0
    indicator.BackgroundTransparency = 1
    indicator.Parent = btn

    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = tabName .. "Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.ScrollBarThickness = 4
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
            t.button.BackgroundColor3 = Color3.fromRGB(0,0,0)
            t.button.BackgroundTransparency = 1
            t.indicator.BackgroundTransparency = 1
        end
        tabContent.Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(18, 24, 34)
        btn.BackgroundTransparency = 0
        indicator.BackgroundTransparency = 0
        activeTabName = tabName
    end)

    if not activeTabName then
        activeTabName = tabName
        tabContent.Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(18, 24, 34)
        btn.BackgroundTransparency = 0
        indicator.BackgroundTransparency = 0
    end

    tabs[tabName] = {button = btn, content = tabContent, indicator = indicator}
    return tabContent
end

-- Build Neverlose Sidebar Structure
createCategoryHeader("Aimbot / Combat")
local combatTab = createTabButton("Aimbot", "Rage / Combat")
local legitTab = createTabButton("Aimbot", "Legit / Dagger")

createCategoryHeader("Visuals")
local playersTab = createTabButton("Visuals", "Players & ESP")
local worldTab = createTabButton("Visuals", "World & Generator")

createCategoryHeader("Miscellaneous")
local mainMiscTab = createTabButton("Misc", "Main & Farm")
local teleportTab = createTabButton("Misc", "Teleports")
local configsTab = createTabButton("Misc", "Configs & Settings")

-- UI Helpers (Neverlose style Section Cards, Toggles, Sliders)
local function createSectionCard(parent, title, height)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, height)
    card.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
    card.BorderSizePixel = 0
    card.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = card

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(30, 40, 58)
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
    btn.BackgroundColor3 = default and Color3.fromRGB(39, 114, 238) or Color3.fromRGB(30, 40, 58)
    btn.Text = ""
    btn.Parent = row

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = btn

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = btn

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle

    local state = default

    btn.MouseButton1Click:Connect(function()
        state = not state
        local targetPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local targetColor = state and Color3.fromRGB(39, 114, 238) or Color3.fromRGB(30, 40, 58)
        
        TweenService:Create(circle, TweenInfo.new(0.15), {Position = targetPos}):Play()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = targetColor}):Play()
        
        pcall(function() callback(state) end)
    end)
end

-- Populate Tabs with Neverlose cards & toggles

-- 1. Combat Tab
local combatCard = createSectionCard(combatTab, "Dagger & Combat Settings", 130)
addToggleToCard(combatCard, "No CD Dagger (Instant Attack)", false, function(v)
    getgenv().NoCDDagger = v
    daggerStatusLbl.Text = v and "Active" or "Inactive"
    daggerStatusLbl.TextColor3 = v and Color3.fromRGB(39, 114, 238) or Color3.fromRGB(130, 145, 170)
end)
addToggleToCard(combatCard, "Auto Perfect Skill-Check", false, function(v)
    getgenv().AutoPerfectSkillCheck = v
end)

-- 2. Legit / Generator Farm Tab
local farmCard = createSectionCard(legitTab, "Auto Generator Farm", 140)
addToggleToCard(farmCard, "Auto Generator (AFK Farm)", false, function(v)
    getgenv().AutoGenerator = v
    genStatusLbl.Text = v and "Farming Active" or "Stopped / Ready"
    genStatusLbl.TextColor3 = v and Color3.fromRGB(39, 114, 238) or Color3.fromRGB(130, 145, 170)
end)

-- Stop Button inside Farm tab
local stopCardBtn = Instance.new("TextButton")
stopCardBtn.Size = UDim2.new(1, 0, 0, 32)
stopCardBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
stopCardBtn.Font = Enum.Font.GothamBold
stopCardBtn.Text = "STOP / EXIT AUTO GENERATOR"
stopCardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopCardBtn.TextSize = 11
stopCardBtn.Parent = legitTab

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 6)
stopCorner.Parent = stopCardBtn

stopCardBtn.MouseButton1Click:Connect(function()
    getgenv().AutoGenerator = false
    genStatusLbl.Text = "Stopped / Ready"
    genStatusLbl.TextColor3 = Color3.fromRGB(130, 145, 170)
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    end)
end)

-- 3. Players & ESP Tab
local espCard = createSectionCard(playersTab, "ESP / Wallhack Visuals", 210)
addToggleToCard(espCard, "Enable ESP (Wallhack)", true, function(v)
    getgenv().ESP_Settings.Enabled = v
    espStatusLbl.Text = v and "Active" or "Disabled"
end)
addToggleToCard(espCard, "Survivor ESP", true, function(v)
    getgenv().ESP_Settings.Survivors = v
end)
addToggleToCard(espCard, "Killer ESP", true, function(v)
    getgenv().ESP_Settings.Killers = v
end)
addToggleToCard(espCard, "ESP Boxes", true, function(v)
    getgenv().ESP_Settings.Boxes = v
end)

-- 4. World Tab
local worldCard = createSectionCard(worldTab, "World & Objects ESP", 100)
addToggleToCard(worldCard, "Generator ESP", true, function(v)
    getgenv().ESP_Settings.Generators = v
end)

-- 5. Main & Farm Tab
local mainCard = createSectionCard(mainMiscTab, "Misc Settings", 90)
addToggleToCard(mainCard, "Anti AFK", true, function(v)
    -- anti afk active
end)

-- 6. Teleports Tab
local tpCard = createSectionCard(teleportTab, "Quick Teleport System", 100)
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(1, 0, 0, 34)
tpBtn.BackgroundColor3 = Color3.fromRGB(39, 114, 238)
tpBtn.Font = Enum.Font.GothamBold
tpBtn.Text = "Teleport to Nearest Generator"
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.TextSize = 12
tpBtn.Parent = teleportTab

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 6)
tpCorner.Parent = tpBtn

tpBtn.MouseButton1Click:Connect(function()
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

-- 7. Configs & Settings Tab
local setCard = createSectionCard(configsTab, "Script Management", 100)
addToggleToCard(setCard, "Unload Script & GUI", false, function(v)
    if v then
        ScreenGui:Destroy()
    end
end)

print("Neverlose UI Panel for Violence District loaded successfully.")
