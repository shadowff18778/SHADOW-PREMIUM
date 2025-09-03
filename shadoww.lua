-- 🔥 ShadowHub Ultra Stylé + Scroll & Drag 🔥
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Name = "ShadowHubUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- =========================
-- Bouton menu principal
-- =========================
local menuBtn = Instance.new("TextButton")
menuBtn.Size = UDim2.new(0, 50, 0, 50)
menuBtn.Position = UDim2.new(0, 10, 0, 10)
menuBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
menuBtn.Text = "☰"
menuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
menuBtn.Font = Enum.Font.GothamBold
menuBtn.TextSize = 24
menuBtn.Parent = gui
Instance.new("UICorner", menuBtn).CornerRadius = UDim.new(0,12)
local strokeBtn = Instance.new("UIStroke", menuBtn)
strokeBtn.Color = Color3.fromRGB(100,100,100)
strokeBtn.Thickness = 2

-- =========================
-- Menu principal avec ScrollFrame
-- =========================
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 260, 0, 200)
menuFrame.Position = UDim2.new(0, 10, 0, 70)
menuFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
menuFrame.Visible = false
menuFrame.Parent = gui
Instance.new("UICorner", menuFrame).CornerRadius = UDim.new(0,15)
local strokeFrame = Instance.new("UIStroke", menuFrame)
strokeFrame.Color = Color3.fromRGB(80,80,80)
strokeFrame.Thickness = 2

-- ScrollFrame pour contenir tous les boutons
local scroll = Instance.new("ScrollingFrame", menuFrame)
scroll.Size = UDim2.new(1, -10, 1, -10)
scroll.Position = UDim2.new(0, 5, 0, 5)
scroll.CanvasSize = UDim2.new(0, 0, 0, 500) -- ajustable
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.Parent = menuFrame

-- UIListLayout pour les boutons
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- =========================
-- Fonction pour créer un bouton stylé
-- =========================
local function createButton(text, parent, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(100,100,100)
    Instance.new("UIStroke", btn).Thickness = 2
    return btn
end

-- =========================
-- Boutons et variables
-- =========================
local noclipBtn = createButton("Noclip: OFF", scroll, Color3.fromRGB(200,50,50))
local speedBox = Instance.new("TextBox", scroll)
speedBox.Size = UDim2.new(1, 0, 0, 40)
speedBox.PlaceholderText = "Entrez votre vitesse"
speedBox.TextColor3 = Color3.fromRGB(255,255,255)
speedBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 20
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", speedBox).Color = Color3.fromRGB(100,100,100)
Instance.new("UIStroke", speedBox).Thickness = 2

local speedToggle = createButton("Vitesse: OFF", scroll, Color3.fromRGB(200,50,50))
local jumpBox = Instance.new("TextBox", scroll)
jumpBox.Size = UDim2.new(1, 0, 0, 40)
jumpBox.PlaceholderText = "Entrez votre jump"
jumpBox.TextColor3 = Color3.fromRGB(255,255,255)
jumpBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
jumpBox.Font = Enum.Font.Gotham
jumpBox.TextSize = 20
Instance.new("UICorner", jumpBox).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", jumpBox).Color = Color3.fromRGB(100,100,100)
Instance.new("UIStroke", jumpBox).Thickness = 2

local jumpToggle = createButton("Jump: OFF", scroll, Color3.fromRGB(200,50,50))
local settingsBtn = createButton("Settings", scroll, Color3.fromRGB(50,50,200))

-- =========================
-- Variables
-- =========================
local noclip = false
local speedActive = false
local jumpActive = false
local customSpeed = 16
local customJump = 50
local dragMode = false

-- =========================
-- Fonctions
-- =========================
local function setNoclip(state)
    noclip = state
    if state then
        noclipBtn.Text = "Noclip: ON"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(100,200,100)
    else
        noclipBtn.Text = "Noclip: OFF"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    end
end

local function updateSpeed()
    if speedActive and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = customSpeed
    elseif LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end

local function updateJump()
    if jumpActive and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.JumpPower = customJump
    elseif LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end

-- =========================
-- Connexions
-- =========================
menuBtn.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)

noclipBtn.MouseButton1Click:Connect(function()
    setNoclip(not noclip)
end)

speedToggle.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    if speedActive then
        speedToggle.Text = "Vitesse: ON"
        speedToggle.BackgroundColor3 = Color3.fromRGB(100,200,100)
    else
        speedToggle.Text = "Vitesse: OFF"
        speedToggle.BackgroundColor3 = Color3.fromRGB(200,50,50)
    end
    updateSpeed()
end)

jumpToggle.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    if jumpActive then
        jumpToggle.Text = "Jump: ON"
        jumpToggle.BackgroundColor3 = Color3.fromRGB(100,200,100)
    else
        jumpToggle.Text = "Jump: OFF"
        jumpToggle.BackgroundColor3 = Color3.fromRGB(200,50,50)
    end
    updateJump()
end)

speedBox.FocusLost:Connect(function(enterPressed)
    local val = tonumber(speedBox.Text)
    if val then
        customSpeed = val
        updateSpeed()
    end
end)

jumpBox.FocusLost:Connect(function(enterPressed)
    local val = tonumber(jumpBox.Text)
    if val then
        customJump = val
        updateJump()
    end
end)

-- =========================
-- Drag settings pour bouton menu
-- =========================
settingsBtn.MouseButton1Click:Connect(function()
    dragMode = not dragMode
    if dragMode then
        settingsBtn.Text = "Drag Mode: ON"
        settingsBtn.BackgroundColor3 = Color3.fromRGB(100,200,100)
    else
        settingsBtn.Text = "Settings"
        settingsBtn.BackgroundColor3 = Color3.fromRGB(50,50,200)
    end
end)

local dragging = false
local dragInput, dragStart, startPos

menuBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and dragMode then
        dragging = true
        dragStart = input.Position
        startPos = menuBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

menuBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        menuBtn.Position = newPos
        menuFrame.Position = newPos + UDim2.new(0,0,0,60)
    end
end)

-- =========================
-- Boucle Noclip
-- =========================
RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- =========================
-- Initialisation
-- =========================
setNoclip(false)
updateSpeed()
updateJump()
