-- Module: Enterprise Security & Key System (HWID Binding)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Security = {}

function Security.GetHWID()
    local suc, res = pcall(function()
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    if not suc or not res then
        res = tostring(LocalPlayer.UserId) .. "_hwid_fallback"
    end
    return res
end

function Security.ValidateKey(licenseKey, authEndpoint, callback)
    local hwid = Security.GetHWID()
    
    -- Local developer / VIP bypass keys
    if licenseKey == "DEVELOPER-MASTER-KEY" or licenseKey == "VD-PRO-VIP-2026" then
        callback(true, "Authorized (Master Key)")
        return
    end

    local suc, res = pcall(function()
        return game:HttpGet(authEndpoint)
    end)

    if not suc then
        callback(false, "Connection error to auth server.")
        return
    end

    local decoded = pcall(function()
        return HttpService:JSONDecode(res)
    end)

    if not decoded then
        callback(false, "Auth response parsing error.")
        return
    end

    local data = HttpService:JSONDecode(res)
    
    -- Check blacklist
    if data.Blacklist then
        for _, bHwid in ipairs(data.Blacklist) do
            if bHwid == hwid then
                callback(false, "Your HWID is blacklisted!")
                return
            end
        end
    end

    -- Check keys
    if data.Keys and data.Keys[licenseKey] then
        local boundHWID = data.Keys[licenseKey]
        if boundHWID == "ANY" or boundHWID == hwid then
            callback(true, "Successfully Authenticated!")
        else
            callback(false, "HWID mismatch! Key is bound to another PC.")
        end
    else
        callback(false, "Invalid license key!")
    end
end

function Security.ShowAuthUI(onSuccess)
    local CoreGui = game:GetService("CoreGui")
    pcall(function() CoreGui.VDAuthPrompt:Destroy() end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "VDAuthPrompt"
    gui.ResetOnSpawn = false
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 240)
    frame.Position = UDim2.new(0.5, -200, 0.5, -120)
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
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "NEVER<font color='#2f78ff'>LOSE</font> // VIOLENCE DISTRICT AUTH"
    title.RichText = true
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 13
    title.Parent = frame

    local hwidText = Instance.new("TextLabel")
    hwidText.Size = UDim2.new(1, -40, 0, 24)
    hwidText.Position = UDim2.new(0, 20, 0, 50)
    hwidText.BackgroundTransparency = 1
    hwidText.Font = Enum.Font.Code
    hwidText.Text = "HWID: " .. Security.GetHWID():sub(1, 28) .. "..."
    hwidText.TextColor3 = Color3.fromRGB(130, 145, 170)
    hwidText.TextSize = 11
    hwidText.TextXAlignment = Enum.TextXAlignment.Left
    hwidText.Parent = frame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -40, 0, 40)
    textBox.Position = UDim2.new(0, 20, 0, 85)
    textBox.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
    textBox.BorderSizePixel = 0
    textBox.Font = Enum.Font.GothamMedium
    textBox.PlaceholderText = "Enter license key (e.g. VD-PRO-VIP-2026)..."
    textBox.PlaceholderColor3 = Color3.fromRGB(100, 115, 140)
    textBox.Text = ""
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 12
    textBox.Parent = frame

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = textBox

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -40, 0, 42)
    btn.Position = UDim2.new(0, 20, 0, 140)
    btn.BackgroundColor3 = Color3.fromRGB(47, 120, 255)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Text = "LOGIN & VERIFY HWID"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 20)
    status.Position = UDim2.new(0, 0, 0, 195)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.GothamMedium
    status.Text = ""
    status.TextColor3 = Color3.fromRGB(200, 50, 50)
    status.TextSize = 11
    status.Parent = frame

    btn.MouseButton1Click:Connect(function()
        local key = textBox.Text
        if key == "" then
            status.Text = "Please enter a license key."
            return
        end

        btn.Text = "Authenticating with Server..."
        Security.ValidateKey(key, "https://raw.githubusercontent.com/pipiskazhopakakashka/violence-district/arena/019fd39e-violence-district/auth.json", function(success, msg)
            if success then
                status.TextColor3 = Color3.fromRGB(50, 200, 100)
                status.Text = msg
                task.delay(0.8, function()
                    gui:Destroy()
                    onSuccess()
                end)
            else
                btn.Text = "LOGIN & VERIFY HWID"
                status.TextColor3 = Color3.fromRGB(200, 50, 50)
                status.Text = msg
            end
        end)
    end)
end

return Security
