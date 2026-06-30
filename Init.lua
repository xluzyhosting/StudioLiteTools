
--//====================================================
--// StudioLiteTools
--// Init.lua
--// Repository : xluzyhosting/StudioLiteTools
--//====================================================

local BASE_URL = "https://raw.githubusercontent.com/xluzyhosting/StudioLiteTools/main"

local function LoadModule(Path)
	local Success, Module = pcall(function()
		return loadstring(game:HttpGet(BASE_URL .. "/" .. Path))()
	end)

	if not Success then
		error("[StudioLiteTools] Failed to load module: " .. Path .. "\n" .. tostring(Module))
	end

	return Module
end

local Theme = LoadModule("Assets/Theme.lua")
local Icons = LoadModule("Assets/Icons.lua")

local UI = LoadModule("Modules/UI.lua")
local Network = LoadModule("Modules/Network.lua")
local Toolbox = LoadModule("Modules/Toolbox.lua")
local Group = LoadModule("Modules/Group.lua")
local Utils = LoadModule("Modules/Utils.lua")

UI.Init({
	Theme = Theme,
	Icons = Icons
})

Network.Init()

Toolbox.Init({
	UI = UI,
	Network = Network
})

Group.Init({
	UI = UI
})

return true
