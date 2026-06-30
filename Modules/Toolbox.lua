--//====================================================
--// StudioLiteTools
--// Toolbox.lua
--//====================================================

local Toolbox = {}

local References

local function CreateSearchBox(Content)

	local SearchBox = Instance.new("TextBox")
	SearchBox.Name = "SearchBox"
	SearchBox.Parent = Content

	SearchBox.Size = UDim2.new(1,-20,0,40)
	SearchBox.Position = UDim2.new(0,10,0,10)

	SearchBox.PlaceholderText = "Search Assets..."
	SearchBox.Text = ""

	SearchBox.ClearTextOnFocus = false

	SearchBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
	SearchBox.BorderSizePixel = 0

	SearchBox.TextColor3 = Color3.new(1,1,1)
	SearchBox.PlaceholderColor3 = Color3.fromRGB(160,160,160)

	SearchBox.Font = Enum.Font.Gotham
	SearchBox.TextSize = 16

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,8)
	Corner.Parent = SearchBox

	References.SearchBox = SearchBox

end

local function CreateCategoryBar(Content)

	local Categories = {
		"Models",
		"Images",
		"Meshes",
		"Audio"
	}

	local Frame = Instance.new("Frame")
	Frame.Name = "CategoryBar"
	Frame.Parent = Content

	Frame.BackgroundTransparency = 1

	Frame.Position = UDim2.new(0,10,0,60)
	Frame.Size = UDim2.new(1,-20,0,36)

	local Layout = Instance.new("UIListLayout")
	Layout.Parent = Frame

	Layout.FillDirection = Enum.FillDirection.Horizontal
	Layout.Padding = UDim.new(0,6)

	for _,Name in ipairs(Categories) do

		local Button = Instance.new("TextButton")
		Button.Parent = Frame

		Button.Size = UDim2.fromOffset(90,36)

		Button.Text = Name
		Button.Font = Enum.Font.GothamMedium
		Button.TextSize = 14

		Button.BackgroundColor3 = Color3.fromRGB(40,40,40)
		Button.TextColor3 = Color3.new(1,1,1)

		Button.BorderSizePixel = 0

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0,8)
		Corner.Parent = Button

	end

end

local function CreateAssetList(Content)

	local List = Instance.new("ScrollingFrame")
	List.Name = "AssetList"
	List.Parent = Content

	List.Position = UDim2.new(0,10,0,110)
	List.Size = UDim2.new(1,-20,1,-120)

	List.BackgroundTransparency = 1
	List.BorderSizePixel = 0

	List.ScrollBarThickness = 4
	List.CanvasSize = UDim2.new()

	local Layout = Instance.new("UIListLayout")
	Layout.Parent = List

	Layout.Padding = UDim.new(0,8)

	References.AssetList = List

end

function Toolbox.Init(Data)

	References = Data.UI.GetReferences()

	local Content = References.Content

	CreateSearchBox(Content)

	CreateCategoryBar(Content)

	CreateAssetList(Content)

	print("[StudioLiteTools] Toolbox Ready")

end

return Toolbox
