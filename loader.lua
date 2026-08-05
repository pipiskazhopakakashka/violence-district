-- Violence District - Enterprise Commercial Loader
-- Usage: loadstring(game:HttpGet("https://raw.githubusercontent.com/pipiskazhopakakashka/violence-district/arena/019fd39e-violence-district/loader.lua"))()

local Security = loadstring(game:HttpGet("https://raw.githubusercontent.com/pipiskazhopakakashka/violence-district/arena/019fd39e-violence-district/modules/security.lua"))()

local baseUrl = "https://raw.githubusercontent.com/pipiskazhopakakashka/violence-district/arena/019fd39e-violence-district/modules/"

local function loadModule(name)
    local suc, res = pcall(function()
        return loadstring(game:HttpGet(baseUrl .. name .. ".lua"))()
    end)
    if not suc then
        warn("[VD Enterprise] Error loading module [" .. name .. "]: " .. tostring(res))
    end
end

-- Launch Enterprise Key System Authentication Prompt
Security.ShowAuthUI(function()
    print("[VD Enterprise] License verified successfully. Loading cheat modules...")
    loadModule("esp")
    loadModule("features")
    loadModule("panel")
end)
