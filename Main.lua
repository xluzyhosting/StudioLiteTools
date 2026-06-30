--//====================================================
--// StudioLiteTools
--// Main.lua
--// Repository : xluzyhosting/StudioLiteTools
--//====================================================

local BASE_URL = "https://raw.githubusercontent.com/xluzyhosting/StudioLiteTools/main"

local Success, Result = pcall(function()
	return loadstring(game:HttpGet(BASE_URL .. "/Init.lua"))()
end)

if not Success then
	warn("[StudioLiteTools] Initialization Failed")
	warn(Result)
end
