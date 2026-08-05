-- Violence District Pro Hub Loader
-- Usage: loadstring(game:HttpGet("https://raw.githubusercontent.com/pipiskazhopakakashka/violence-district/arena/019fd39e-violence-district/loader.lua"))()

local baseUrl = "https://raw.githubusercontent.com/pipiskazhopakakashka/violence-district/arena/019fd39e-violence-district/src/"

print("Loading Violence District Pro Hub...")

pcall(function()
    loadstring(game:HttpGet(baseUrl .. "esp.lua"))()
end)

pcall(function()
    loadstring(game:HttpGet(baseUrl .. "features.lua"))()
end)

pcall(function()
    loadstring(game:HttpGet(baseUrl .. "gui.lua"))()
end)

print("Violence District Pro Hub Loaded Successfully!")
