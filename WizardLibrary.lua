local WizardLibrary = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CoreGui = game:GetService("CoreGui")

local Library = CoreGui:FindFirstChild("WizardLibrary")
if Library then
    Library:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WizardLibrary"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "Container"
MainFrame.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
MainFrame.BackgroundTransparency = 1
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Parent = ScreenGui

local Dragging
local DragInput
local DragStart
local StartPosition

local function UpdateInput(Input)
    local Delta = Input.Position - DragStart
    local Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
    TweenService:Create(MainFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = Position}):Play()
end

ScreenGui.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = Input.Position
        StartPosition = MainFrame.Position

        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

ScreenGui.InputChanged:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
        DragInput = Input
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Input == DragInput and Dragging then
        UpdateInput(Input)
    end
end)

local WindowCount = 0

function WizardLibrary:CreateWindow(Title)
    WindowCount = WindowCount + 1
    local WindowFrame = Instance.new("Frame")
    WindowFrame.Name = "Window"
    WindowFrame.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
    WindowFrame.BackgroundTransparency = 0
    WindowFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    WindowFrame.Size = UDim2.new(0, 465, 0, 320)
    WindowFrame.ZIndex = 1
    WindowFrame.Parent = MainFrame

    local Topbar = Instance.new("ImageLabel")
    Topbar.Name = "Topbar"
    Topbar.Image = "rbxassetid://3570695787"
    Topbar.ImageColor3 = Color3.new(0.243137, 0.243137, 0.243137)
    Topbar.ScaleType = Enum.ScaleType.Slice
    Topbar.SliceCenter = Rect.new(4, 4, 4, 4)
    Topbar.SliceScale = 1
    Topbar.BackgroundTransparency = 1
    Topbar.BorderSizePixel = 0
    Topbar.Size = UDim2.new(1, 0, 0, 30)
    Topbar.ZIndex = 2
    Topbar.Parent = WindowFrame

    local WindowToggle = Instance.new("TextButton")
    WindowToggle.Name = "WindowToggle"
    WindowToggle.Font = Enum.Font.SourceSansSemibold
    WindowToggle.Text = "-"
    WindowToggle.TextColor3 = Color3.new(1, 1, 1)
    WindowToggle.TextSize = 24
    WindowToggle.TextWrapped = true
    WindowToggle.BackgroundTransparency = 1
    WindowToggle.BorderSizePixel = 0
    WindowToggle.Size = UDim2.new(0, 30, 0, 30)
    WindowToggle.Position = UDim2.new(0, 435, 0, 0)
    WindowToggle.ZIndex = 4
    WindowToggle.Parent = Topbar

    local WindowTitle = Instance.new("TextLabel")
    WindowTitle.Name = "WindowTitle"
    WindowTitle.Font = Enum.Font.SourceSansBold
    WindowTitle.Text = Title
    WindowTitle.TextColor3 = Color3.new(1, 1, 1)
    WindowTitle.TextSize = 18
    WindowTitle.TextWrapped = true
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 10, 0, 4)
    WindowTitle.Size = UDim2.new(1, -10, 0, 22)
    WindowTitle.ZIndex = 3
    WindowTitle.Parent = Topbar

    local BottomRoundCover = Instance.new("Frame")
    BottomRoundCover.Name = "BottomRoundCover"
    BottomRoundCover.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
    BottomRoundCover.BorderSizePixel = 0
    BottomRoundCover.Size = UDim2.new(1, 0, 1, -30)
    BottomRoundCover.Position = UDim2.new(0, 0, 0, 30)
    BottomRoundCover.ZIndex = 1
    BottomRoundCover.Parent = WindowFrame

    local Body = Instance.new("Frame")
    Body.Name = "Body"
    Body.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
    Body.BackgroundTransparency = 0
    Body.BorderSizePixel = 0
    Body.ClipsDescendants = true
    Body.Size = UDim2.new(1, 0, 1, -30)
    Body.Position = UDim2.new(0, 0, 0, 30)
    Body.ZIndex = 2
    Body.Parent = WindowFrame

    local Sorter = Instance.new("UIListLayout")
    Sorter.Name = "Sorter"
    Sorter.SortOrder = Enum.SortOrder.LayoutOrder
    Sorter.Padding = UDim.new(0, 5)
    Sorter.Parent = Body

    local TopbarBodyCover = Instance.new("Frame")
    TopbarBodyCover.Name = "TopbarBodyCover"
    TopbarBodyCover.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
    TopbarBodyCover.BorderSizePixel = 0
    TopbarBodyCover.Position = UDim2.new(0, 0, 1, 0)
    TopbarBodyCover.Size = UDim2.new(1, 0, 0, 4)
    TopbarBodyCover.ZIndex = 2
    TopbarBodyCover.Parent = Topbar

    local Minimized = false
    local BodySize = Body.Size

    WindowToggle.MouseButton1Down:Connect(function()
        Minimized = not Minimized
        if Minimized then
            TweenService:Create(Body, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            TweenService:Create(WindowFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 465, 0, 30)}):Play()
            TweenService:Create(Topbar, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 30)}):Play()
            TweenService:Create(WindowToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            WindowToggle.Text = "+"
            WindowToggle.TextSize = 18
        else
            TweenService:Create(Body, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = BodySize}):Play()
            TweenService:Create(WindowFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 465, 0, 320)}):Play()
            WindowToggle.Text = "-"
            WindowToggle.TextSize = 24
        end
    end)

    local WindowObj = {}
    WindowObj.Frame = WindowFrame
    WindowObj.Body = Body
    WindowObj.Toggle = WindowToggle
    WindowObj.Minimized = Minimized

    local dragging
    local dragInput
    local dragStart
    local startPos

    local function updateDrag(input)
        local delta = input.Position - dragStart
        WindowFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = WindowFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)

    local SectionCount = 0

    function WindowObj:NewSection(Title)
        SectionCount = SectionCount + 1

        local Section = Instance.new("Frame")
        Section.Name = "Section"
        Section.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
        Section.BackgroundTransparency = 0
        Section.BorderSizePixel = 0
        Section.ClipsDescendants = true
        Section.Size = UDim2.new(1, 0, 0, 30)
        Section.LayoutOrder = SectionCount
        Section.Parent = Body

        local SectionInfo = Instance.new("Frame")
        SectionInfo.Name = "SectionInfo"
        SectionInfo.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        SectionInfo.BackgroundTransparency = 0
        SectionInfo.BorderSizePixel = 0
        SectionInfo.Size = UDim2.new(1, 0, 0, 30)
        SectionInfo.ZIndex = 2
        SectionInfo.Parent = Section

        local SectionToggle = Instance.new("TextButton")
        SectionToggle.Name = "SectionToggle"
        SectionToggle.Font = Enum.Font.SourceSansSemibold
        SectionToggle.Text = "-"
        SectionToggle.TextColor3 = Color3.new(1, 1, 1)
        SectionToggle.TextSize = 18
        SectionToggle.TextWrapped = true
        SectionToggle.BackgroundTransparency = 1
        SectionToggle.BorderSizePixel = 0
        SectionToggle.Position = UDim2.new(0, 350, 0, 0)
        SectionToggle.Size = UDim2.new(0, 30, 0, 30)
        SectionToggle.ZIndex = 4
        SectionToggle.Parent = SectionInfo

        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Name = "SectionTitle"
        SectionTitle.Font = Enum.Font.SourceSansBold
        SectionTitle.Text = Title
        SectionTitle.TextColor3 = Color3.new(1, 1, 1)
        SectionTitle.TextSize = 18
        SectionTitle.TextWrapped = true
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        SectionTitle.BackgroundTransparency = 1
        SectionTitle.BorderSizePixel = 0
        SectionTitle.Position = UDim2.new(0, 10, 0, 4)
        SectionTitle.Size = UDim2.new(1, -10, 0, 22)
        SectionTitle.ZIndex = 3
        SectionTitle.Parent = SectionInfo

        local Layout = Instance.new("UIListLayout")
        Layout.Name = "Layout"
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Padding = UDim.new(0, 5)
        Layout.Parent = Section

        local SectionMinimized = false
        local SectionBodySize = UDim2.new(1, 0, 0, 30)

        SectionToggle.MouseButton1Down:Connect(function()
            SectionMinimized = not SectionMinimized
            if SectionMinimized then
                TweenService:Create(Section, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 30)}):Play()
                SectionToggle.Text = "+"
            else
                TweenService:Create(Section, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = SectionBodySize}):Play()
                SectionToggle.Text = "-"
            end
        end)

        local SectionObj = {}
        SectionObj.Section = Section
        SectionObj.Minimized = false
        SectionObj.ElementCount = 0

        function SectionObj:AddElement(Element)
            Element.LayoutOrder = self.ElementCount
            Element.Parent = Section
            self.ElementCount = self.ElementCount + 1
            local elementSize = Element.Size.Y.Offset + 10
            SectionBodySize = UDim2.new(1, 0, 0, SectionBodySize.Y.Offset + elementSize)
            TweenService:Create(Section, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = SectionBodySize}):Play()
        end

        function SectionObj:CreateToggle(Options)
            Options = Options or {}
            local Title = Options.Title or "Toggle"
            local Default = Options.Default or false
            local Callback = Options.Callback or function() end

            local ToggleHolder = Instance.new("Frame")
            ToggleHolder.Name = "ToggleHolder"
            ToggleHolder.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            ToggleHolder.BackgroundTransparency = 0
            ToggleHolder.BorderSizePixel = 0
            ToggleHolder.Size = UDim2.new(1, 0, 0, 40)
            ToggleHolder.Parent = Section

            local ToggleTitle = Instance.new("TextLabel")
            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.BackgroundTransparency = 1
            ToggleTitle.Font = Enum.Font.SourceSansBold
            ToggleTitle.Text = Title
            ToggleTitle.TextColor3 = Color3.new(1, 1, 1)
            ToggleTitle.TextSize = 16
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            ToggleTitle.Position = UDim2.new(0, 40, 0, 10)
            ToggleTitle.Size = UDim2.new(1, -50, 0, 20)
            ToggleTitle.Parent = ToggleHolder

            local ToggleBackground = Instance.new("ImageLabel")
            ToggleBackground.Name = "ToggleBackground"
            ToggleBackground.Image = "rbxassetid://3570695787"
            ToggleBackground.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
            ToggleBackground.ScaleType = Enum.ScaleType.Slice
            ToggleBackground.SliceCenter = Rect.new(4, 4, 4, 4)
            ToggleBackground.SliceScale = 1
            ToggleBackground.BackgroundTransparency = 1
            ToggleBackground.BorderSizePixel = 0
            ToggleBackground.Position = UDim2.new(0, 10, 0, 10)
            ToggleBackground.Size = UDim2.new(0, 20, 0, 20)
            ToggleBackground.Parent = ToggleHolder

            local ToggleButton = Instance.new("ImageLabel")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Image = "rbxassetid://3570695787"
            ToggleButton.ImageColor3 = Color3.new(0.4, 0.4, 0.4)
            ToggleButton.ScaleType = Enum.ScaleType.Slice
            ToggleButton.SliceCenter = Rect.new(4, 4, 4, 4)
            ToggleButton.SliceScale = 1
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Position = UDim2.new(0, 10, 0, 10)
            ToggleButton.Size = UDim2.new(0, 20, 0, 20)
            ToggleButton.Parent = ToggleHolder

            local Toggled = Default

            local function UpdateToggle()
                if Toggled then
                    TweenService:Create(ToggleButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                    TweenService:Create(ToggleButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                else
                    TweenService:Create(ToggleButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
                    TweenService:Create(ToggleButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 90}):Play()
                end
            end

            ToggleBackground.MouseButton1Down:Connect(function()
                Toggled = not Toggled
                UpdateToggle()
                Callback(Toggled)
            end)

            UpdateToggle()

            local ToggleObj = {}
            function ToggleObj:Set(Value)
                Toggled = Value
                UpdateToggle()
            end
            function ToggleObj:Get()
                return Toggled
            end

            ToggleHolder.Visible = true
            SectionBodySize = UDim2.new(1, 0, 0, SectionBodySize.Y.Offset + 45)
            TweenService:Create(Section, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = SectionBodySize}):Play()

            return ToggleObj
        end

        function SectionObj:CreateSlider(Options)
            Options = Options or {}
            local Title = Options.Title or "Slider"
            local Min = Options.Min or 0
            local Max = Options.Max or 100
            local Default = Options.Default or 50
            local Callback = Options.Callback or function() end

            local SliderHolder = Instance.new("Frame")
            SliderHolder.Name = "SliderHolder"
            SliderHolder.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            SliderHolder.BackgroundTransparency = 0
            SliderHolder.BorderSizePixel = 0
            SliderHolder.Size = UDim2.new(1, 0, 0, 60)
            SliderHolder.Parent = Section

            local SliderTitle = Instance.new("TextLabel")
            SliderTitle.Name = "SliderTitle"
            SliderTitle.BackgroundTransparency = 1
            SliderTitle.Font = Enum.Font.SourceSansSemibold
            SliderTitle.Text = Title
            SliderTitle.TextColor3 = Color3.new(1, 1, 1)
            SliderTitle.TextSize = 16
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            SliderTitle.Position = UDim2.new(0, 10, 0, 5)
            SliderTitle.Size = UDim2.new(0, 200, 0, 20)
            SliderTitle.Parent = SliderHolder

            local SliderValueHolder = Instance.new("ImageLabel")
            SliderValueHolder.Name = "SliderValueHolder"
            SliderValueHolder.Image = "rbxassetid://3570695787"
            SliderValueHolder.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
            SliderValueHolder.ImageTransparency = 0
            SliderValueHolder.ScaleType = Enum.ScaleType.Slice
            SliderValueHolder.SliceCenter = Rect.new(4, 4, 4, 4)
            SliderValueHolder.SliceScale = 1
            SliderValueHolder.BackgroundTransparency = 1
            SliderValueHolder.BorderSizePixel = 0
            SliderValueHolder.Position = UDim2.new(0, 200, 0, 5)
            SliderValueHolder.Size = UDim2.new(0, 50, 0, 20)
            SliderValueHolder.Parent = SliderHolder

            local SliderValue = Instance.new("TextLabel")
            SliderValue.Name = "SliderValue"
            SliderValue.BackgroundTransparency = 1
            SliderValue.Font = Enum.Font.SourceSansSemibold
            SliderValue.Text = tostring(Default)
            SliderValue.TextColor3 = Color3.new(1, 1, 1)
            SliderValue.TextSize = 14
            SliderValue.Parent = SliderValueHolder

            local SliderBackground = Instance.new("Frame")
            SliderBackground.Name = "SliderBackground"
            SliderBackground.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            SliderBackground.BorderSizePixel = 0
            SliderBackground.Selectable = true
            SliderBackground.ClipsDescendants = true
            SliderBackground.Position = UDim2.new(0, 10, 0, 35)
            SliderBackground.Size = UDim2.new(1, -20, 0, 10)
            SliderBackground.Parent = SliderHolder

            local Slider = Instance.new("Frame")
            Slider.Name = "Slider"
            Slider.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
            Slider.BorderSizePixel = 0
            Slider.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
            Slider.Parent = SliderBackground

            local dragging = false

            local function updateSlider(input)
                local pos = UDim2.new(math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1), 0, 1, 0)
                Slider.Size = pos
                local value = math.floor(Min + (Max - Min) * pos.X.Scale)
                SliderValue.Text = tostring(value)
                Callback(value)
            end

            SliderBackground.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateSlider(input)
                end
            end)

            SliderBackground.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            SliderBackground.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    if dragging then
                        updateSlider(input)
                    end
                end
            end)

            local SliderObj = {}
            function SliderObj:Set(Value)
                local pos = (Value - Min) / (Max - Min)
                Slider.Size = UDim2.new(pos, 0, 1, 0)
                SliderValue.Text = tostring(math.floor(Value))
            end
            function SliderObj:Get()
                return tonumber(SliderValue.Text)
            end

            SectionBodySize = UDim2.new(1, 0, 0, SectionBodySize.Y.Offset + 65)
            TweenService:Create(Section, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = SectionBodySize}):Play()

            return SliderObj
        end

        function SectionObj:CreateColorPicker(Options)
            Options = Options or {}
            local Title = Options.Title or "ColorPicker"
            local Default = Options.Default or Color3.new(1, 0, 0)
            local Callback = Options.Callback or function() end

            local H, S, V = Default:ToHSV()

            local ColorPickerHolder = Instance.new("Frame")
            ColorPickerHolder.Name = "ColorPickerHolder"
            ColorPickerHolder.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            ColorPickerHolder.BackgroundTransparency = 0
            ColorPickerHolder.BorderSizePixel = 0
            ColorPickerHolder.Size = UDim2.new(1, 0, 0, 30)
            ColorPickerHolder.ClipsDescendants = true
            ColorPickerHolder.Parent = Section

            local ColorPickerTitle = Instance.new("TextLabel")
            ColorPickerTitle.Name = "ColorPickerTitle"
            ColorPickerTitle.BackgroundTransparency = 1
            ColorPickerTitle.Font = Enum.Font.SourceSansBold
            ColorPickerTitle.Text = Title
            ColorPickerTitle.TextColor3 = Color3.new(1, 1, 1)
            ColorPickerTitle.TextSize = 16
            ColorPickerTitle.TextXAlignment = Enum.TextXAlignment.Left
            ColorPickerTitle.Position = UDim2.new(0, 10, 0, 5)
            ColorPickerTitle.Size = UDim2.new(1, -50, 0, 20)
            ColorPickerTitle.Parent = ColorPickerHolder

            local ColorPickerToggle = Instance.new("ImageLabel")
            ColorPickerToggle.Name = "ColorPickerToggle"
            ColorPickerToggle.Image = "rbxassetid://3570695787"
            ColorPickerToggle.ImageColor3 = Default
            ColorPickerToggle.ScaleType = Enum.ScaleType.Slice
            ColorPickerToggle.SliceCenter = Rect.new(4, 4, 4, 4)
            ColorPickerToggle.SliceScale = 1
            ColorPickerToggle.BackgroundTransparency = 1
            ColorPickerToggle.BorderSizePixel = 0
            ColorPickerToggle.Position = UDim2.new(0, 240, 0, 5)
            ColorPickerToggle.Size = UDim2.new(0, 20, 0, 20)
            ColorPickerToggle.Parent = ColorPickerHolder

            local ColorPickerMain = Instance.new("Frame")
            ColorPickerMain.Name = "ColorPickerMain"
            ColorPickerMain.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            ColorPickerMain.BackgroundTransparency = 0
            ColorPickerMain.BorderSizePixel = 0
            ColorPickerMain.ClipsDescendants = true
            ColorPickerMain.Size = UDim2.new(1, 0, 0, 0)
            ColorPickerMain.ZIndex = 3
            ColorPickerMain.Parent = ColorPickerHolder

            local RainbowToggleHolder = Instance.new("Frame")
            RainbowToggleHolder.Name = "RainbowToggleHolder"
            RainbowToggleHolder.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            RainbowToggleHolder.BackgroundTransparency = 0
            RainbowToggleHolder.BorderSizePixel = 0
            RainbowToggleHolder.Size = UDim2.new(1, 0, 0, 30)
            RainbowToggleHolder.Parent = ColorPickerMain

            local RainbowTitle = Instance.new("TextLabel")
            RainbowTitle.Name = "RainbowTitle"
            RainbowTitle.BackgroundTransparency = 1
            RainbowTitle.Font = Enum.Font.SourceSansSemibold
            RainbowTitle.Text = "Rainbow"
            RainbowTitle.TextColor3 = Color3.new(1, 1, 1)
            RainbowTitle.TextSize = 16
            RainbowTitle.TextXAlignment = Enum.TextXAlignment.Left
            RainbowTitle.Position = UDim2.new(0, 40, 0, 5)
            RainbowTitle.Size = UDim2.new(1, -50, 0, 20)
            RainbowTitle.Parent = RainbowToggleHolder

            local RainbowBackground = Instance.new("ImageLabel")
            RainbowBackground.Name = "RainbowBackground"
            RainbowBackground.Image = "rbxassetid://3570695787"
            RainbowBackground.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
            RainbowBackground.ScaleType = Enum.ScaleType.Slice
            RainbowBackground.SliceCenter = Rect.new(4, 4, 4, 4)
            RainbowBackground.SliceScale = 1
            RainbowBackground.BackgroundTransparency = 1
            RainbowBackground.BorderSizePixel = 0
            RainbowBackground.Position = UDim2.new(0, 10, 0, 5)
            RainbowBackground.Size = UDim2.new(0, 20, 0, 20)
            RainbowBackground.Parent = RainbowToggleHolder

            local RainbowToggleButton = Instance.new("ImageLabel")
            RainbowToggleButton.Name = "RainbowToggleButton"
            RainbowToggleButton.Image = "rbxassetid://3570695787"
            RainbowToggleButton.ImageColor3 = Color3.new(0.4, 0.4, 0.4)
            RainbowToggleButton.ScaleType = Enum.ScaleType.Slice
            RainbowToggleButton.SliceCenter = Rect.new(4, 4, 4, 4)
            RainbowToggleButton.SliceScale = 1
            RainbowToggleButton.BackgroundTransparency = 1
            RainbowToggleButton.BorderSizePixel = 0
            RainbowToggleButton.Position = UDim2.new(0, 10, 0, 5)
            RainbowToggleButton.Size = UDim2.new(0, 20, 0, 20)
            RainbowToggleButton.Parent = RainbowToggleHolder

            local ColorValueR = Instance.new("Frame")
            ColorValueR.Name = "ColorValueR"
            ColorValueR.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            ColorValueR.BackgroundTransparency = 0
            ColorValueR.BorderSizePixel = 0
            ColorValueR.Size = UDim2.new(1, 0, 0, 30)
            ColorValueR.Parent = ColorPickerMain

            local ColorValueRRound = Instance.new("ImageLabel")
            ColorValueRRound.Name = "ColorValueRRound"
            ColorValueRRound.Image = "rbxassetid://3570695787"
            ColorValueRRound.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
            ColorValueRRound.ScaleType = Enum.ScaleType.Slice
            ColorValueRRound.SliceCenter = Rect.new(4, 4, 4, 4)
            ColorValueRRound.SliceScale = 1
            ColorValueRRound.Active = true
            ColorValueRRound.AnchorPoint = Vector2.new(0, 0.5)
            ColorValueRRound.Selectable = true
            ColorValueRRound.BackgroundTransparency = 1
            ColorValueRRound.BorderSizePixel = 0
            ColorValueRRound.Position = UDim2.new(0, 10, 0, 15)
            ColorValueRRound.Size = UDim2.new(1, -20, 0, 20)
            ColorValueRRound.Parent = ColorValueR

            local ColorValueG = Instance.new("Frame")
            ColorValueG.Name = "ColorValueG"
            ColorValueG.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            ColorValueG.BackgroundTransparency = 0
            ColorValueG.BorderSizePixel = 0
            ColorValueG.Size = UDim2.new(1, 0, 0, 30)
            ColorValueG.Parent = ColorPickerMain

            local ColorValueGRound = Instance.new("ImageLabel")
            ColorValueGRound.Name = "ColorValueGRound"
            ColorValueGRound.Image = "rbxassetid://3570695787"
            ColorValueGRound.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
            ColorValueGRound.ScaleType = Enum.ScaleType.Slice
            ColorValueGRound.SliceCenter = Rect.new(4, 4, 4, 4)
            ColorValueGRound.SliceScale = 1
            ColorValueGRound.Active = true
            ColorValueGRound.AnchorPoint = Vector2.new(0, 0.5)
            ColorValueGRound.Selectable = true
            ColorValueGRound.BackgroundTransparency = 1
            ColorValueGRound.BorderSizePixel = 0
            ColorValueGRound.Position = UDim2.new(0, 10, 0, 15)
            ColorValueGRound.Size = UDim2.new(1, -20, 0, 20)
            ColorValueGRound.Parent = ColorValueG

            local ColorValueB = Instance.new("Frame")
            ColorValueB.Name = "ColorValueB"
            ColorValueB.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            ColorValueB.BackgroundTransparency = 0
            ColorValueB.BorderSizePixel = 0
            ColorValueB.Size = UDim2.new(1, 0, 0, 30)
            ColorValueB.Parent = ColorPickerMain

            local ColorValueBRound = Instance.new("ImageLabel")
            ColorValueBRound.Name = "ColorValueBRound"
            ColorValueBRound.Image = "rbxassetid://3570695787"
            ColorValueBRound.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
            ColorValueBRound.ScaleType = Enum.ScaleType.Slice
            ColorValueBRound.SliceCenter = Rect.new(4, 4, 4, 4)
            ColorValueBRound.SliceScale = 1
            ColorValueBRound.Active = true
            ColorValueBRound.AnchorPoint = Vector2.new(0, 0.5)
            ColorValueBRound.Selectable = true
            ColorValueBRound.BackgroundTransparency = 1
            ColorValueBRound.BorderSizePixel = 0
            ColorValueBRound.Position = UDim2.new(0, 10, 0, 15)
            ColorValueBRound.Size = UDim2.new(1, -20, 0, 20)
            ColorValueBRound.Parent = ColorValueB

            local RValue = Instance.new("TextLabel")
            RValue.BackgroundTransparency = 1
            RValue.Font = Enum.Font.SourceSansSemibold
            RValue.Text = "R: 000"
            RValue.TextColor3 = Color3.new(1, 1, 1)
            RValue.TextSize = 14
            RValue.Parent = ColorValueRRound

            local GValue = Instance.new("TextLabel")
            GValue.BackgroundTransparency = 1
            GValue.Font = Enum.Font.SourceSansSemibold
            GValue.Text = "G: 000"
            GValue.TextColor3 = Color3.new(1, 1, 1)
            GValue.TextSize = 14
            GValue.Parent = ColorValueGRound

            local BValue = Instance.new("TextLabel")
            BValue.BackgroundTransparency = 1
            BValue.Font = Enum.Font.SourceSansSemibold
            BValue.Text = "B: 000"
            BValue.TextColor3 = Color3.new(1, 1, 1)
            BValue.TextSize = 14
            BValue.Parent = ColorValueBRound

            local RoundHueHolder = Instance.new("ImageLabel")
            RoundHueHolder.Name = "RoundHueHolder"
            RoundHueHolder.Image = "rbxassetid://4695575676"
            RoundHueHolder.BackgroundTransparency = 1
            RoundHueHolder.BorderSizePixel = 0
            RoundHueHolder.Size = UDim2.new(0, 30, 0, 150)
            RoundHueHolder.Position = UDim2.new(0, 10, 0, 0)
            RoundHueHolder.Parent = ColorPickerMain

            local ColorHue = Instance.new("ImageLabel")
            ColorHue.Name = "ColorHue"
            ColorHue.Image = "http://www.roblox.com/asset/?id=4801885250"
            ColorHue.ScaleType = Enum.ScaleType.Crop
            ColorHue.BackgroundTransparency = 1
            ColorHue.BorderSizePixel = 0
            ColorHue.Size = UDim2.new(1, 0, 1, 0)
            ColorHue.Parent = RoundHueHolder

            local HueMarker = Instance.new("Frame")
            HueMarker.Name = "HueMarker"
            HueMarker.BackgroundColor3 = Color3.new(1, 1, 1)
            HueMarker.BorderSizePixel = 0
            HueMarker.Position = UDim2.new(0, 0, H, 0)
            HueMarker.Size = UDim2.new(1, 0, 0, 3)
            HueMarker.Parent = RoundHueHolder

            local RoundSaturationHolder = Instance.new("ImageLabel")
            RoundSaturationHolder.Name = "RoundSaturationHolder"
            RoundSaturationHolder.BackgroundTransparency = 1
            RoundSaturationHolder.BorderSizePixel = 0
            RoundSaturationHolder.Size = UDim2.new(0, 150, 0, 150)
            RoundSaturationHolder.Position = UDim2.new(0, 50, 0, 0)
            RoundSaturationHolder.Parent = ColorPickerMain

            local ColorSelector = Instance.new("ImageLabel")
            ColorSelector.Name = "ColorSelector"
            ColorSelector.Image = "rbxassetid://4805274903"
            ColorSelector.BackgroundTransparency = 1
            ColorSelector.BorderSizePixel = 0
            ColorSelector.Size = UDim2.new(1, 0, 1, 0)
            ColorSelector.Parent = RoundSaturationHolder

            local SaturationMarker = Instance.new("ImageLabel")
            SaturationMarker.Name = "SaturationMarker"
            SaturationMarker.Image = "http://www.roblox.com/asset/?id=4805639000"
            SaturationMarker.BackgroundTransparency = 1
            SaturationMarker.BorderSizePixel = 0
            SaturationMarker.Size = UDim2.new(0, 10, 0, 10)
            SaturationMarker.Parent = RoundSaturationHolder

            local colorExpanded = false

            ColorPickerToggle.MouseButton1Down:Connect(function()
                colorExpanded = not colorExpanded
                if colorExpanded then
                    TweenService:Create(ColorPickerMain, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 280)}):Play()
                    TweenService:Create(ColorPickerHolder, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 310)}):Play()
                    ColorPickerHolder.ClipsDescendants = false
                else
                    TweenService:Create(ColorPickerMain, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                    TweenService:Create(ColorPickerHolder, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 30)}):Play()
                    ColorPickerHolder.ClipsDescendants = true
                end
            end)

            local function updateColor()
                local color = Color3.fromHSV(H, S, V)
                ColorPickerToggle.ImageColor3 = color
                RValue.Text = "R: " .. math.floor(color.R * 255)
                GValue.Text = "G: " .. math.floor(color.G * 255)
                BValue.Text = "B: " .. math.floor(color.B * 255)
                ColorSelector.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
                Callback(color)
            end

            local hueDragging = false
            RoundHueHolder.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    hueDragging = true
                    H = math.clamp((input.Position.Y - RoundHueHolder.AbsolutePosition.Y) / RoundHueHolder.AbsoluteSize.Y, 0, 1)
                    HueMarker.Position = UDim2.new(0, 0, H, -1.5)
                    updateColor()
                end
            end)

            RoundHueHolder.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    hueDragging = false
                end
            end)

            local satDragging = false
            RoundSaturationHolder.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    satDragging = true
                    local pos = input.Position - RoundSaturationHolder.AbsolutePosition
                    S = math.clamp(pos.X / RoundSaturationHolder.AbsoluteSize.X, 0, 1)
                    V = math.clamp(1 - pos.Y / RoundSaturationHolder.AbsoluteSize.Y, 0, 1)
                    SaturationMarker.Position = UDim2.new(S, -5, 1 - V, -5)
                    updateColor()
                end
            end)

            RoundSaturationHolder.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    satDragging = false
                end
            end)

            local hueConnection
            local satConnection

            RunService.RenderStepped:Connect(function()
                if hueDragging then
                    local input = UserInputService:GetMouseLocation()
                    H = math.clamp((input.Y - RoundHueHolder.AbsolutePosition.Y) / RoundHueHolder.AbsoluteSize.Y, 0, 1)
                    HueMarker.Position = UDim2.new(0, 0, H, -1.5)
                    updateColor()
                end
                if satDragging then
                    local input = UserInputService:GetMouseLocation()
                    local pos = input - RoundSaturationHolder.AbsolutePosition
                    S = math.clamp(pos.X / RoundSaturationHolder.AbsoluteSize.X, 0, 1)
                    V = math.clamp(1 - pos.Y / RoundSaturationHolder.AbsoluteSize.Y, 0, 1)
                    SaturationMarker.Position = UDim2.new(S, -5, 1 - V, -5)
                    updateColor()
                end
            end)

            local rainbowEnabled = false
            local rainbowConnection

            local function updateRainbow()
                H = (H + 0.01) % 1
                HueMarker.Position = UDim2.new(0, 0, H, -1.5)
                ColorSelector.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
                updateColor()
            end

            RainbowBackground.MouseButton1Down:Connect(function()
                rainbowEnabled = not rainbowEnabled
                if rainbowEnabled then
                    TweenService:Create(RainbowToggleButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                    rainbowConnection = RunService.RenderStepped:Connect(updateRainbow)
                else
                    TweenService:Create(RainbowToggleButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
                    if rainbowConnection then
                        rainbowConnection:Disconnect()
                    end
                end
            end)

            updateColor()

            SectionBodySize = UDim2.new(1, 0, 0, SectionBodySize.Y.Offset + 35)
            TweenService:Create(Section, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = SectionBodySize}):Play()

            local CPObj = {}
            function CPObj:Set(color)
                H, S, V = color:ToHSV()
                HueMarker.Position = UDim2.new(0, 0, H, -1.5)
                SaturationMarker.Position = UDim2.new(S, -5, 1 - V, -5)
                updateColor()
            end
            function CPObj:Get()
                return Color3.fromHSV(H, S, V)
            end

            return CPObj
        end

        function SectionObj:CreateButton(Options)
            Options = Options or {}
            local Title = Options.Title or "Button"
            local Callback = Options.Callback or function() end

            local ButtonHolder = Instance.new("Frame")
            ButtonHolder.Name = "ButtonHolder"
            ButtonHolder.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            ButtonHolder.BackgroundTransparency = 0
            ButtonHolder.BorderSizePixel = 0
            ButtonHolder.Size = UDim2.new(1, 0, 0, 40)
            ButtonHolder.Parent = Section

            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.BackgroundColor3 = Color3.new(0.243137, 0.243137, 0.243137)
            Button.BackgroundTransparency = 0
            Button.BorderSizePixel = 0
            Button.Position = UDim2.new(0, 10, 0, 5)
            Button.Size = UDim2.new(1, -20, 0, 30)
            Button.ZIndex = 2
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSansBold
            Button.Text = Title
            Button.TextColor3 = Color3.new(1, 1, 1)
            Button.TextSize = 16
            Button.Parent = ButtonHolder

            local ButtonRound = Instance.new("ImageLabel")
            ButtonRound.Name = "ButtonRound"
            ButtonRound.Active = true
            ButtonRound.AnchorPoint = Vector2.new(0, 0.5)
            ButtonRound.ClipsDescendants = true
            ButtonRound.Selectable = true
            ButtonRound.BackgroundTransparency = 1
            ButtonRound.BorderSizePixel = 0
            ButtonRound.Image = "rbxassetid://3570695787"
            ButtonRound.ImageColor3 = Color3.new(0.243137, 0.243137, 0.243137)
            ButtonRound.ScaleType = Enum.ScaleType.Slice
            ButtonRound.SliceCenter = Rect.new(4, 4, 4, 4)
            ButtonRound.SliceScale = 1
            ButtonRound.Position = UDim2.new(0, 10, 0, 20)
            ButtonRound.Size = UDim2.new(1, -20, 0, 30)
            ButtonRound.ZIndex = 1
            ButtonRound.Parent = ButtonHolder

            Button.MouseButton1Down:Connect(function()
                coroutine.wrap(Callback)()
            end)

            Button.MouseButton1Down:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 5}):Play()
                TweenService:Create(ButtonRound, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 5}):Play()
            end)

            SectionBodySize = UDim2.new(1, 0, 0, SectionBodySize.Y.Offset + 45)
            TweenService:Create(Section, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = SectionBodySize}):Play()

            local ButtonObj = {}
            function ButtonObj:Set(Text)
                Button.Text = Text
            end
            function ButtonObj:Get()
                return Button.Text
            end

            return ButtonObj
        end

        function SectionObj:CreateTextbox(Options)
            Options = Options or {}
            local Title = Options.Title or "Textbox"
            local Placeholder = Options.Placeholder or "Input"
            local Callback = Options.Callback or function() end

            local TextBoxHolder = Instance.new("Frame")
            TextBoxHolder.Name = "TextBoxHolder"
            TextBoxHolder.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            TextBoxHolder.BackgroundTransparency = 0
            TextBoxHolder.BorderSizePixel = 0
            TextBoxHolder.Size = UDim2.new(1, 0, 0, 40)
            TextBoxHolder.ClipsDescendants = true
            TextBoxHolder.Parent = Section

            local TextBox = Instance.new("TextBox")
            TextBox.Name = "TextBox"
            TextBox.BackgroundColor3 = Color3.new(0.243137, 0.243137, 0.243137)
            TextBox.BackgroundTransparency = 0
            TextBox.BorderSizePixel = 0
            TextBox.Position = UDim2.new(0, 10, 0, 5)
            TextBox.Size = UDim2.new(1, -20, 0, 30)
            TextBox.ZIndex = 2
            TextBox.Font = Enum.Font.SourceSansBold
            TextBox.PlaceholderText = Placeholder
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.new(1, 1, 1)
            TextBox.TextSize = 16
            TextBox.Parent = TextBoxHolder

            local TextBoxRound = Instance.new("ImageLabel")
            TextBoxRound.Name = "TextBoxRound"
            TextBoxRound.Active = true
            TextBoxRound.AnchorPoint = Vector2.new(0, 0.5)
            TextBoxRound.Selectable = true
            TextBoxRound.BackgroundTransparency = 1
            TextBoxRound.BorderSizePixel = 0
            TextBoxRound.Image = "rbxassetid://3570695787"
            TextBoxRound.ImageColor3 = Color3.new(0.243137, 0.243137, 0.243137)
            TextBoxRound.ScaleType = Enum.ScaleType.Slice
            TextBoxRound.SliceCenter = Rect.new(4, 4, 4, 4)
            TextBoxRound.SliceScale = 1
            TextBoxRound.Position = UDim2.new(0, 10, 0, 20)
            TextBoxRound.Size = UDim2.new(1, -20, 0, 30)
            TextBoxRound.ZIndex = 1
            TextBoxRound.Parent = TextBoxHolder

            TextBox.FocusLost:Connect(function(enterPressed)
                Callback(TextBox.Text)
            end)

            TextBox.MouseButton1Down:Connect(function()
                -- focus gained
            end)

            TextBox.MouseButton1Down:Connect(function()
                TweenService:Create(TextBox, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 5}):Play()
                TweenService:Create(TextBoxRound, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 5}):Play()
            end)

            SectionBodySize = UDim2.new(1, 0, 0, SectionBodySize.Y.Offset + 45)
            TweenService:Create(Section, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = SectionBodySize}):Play()

            local TBObj = {}
            function TBObj:Set(Text)
                TextBox.Text = Text
            end
            function TBObj:Get()
                return TextBox.Text
            end

            return TBObj
        end

        function SectionObj:CreateDropdown(Options)
            Options = Options or {}
            local Title = Options.Title or "Dropdown"
            local Items = Options.Items or {}
            local Default = Options.Default or ""
            local Callback = Options.Callback or function() end

            local selectedItem = Default

            local DropdownHolder = Instance.new("Frame")
            DropdownHolder.Name = "DropdownHolder"
            DropdownHolder.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            DropdownHolder.BackgroundTransparency = 0
            DropdownHolder.BorderSizePixel = 0
            DropdownHolder.Size = UDim2.new(1, 0, 0, 40)
            DropdownHolder.ClipsDescendants = true
            DropdownHolder.Parent = Section

            local DropdownTitle = Instance.new("TextLabel")
            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.BackgroundTransparency = 1
            DropdownTitle.Font = Enum.Font.SourceSansBold
            DropdownTitle.Text = Title
            DropdownTitle.TextColor3 = Color3.new(1, 1, 1)
            DropdownTitle.TextSize = 16
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            DropdownTitle.Position = UDim2.new(0, 10, 0, 5)
            DropdownTitle.Size = UDim2.new(1, -50, 0, 30)
            DropdownTitle.ZIndex = 2
            DropdownTitle.Parent = DropdownHolder

            local DropdownRound = Instance.new("ImageLabel")
            DropdownRound.Name = "DropdownRound"
            DropdownRound.Active = true
            DropdownRound.AnchorPoint = Vector2.new(0, 0.5)
            DropdownRound.ClipsDescendants = true
            DropdownRound.Selectable = true
            DropdownRound.BackgroundTransparency = 1
            DropdownRound.BorderSizePixel = 0
            DropdownRound.Image = "rbxassetid://3570695787"
            DropdownRound.ImageColor3 = Color3.new(0.243137, 0.243137, 0.243137)
            DropdownRound.ScaleType = Enum.ScaleType.Slice
            DropdownRound.SliceCenter = Rect.new(4, 4, 4, 4)
            DropdownRound.SliceScale = 1
            DropdownRound.Position = UDim2.new(0, 220, 0, 20)
            DropdownRound.Size = UDim2.new(0, 120, 0, 30)
            DropdownRound.ZIndex = 1
            DropdownRound.Parent = DropdownHolder

            local DropdownToggle = Instance.new("TextButton")
            DropdownToggle.Name = "DropdownToggle"
            DropdownToggle.Font = Enum.Font.SourceSansBold
            DropdownToggle.Text = ">"
            DropdownToggle.TextColor3 = Color3.new(1, 1, 1)
            DropdownToggle.TextSize = 16
            DropdownToggle.BackgroundTransparency = 1
            DropdownToggle.BorderSizePixel = 0
            DropdownToggle.AutoButtonColor = false
            DropdownToggle.Position = UDim2.new(0, 325, 0, 5)
            DropdownToggle.Size = UDim2.new(0, 15, 0, 30)
            DropdownToggle.ZIndex = 3
            DropdownToggle.Parent = DropdownHolder

            local DropdownMain = Instance.new("ScrollingFrame")
            DropdownMain.Name = "DropdownMain"
            DropdownMain.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
            DropdownMain.BackgroundTransparency = 0
            DropdownMain.BorderSizePixel = 0
            DropdownMain.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
            DropdownMain.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropdownMain.ScrollBarThickness = 4
            DropdownMain.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
            DropdownMain.ScrollingDirection = Enum.ScrollingDirection.Y
            DropdownMain.Position = UDim2.new(0, 220, 0, 35)
            DropdownMain.Size = UDim2.new(0, 120, 0, 0)
            DropdownMain.ZIndex = 5
            DropdownMain.Parent = DropdownHolder

            local ButtonLayout = Instance.new("UIListLayout")
            ButtonLayout.Name = "ButtonLayout"
            ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ButtonLayout.Parent = DropdownMain

            local dropdownExpanded = false
            local dropdownButtons = {}
            local maxDropdownHeight = 0

            for _, item in pairs(Items) do
                local Button = Instance.new("TextButton")
                Button.Name = "Button"
                Button.Font = Enum.Font.SourceSansBold
                Button.Text = item
                Button.TextColor3 = Color3.new(1, 1, 1)
                Button.TextSize = 16
                Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                Button.BackgroundTransparency = 0
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 0, 30)
                Button.ZIndex = 6
                Button.LayoutOrder = #dropdownButtons + 1
                Button.Parent = DropdownMain

                local ButtonRound = Instance.new("ImageLabel")
                ButtonRound.Name = "ButtonRound"
                ButtonRound.Active = true
                ButtonRound.AnchorPoint = Vector2.new(0, 0.5)
                ButtonRound.Selectable = true
                ButtonRound.BackgroundTransparency = 1
                ButtonRound.BorderSizePixel = 0
                ButtonRound.Image = "rbxassetid://3570695787"
                ButtonRound.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
                ButtonRound.ScaleType = Enum.ScaleType.Slice
                ButtonRound.SliceCenter = Rect.new(4, 4, 4, 4)
                ButtonRound.SliceScale = 1
                ButtonRound.Position = UDim2.new(0, 0, 0, 15)
                ButtonRound.Size = UDim2.new(1, 0, 0, 30)
                ButtonRound.ZIndex = 5
                ButtonRound.Parent = DropdownMain

                Button.MouseButton1Down:Connect(function()
                    selectedItem = item
                    DropdownToggle.Text = ">"
                    TweenService:Create(DropdownMain, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 120, 0, 0)}):Play()
                    TweenService:Create(DropdownToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                    DropdownHolder.ClipsDescendants = true
                    dropdownExpanded = false
                    Callback(item)
                end)

                Button.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        TweenService:Create(Button, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2}):Play()
                    end
                end)

                Button.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        TweenService:Create(Button, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    end
                end)

                dropdownButtons[item] = Button
                maxDropdownHeight = maxDropdownHeight + 35
            end

            DropdownToggle.MouseButton1Down:Connect(function()
                dropdownExpanded = not dropdownExpanded
                if dropdownExpanded then
                    DropdownMain.Size = UDim2.new(0, 120, 0, math.min(maxDropdownHeight, 150))
                    TweenService:Create(DropdownToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 90}):Play()
                    DropdownHolder.ClipsDescendants = false
                else
                    TweenService:Create(DropdownMain, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 120, 0, 0)}):Play()
                    TweenService:Create(DropdownToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                    DropdownHolder.ClipsDescendants = true
                end
            end)

            SectionBodySize = UDim2.new(1, 0, 0, SectionBodySize.Y.Offset + 45)
            TweenService:Create(Section, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = SectionBodySize}):Play()

            local DDObj = {}
            function DDObj:Set(Item)
                selectedItem = Item
                Callback(Item)
            end
            function DDObj:Get()
                return selectedItem
            end

            return DDObj
        end

        return SectionObj
    end

    return WindowObj
end

return WizardLibrary
