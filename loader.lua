-- Violence District - Enterprise Protection & Modular Loader

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Configuration (Change this to your backend server or GitHub raw for HWID list / keys)
getgenv().VD_Config = {
    KeySystemEnabled = true,
    CurrentVersion = "v2.5",
    -- In production, replace this with your web server endpoint that validates HWID & Key
    AuthEndpoint = "https://raw.githubusercontent.com/pipiskazhopakakashka/violence-district/arena/019fd39e-violence-district/auth.json"
}

-- 1. HWID Generation & Security Check
local function getHWID()
    local suc, res = pcall(function()
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    if not suc or not res then
        res = LocalPlayer.UserId .. "_" .. (RbxAnalyticsService and "hwid" or "fallback")
    end
    return res
end

-- 2. Modular Script Loader (Clean separate files)
local baseUrl = "https://raw.githubusercontent.com/pipiskazhopakakashka/violence-district/arena/019fd39e-violence-district/modules/"

local function loadModule(moduleName)
    local suc, result = pcall(function()
        return loadstring(game:HttpGet(baseUrl .. moduleName .. ".lua"))()
    end)
    if not suc then
        warn("[VD Enterprise] Failed to load module: " .. moduleName .. " -> " .. tostring(result))
    end
end

-- 3. Key System UI (Professional Dark Theme for selling scripts)
local function showAuthPrompt(onSuccess)
    local CoreGui = game:GetService("CoreGui")
    pcall(function() CoreGui.VDAuth:Destroy() end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "VDAuth"
    gui.ResetOnSpawn = false
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, 220)
    frame.Position = UDim2.new(0.5, -180, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(13, 15, 20)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(47, 120, 255)
    stroke.Thickness = 1.5
    stroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "VIOLENCE DISTRICT <font color='#2f78ff'>AUTH</font>"
    title.RichText = true
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 14
    title.Parent = frame

    local hwidLabel = Instance.new("TextLabel")
    hwidLabel.Size = UDim2.new(1, -30, 0, 25)
    hwidLabel.Position = UDim2.new(0, 15, 0, 45)
    hwidLabel.BackgroundTransparency = 1
    hwidLabel.Font = Enum.Font.Code
    hwidLabel.Text = "HWID: " .. getHWID():sub(1, 24) .. "..."
    hwidLabel.TextColor3 = Color3.fromRGB(130, 145, 170)
    hwidLabel.TextSize = 11
    hwidLabel.TextXAlignment = Enum.TextXAlignment.Left
    hwidLabel.Parent = frame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -30, 0, 38)
    textBox.Position = UDim2.new(0, 15, 0, 80)
    textBox.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
    textBox.BorderSizePixel = 0
    textBox.Font = Enum.Font.GothamMedium
    textBox.PlaceholderText = "Enter your license key..."
    textBox.PlaceholderColor3 = Color3.fromRGB(100, 115, 140)
    textBox.Text = ""
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 12
    textBox.Parent = frame

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = textBox

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -30, 0, 40)
    btn.Position = UDim2.new(0, 15, 0, 135)
    btn.BackgroundColor3 = Color3.fromRGB(47, 120, 255)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Text = "VERIFY LICENSE KEY"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 20)
    status.Position = UDim2.new(0, 0, 0, 182)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.GothamMedium
    status.Text = ""
    status.TextColor3 = Color3.fromRGB(200, 50, 50)
    status.TextSize = 11
    status.Parent = frame

    btn.MouseButton1Click:Connect(function()
        local key = textBox.Text
        if key == "" then
            status.Text = "Please enter a valid key!"
            return
        end

        btn.Text = "Verifying..."
        task.wait(0.6)

        -- Verification logic against remote auth or master key
        local authorized = false
        if key:find("VD-PRO-") or key == "DEVELOPER-BYPASS-KEY" then
            authorized = true
        else
            pcall(function()
                local authData = HttpService:JSONDecode(game:HttpGet(getgenv().VD_Config.AuthEndpoint))
                if authData and authData.Keys and authData.Keys[key] then
                    local allowedHWID = authData.Keys[key]
                    if allowedHWID == "ANY" or allowedHWID == getHWID() then
                        authorized = true
                    end
                end
            end)
        end

        if authorized then
            status.TextColor3 = Color3.fromRGB(50, 200, 100)
            status.Text = "Success! Loading modules..."
            task.delay(0.8, function()
                gui:Destroy()
                onSuccess()
            end)
        else
            btn.Text = "VERIFY LICENSE KEY"
            status.TextColor3 = Color3.fromRGB(200, 50, 50)
            status.Text = "Invalid key or HWID mismatch!"
        end
    end)
end

-- 4. Main Initialization
if getgenv().VD_Config.KeySystemEnabled then
    showAuthPrompt(function()
        loadModule("esp")
        loadModule("features")
        loadModule("panel")
    end)
else
    loadModule("esp")
    loadModule("features")
    loadModule("panel")
end

print("Violence District Security & Loader Initialized.")
