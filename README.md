# 🧙 Wizard UI Library

A lightweight, simple and customizable Roblox UI library written in LuaU.

---

# 📥 Installation

Load the library directly from GitHub:

```lua
local Wizard = loadstring(game:HttpGet("https://github.com/w3rn/Wizard-UI-Library/blob/main/WizardLibrary.lua?raw=true"))()
```

Or using the Raw URL:

```lua
local Wizard = loadstring(game:HttpGet("https://raw.githubusercontent.com/w3rn/Wizard-UI-Library/main/WizardLibrary.lua"))()
```

---

# 🚀 Creating a Window

```lua
local Window = Wizard:CreateWindow("Wizard UI")
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `Title` | `string` | Window title |

---

# 📂 Creating a Section

```lua
local Main = Window:NewSection("Main")
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `Title` | `string` | Section name |

---

# 🔘 Button

```lua
Main:CreateButton({
    Title = "Click Me",

    Callback = function()
        print("Clicked!")
    end
})
```

### Properties

| Name | Type |
|------|------|
| `Title` | string |
| `Callback` | function |

---

# ✅ Toggle

```lua
local Toggle = Main:CreateToggle({
    Title = "God Mode",

    Default = false,

    Callback = function(Value)
        print(Value)
    end
})
```

### Properties

| Name | Type |
|------|------|
| `Title` | string |
| `Default` | boolean |
| `Callback` | function |

### Methods

Set value

```lua
Toggle:Set(true)
```

Get value

```lua
print(Toggle:Get())
```

---

# 🎚 Slider

```lua
local Slider = Main:CreateSlider({
    Title = "WalkSpeed",

    Min = 16,
    Max = 100,

    Default = 16,

    Callback = function(Value)
        print(Value)
    end
})
```

### Properties

| Name | Type |
|------|------|
| `Title` | string |
| `Min` | number |
| `Max` | number |
| `Default` | number |
| `Callback` | function |

### Methods

```lua
Slider:Set(50)
```

```lua
print(Slider:Get())
```

---

# ⌨️ Textbox

```lua
local Textbox = Main:CreateTextbox({
    Title = "Username",

    Placeholder = "Enter text...",

    Callback = function(Text)
        print(Text)
    end
})
```

### Properties

| Name | Type |
|------|------|
| `Title` | string |
| `Placeholder` | string |
| `Callback` | function |

### Methods

```lua
Textbox:Set("Wizard")
```

```lua
print(Textbox:Get())
```

---

# 📜 Dropdown

```lua
local Dropdown = Main:CreateDropdown({
    Title = "Fruit",

    Items = {
        "Apple",
        "Banana",
        "Orange"
    },

    Default = "Apple",

    Callback = function(Value)
        print(Value)
    end
})
```

### Properties

| Name | Type |
|------|------|
| `Title` | string |
| `Items` | table |
| `Default` | string |
| `Callback` | function |

### Methods

```lua
Dropdown:Set("Orange")
```

```lua
print(Dropdown:Get())
```

---

# 🎨 Color Picker

```lua
local Picker = Main:CreateColorPicker({
    Title = "Theme",

    Default = Color3.fromRGB(0,170,255),

    Callback = function(Color)
        print(Color)
    end
})
```

### Properties

| Name | Type |
|------|------|
| `Title` | string |
| `Default` | Color3 |
| `Callback` | function |

### Methods

```lua
Picker:Set(Color3.fromRGB(255,0,0))
```

```lua
print(Picker:Get())
```

---

# 📖 Object Hierarchy

```
Wizard
└── Window
    ├── Section
    │   ├── Button
    │   ├── Toggle
    │   ├── Slider
    │   ├── Textbox
    │   ├── Dropdown
    │   └── ColorPicker
    └── Section
```

---

# ✨ Features

- Lightweight
- Draggable window
- Sections
- Buttons
- Toggles
- Sliders
- Textboxes
- Dropdowns
- Color Picker
- Easy API
- Fully written in LuaU

---

# 💻 Complete Example

```lua
local Wizard = loadstring(game:HttpGet("https://github.com/w3rn/Wizard-UI-Library/blob/main/WizardLibrary.lua?raw=true"))()

local Window = Wizard:CreateWindow("Wizard UI Example")

local Main = Window:NewSection("Main")

-- Button
Main:CreateButton({
    Title = "Print Hello",

    Callback = function()
        print("Hello!")
    end
})

-- Toggle
local Toggle = Main:CreateToggle({
    Title = "God Mode",

    Default = false,

    Callback = function(Value)
        print("Toggle:", Value)
    end
})

Toggle:Set(true)
print(Toggle:Get())

-- Slider
local Slider = Main:CreateSlider({
    Title = "WalkSpeed",

    Min = 16,
    Max = 100,

    Default = 16,

    Callback = function(Value)
        print("Slider:", Value)
    end
})

Slider:Set(50)
print(Slider:Get())

-- Textbox
local Textbox = Main:CreateTextbox({
    Title = "Username",

    Placeholder = "Type here...",

    Callback = function(Text)
        print("Textbox:", Text)
    end
})

Textbox:Set("Wizard User")
print(Textbox:Get())

-- Dropdown
local Dropdown = Main:CreateDropdown({
    Title = "Fruit",

    Items = {
        "Apple",
        "Banana",
        "Orange"
    },

    Default = "Apple",

    Callback = function(Item)
        print("Dropdown:", Item)
    end
})

Dropdown:Set("Orange")
print(Dropdown:Get())

-- Color Picker
local Picker = Main:CreateColorPicker({
    Title = "Theme",

    Default = Color3.fromRGB(0,170,255),

    Callback = function(Color)
        print(Color)
    end
})

Picker:Set(Color3.fromRGB(255,0,0))
print(Picker:Get())
```

---

Made with ❤️ using **Wizard UI Library**.
