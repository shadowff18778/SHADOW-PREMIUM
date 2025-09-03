-- 🔥 ShadowHub Ultra Stylé 🔥
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Interface principale
local gui = Instance.new("ScreenGui")
gui.Name = "ShadowHubUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- =========================
-- Bouton pour ouvrir le menu
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
-- Frame menu principal
-- =========================
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 260, 0, 260)
menuFrame.Position = UDim2.new(0, 10, 0, 70)
menuFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
menuFrame.Visible = false
menuFrame.Parent = gui
Instance.new("UICorner", menuFrame).CornerRadius = UDim.new(0,15)
local strokeFrame = Instance.new("UIStroke", menuFrame)
strokeFrame.Color = Color3.fromRGB(80,80,80)
strokeFrame.Thickness = 2

-- =========================
-- Bouton Noclip dans le menu
-- =========================
local noclipBtn = Instance.new("TextButton", menuFrame)
noclipBtn.Size = UDim2.new(0, 220, 0, 40)
noclipBtn.Position = UDim2.new(0, 20, 0, 20)
noclipBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.fromRGB(255,255,255)
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 18
Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", noclipBtn).Color = Color3.fromRGB(100,100,100)
Instance.new("UIStroke", noclipBtn).Thickness = 2

-- =========================
-- Champ et toggle vitesse
-- =========================
local speedBox = Instance.new("TextBox", menuFrame)
speedBox.Size = UDim2.new(0, 220, 0, 40)
speedBox.Position = UDim2.new(0, 20, 0, 80)
speedBox.PlaceholderText = "Entrez votre vitesse"
speedBox.TextColor3 = Color3.fromRGB(255,255,255)
speedBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 20
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", speedBox).Color = Color3.fromRGB(100,100,100)
Instance.new("UIStroke", speedBox).Thickness = 2

local speedToggle = Instance.new("TextButton", menuFrame)
speedToggle.Size = UDim2.new(0, 220, 0, 40)
speedToggle.Position = UDim2.new(0, 20, 0, 130)
speedToggle.Text = "Vitesse: OFF"
speedToggle.BackgroundColor3 = Color3.fromRGB(200,50,50)
speedToggle.TextColor3 = Color3.fromRGB(255,255,255)
speedToggle.Font = Enum.Font.GothamBold
speedToggle.TextSize = 18
Instance.new("UICorner", speedToggle).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", speedToggle).Color = Color3.fromRGB(100,100,100)
Instance.new("UIStroke", speedToggle).Thickness = 2

-- =========================
-- Champ et toggle saut
-- =========================
local jumpBox = Instance.new("TextBox", menuFrame)
jumpBox.Size = UDim2.new(0, 220, 0, 40)
jumpBox.Position = UDim2.new(0, 20, 0, 180)
jumpBox.PlaceholderText = "Entrez votre jump"
jumpBox.TextColor3 = Color3.fromRGB(255,255,255)
jumpBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
jumpBox.Font = Enum.Font.Gotham
jumpBox.TextSize = 20
Instance.new("UICorner", jumpBox).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", jumpBox).Color = Color3.fromRGB(100,100,100)
Instance.new("UIStroke", jumpBox).Thickness = 2

local jumpToggle = Instance.new("TextButton", menuFrame)
jumpToggle.Size = UDim2.new(0, 220, 0, 40)
jumpToggle.Position = UDim2.new(0, 20, 0, 230)
jumpToggle.Text = "Jump: OFF"
jumpToggle.BackgroundColor3 = Color3.fromRGB(200,50,50)
jumpToggle.TextColor3 = Color3.fromRGB(255,255,255)
jumpToggle.Font = Enum.Font.GothamBold
jumpToggle.TextSize = 18
Instance.new("UICorner", jumpToggle).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", jumpToggle).Color = Color3.fromRGB(100,100,100)
Instance.new("UIStroke", jumpToggle).Thickness = 2

-- =========================
-- Toggle menu
-- =========================
menuBtn.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)

-- =========================
-- Variables
-- =========================
local noclip = false
local speedActive = false
local jumpActive = false
local customSpeed = 16
local customJump = 50

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
