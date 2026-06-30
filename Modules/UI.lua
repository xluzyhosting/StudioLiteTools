--//====================================================
--// StudioLiteTools
--// UI.lua
--// Part 1
--//====================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local UI = {}
local References = {}

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local GUI_NAME = "StudioLiteTools"

local WindowOpened = false

local WindowSize = UDim2.fromOffset(520, 360)

local TweenInfoOpen = TweenInfo.new(
	0.25,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.Out
)

local TweenInfoClose = TweenInfo.new(
	0.20,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.In
)

--------------------------------------------------
-- ScreenGui
--------------------------------------------------

local function CreateScreenGui()

	local Existing = PlayerGui:FindFirstChild(GUI_NAME)

	if Existing then
		Existing:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = GUI_NAME
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = PlayerGui

	References.ScreenGui = ScreenGui

end

--------------------------------------------------
-- Floating Button
--------------------------------------------------

local function CreateFloatingButton()

	local Button = Instance.new("ImageButton")
	Button.Name = "FloatingButton"
	Button.Parent = References.ScreenGui

	Button.Size = UDim2.fromOffset(58,58)
	Button.Position = UDim2.new(1,-78,0.5,-29)

	Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
	Button.BorderSizePixel = 0

	Button.AutoButtonColor = true
	Button.Image = ""

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(1,0)
	Corner.Parent = Button

	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 1
	Stroke.Color = Color3.fromRGB(70,70,70)
	Stroke.Parent = Button

	local Shadow = Instance.new("UIStroke")
	Shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	Shadow.Thickness = 4
	Shadow.Transparency = 0.8
	Shadow.Color = Color3.new()
	Shadow.Parent = Button

	References.FloatingButton = Button

end

--------------------------------------------------
-- Main Window
--------------------------------------------------

local function CreateMainWindow()

	local Window = Instance.new("Frame")
	Window.Name = "MainWindow"
	Window.Parent = References.ScreenGui

	Window.AnchorPoint = Vector2.new(.5,.5)
	Window.Position = UDim2.new(.5,0,.5,0)

	Window.Size = WindowSize

	Window.BackgroundColor3 = Color3.fromRGB(28,28,28)
	Window.BorderSizePixel = 0

	Window.Visible = false

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,12)
	Corner.Parent = Window

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(60,60,60)
	Stroke.Thickness = 1
	Stroke.Parent = Window

	References.MainWindow = Window

end

--------------------------------------------------
-- TopBar
--------------------------------------------------

local function CreateTopBar()

	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Parent = References.MainWindow

	TopBar.Size = UDim2.new(1,0,0,42)

	TopBar.BackgroundColor3 = Color3.fromRGB(34,34,34)
	TopBar.BorderSizePixel = 0

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,12)
	Corner.Parent = TopBar

	local Fix = Instance.new("Frame")
	Fix.Parent = TopBar
	Fix.Size = UDim2.new(1,0,0.5,0)
	Fix.Position = UDim2.new(0,0,.5,0)
	Fix.BorderSizePixel = 0
	Fix.BackgroundColor3 = TopBar.BackgroundColor3

	local Title = Instance.new("TextLabel")
	Title.Parent = TopBar

	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1,-60,1,0)
	Title.Position = UDim2.new(0,16,0,0)

	Title.Text = "StudioLiteTools"
	Title.TextColor3 = Color3.new(1,1,1)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextSize = 18
	Title.Font = Enum.Font.GothamBold

	local Close = Instance.new("TextButton")
	Close.Parent = TopBar

	Close.Name = "Close"

	Close.Size = UDim2.fromOffset(32,32)
	Close.Position = UDim2.new(1,-38,.5,-16)

	Close.Text = "×"
	Close.TextSize = 22

	Close.BackgroundTransparency = 1
	Close.TextColor3 = Color3.new(1,1,1)

	References.TopBar = TopBar
	References.CloseButton = Close

end

--------------------------------------------------
-- Content
--------------------------------------------------

local function CreateContent()

	local Content = Instance.new("Frame")
	Content.Name = "Content"
	Content.Parent = References.MainWindow

	Content.BackgroundTransparency = 1
	Content.BorderSizePixel = 0

	Content.Position = UDim2.new(0,0,0,42)
	Content.Size = UDim2.new(1,0,1,-42)

	References.Content = Content

end

--------------------------------------------------
-- Window Animation
--------------------------------------------------

