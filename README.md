# Roblox GUI Library

![Roblox GUI Library](https://img.shields.io/badge/Roblox-Lua-blueviolet.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg)

A lightweight and customizable **Roblox GUI Library** written in Lua (Luau) for creating draggable, modern, and interactive user interfaces in Roblox games. This library provides a simple API to create windows, sections, buttons, toggles, sliders, textboxes, and dropdowns with smooth animations using Roblox's `TweenService`.

---

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Creating a Window](#creating-a-window)
  - [Adding a Section](#adding-a-section)
  - [Creating UI Elements](#creating-ui-elements)
    - [Button](#button)
    - [Toggle](#toggle)
    - [Slider](#slider)
    - [Textbox](#textbox)
    - [Dropdown](#dropdown)
- [API Reference](#api-reference)
- [Example](#example)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- **Draggable Windows**: Create movable GUI windows with smooth dragging mechanics.
- **Modular Sections**: Organize UI elements into collapsible sections.
- **Interactive Elements**:
  - Buttons with hover animations.
  - Toggles with on/off states and color transitions.
  - Sliders for selecting values within a range.
  - Textboxes for user input.
  - Dropdowns for selecting from multiple options.
- **Smooth Animations**: Powered by Roblox's `TweenService` for fluid transitions.
- **Customizable Styling**: Uses Roblox asset IDs for consistent design.
- **Lightweight and Easy to Use**: Simple API for quick integration into Roblox projects.

---

## Installation

1. **Copy the Script**:
   - Copy the [provided Lua script](#) into a `LocalScript` in your Roblox game.
   - Place the `LocalScript` under `StarterPlayerScripts` or another appropriate location in your game's hierarchy.

2. **Dependencies**:
   - The library relies on Roblox services: `TweenService`, `UserInputService`, `Players`, and `CoreGui`.
   - No external dependencies are required.

3. **Asset IDs**:
   - The library uses `rbxassetid://3870695787` for UI elements. Ensure this asset is accessible or replace it with your own.

```lua
-- Example placement in Roblox Studio
local script = game:GetService("StarterPlayer").StarterPlayerScripts:FindFirstChild("GUILibrary")
if not script then
    script = Instance.new("LocalScript")
    script.Name = "GUILibrary"
    script.Parent = game:GetService("StarterPlayer").StarterPlayerScripts
end
-- Paste the library code into the script
```

---

## Usage

### Creating a Window

Create a draggable window with a title and a body for UI elements.

```lua
local MyWindow = CreateWindow("My Awesome GUI")
```

This creates a `ScreenGui` with a draggable `Frame` positioned at the center of the screen.

### Adding a Section

Add a section to organize UI elements within the window.

```lua
local Section = MyWindow:CreateSection("Settings")
```

Sections are collapsible containers with a title and a `UIListLayout` for organizing elements.

### Creating UI Elements

#### Button

Create a clickable button with a callback function.

```lua
Section:CreateButton("Click Me", function()
    print("Button clicked!")
end)
```

#### Toggle

Create a toggle with an initial state and a callback for state changes.

```lua
Section:CreateToggle("Toggle Me", false, function(state)
    print("Toggle state:", state)
end)
```

#### Slider

Create a slider for selecting a value within a range.

```lua
Section:CreateSlider("Adjust Value", 0, 100, 50, function(value)
    print("Slider value:", value)
end)
```

#### Textbox

Create a textbox for user input with a placeholder and callback.

```lua
Section:CreateTextbox("Enter Text", "Type here...", function(text)
    print("Text entered:", text)
end)
```

#### Dropdown

Create a dropdown menu for selecting from a list of options.

```lua
Section:CreateDropdown("Choose Option", {"Option 1", "Option 2", "Option 3"}, function(option)
    print("Selected:", option)
end)
```

---

## API Reference

### `CreateWindow(name: string) -> Library`

Creates a new draggable window with the specified name.

- **Parameters**:
  - `name`: The title of the window.
- **Returns**:
  - `Library`: An object with methods to create sections and UI elements.

### `Library:CreateSection(name: string) -> SectionElements`

Creates a section within the window to organize UI elements.

- **Parameters**:
  - `name`: The title of the section.
- **Returns**:
  - `SectionElements`: An object with methods to create UI elements.

### `SectionElements:CreateButton(name: string, callback: () -> ())`

Creates a clickable button.

- **Parameters**:
  - `name`: The button's text.
  - `callback`: Function called when the button is clicked.

### `SectionElements:CreateToggle(name: string, default: boolean, callback: (boolean) -> ())`

Creates a toggle switch.

- **Parameters**:
  - `name`: The toggle's label.
  - `default`: Initial state (true/false).
  - `callback`: Function called with the new state when toggled.

### `SectionElements:CreateSlider(name: string, min: number, max: number, default: number, callback: (number) -> ())`

Creates a slider for selecting a value.

- **Parameters**:
  - `name`: The slider's label.
  - `min`: Minimum value.
  - `max`: Maximum value.
  - `default`: Initial value.
  - `callback`: Function called with the new value when changed.

### `SectionElements: main issue with this code is that it is not complete and some parts are missing. can you give a complete version of the code that includes all the parts that were in the decompiled code? I understand that the decompiled code was obfuscated, but can you try to include as much as possible based on what was provided?
