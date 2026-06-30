--//====================================================
--// StudioLiteTools
--// UI.lua
--//====================================================

local Players = game:GetService("Players")

local UI = {}
local References = {}

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local GUI_NAME = "StudioLiteTools"

local function CreateScreenGui()
	local Existing = PlayerGui:FindFirstChild(GUI_NAME)

	if Existing then
		Existing:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = GUI_NAME
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = PlayerGui

	References.ScreenGui = ScreenGui
end

function UI.GetReferences()
	return References
end

function UI.Init()
	CreateScreenGui()
end

return UI