local function OpenWindow()

	if WindowOpened then
		return
	end

	WindowOpened = true

	local Window = References.MainWindow

	Window.Visible = true
	Window.Size = UDim2.fromOffset(460,320)

	TweenService:Create(
		Window,
		TweenInfoOpen,
		{
			Size = WindowSize
		}
	):Play()

end

local function CloseWindow()

	if not WindowOpened then
		return
	end

	WindowOpened = false

	local Window = References.MainWindow

	local Tween = TweenService:Create(
		Window,
		TweenInfoClose,
		{
			Size = UDim2.fromOffset(460,320)
		}
	)

	Tween:Play()

	Tween.Completed:Connect(function()
		Window.Visible = false
		Window.Size = WindowSize
	end)

end

--------------------------------------------------
-- Toggle
--------------------------------------------------

local function ToggleWindow()

	if WindowOpened then
		CloseWindow()
	else
		OpenWindow()
	end

end

--------------------------------------------------
-- Floating Button Drag
--------------------------------------------------

local Dragging = false
local DragInput
local DragStart
local StartPosition

local function UpdateDrag(Input)

	local Delta = Input.Position - DragStart

	References.FloatingButton.Position = UDim2.new(
		StartPosition.X.Scale,
		StartPosition.X.Offset + Delta.X,
		StartPosition.Y.Scale,
		StartPosition.Y.Offset + Delta.Y
	)

end

local function SetupFloatingButtonDrag()

	local Button = References.FloatingButton

	Button.InputBegan:Connect(function(Input)

		if Input.UserInputType == Enum.UserInputType.Touch
			or Input.UserInputType == Enum.UserInputType.MouseButton1 then

			Dragging = true
			DragStart = Input.Position
			StartPosition = Button.Position

			Input.Changed:Connect(function()

				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end

			end)

		end

	end)

	Button.InputChanged:Connect(function(Input)

		if Input.UserInputType == Enum.UserInputType.Touch
			or Input.UserInputType == Enum.UserInputType.MouseMovement then

			DragInput = Input

		end

	end)

	UserInputService.InputChanged:Connect(function(Input)

		if Input == DragInput and Dragging then
			UpdateDrag(Input)
		end

	end)

end

--------------------------------------------------
-- Main Window Drag
--------------------------------------------------

local WindowDragging = false
local WindowDragInput
local WindowDragStart
local WindowStartPosition

local function UpdateWindowDrag(Input)

	local Delta = Input.Position - WindowDragStart

	References.MainWindow.Position = UDim2.new(
		WindowStartPosition.X.Scale,
		WindowStartPosition.X.Offset + Delta.X,
		WindowStartPosition.Y.Scale,
		WindowStartPosition.Y.Offset + Delta.Y
	)

end

local function SetupWindowDrag()

	local TopBar = References.TopBar

	TopBar.InputBegan:Connect(function(Input)

		if Input.UserInputType == Enum.UserInputType.Touch
			or Input.UserInputType == Enum.UserInputType.MouseButton1 then

			WindowDragging = true
			WindowDragStart = Input.Position
			WindowStartPosition = References.MainWindow.Position

			Input.Changed:Connect(function()

				if Input.UserInputState == Enum.UserInputState.End then
					WindowDragging = false
				end

			end)

		end

	end)

	TopBar.InputChanged:Connect(function(Input)

		if Input.UserInputType == Enum.UserInputType.Touch
			or Input.UserInputType == Enum.UserInputType.MouseMovement then

			WindowDragInput = Input

		end

	end)

	UserInputService.InputChanged:Connect(function(Input)

		if Input == WindowDragInput and WindowDragging then
			UpdateWindowDrag(Input)
		end

	end)

end

--------------------------------------------------
-- Events
--------------------------------------------------

local function SetupEvents()

	References.FloatingButton.MouseButton1Click:Connect(function()
		ToggleWindow()
	end)

	References.CloseButton.MouseButton1Click:Connect(function()
		CloseWindow()
	end)

end

--------------------------------------------------
-- Public
--------------------------------------------------

function UI.GetReferences()
	return References
end

function UI.Init()

	CreateScreenGui()

	CreateFloatingButton()

	CreateMainWindow()

	CreateTopBar()

	CreateContent()

	SetupFloatingButtonDrag()

	SetupWindowDrag()

	SetupEvents()

end

return UI