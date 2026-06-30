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

local function CreateFloatingButton()
	local Button = Instance.new("ImageButton")
	Button.Name = "FloatingButton"
	Button.Size = UDim2.fromOffset(56, 56)
	Button.Position = UDim2.new(1, -76, 0.5, -28)
	Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Button.BorderSizePixel = 0
	Button.AutoButtonColor = true
	Button.Image = ""
	Button.Parent = References.ScreenGui

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(1, 0)
	Corner.Parent = Button

	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 1
	Stroke.Color = Color3.fromRGB(70, 70, 70)
	Stroke.Parent = Button

	References.FloatingButton = Button
end

function UI.GetReferences()
	return References
end

function UI.Init()
	CreateScreenGui()
	CreateFloatingButton()
end

return UI
