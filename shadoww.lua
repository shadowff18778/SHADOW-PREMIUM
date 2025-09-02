-- 🔥 ShadowHub Noclip + Speed Menu 🔥
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Interface principale
local gui = Instance.new("ScreenGui")
gui.Name = "ShadowHubUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Bouton Noclip flottant
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0, 120, 0, 40)
noclipBtn.Position = UDim2.new(0, 10, 0, 10)
noclipBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.new(1, 1, 1)
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 18
noclipBtn.Parent = gui
Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", noclipBtn).Thickness = 2

-- Variables Noclip
local noclip = false
local function setNoclip(state)
    noclip = state
    if state then
        noclipBtn.Text = "Noclip: ON"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    else
        noclipBtn.Text = "Noclip: OFF"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end

noclipBtn.MouseButton1Click:Connect(function()
    setNoclip(not noclip)
end)

RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

setNoclip(false)

-- =========================
-- Mini Menu pour Speed
-- =========================
local menuBtn = Instance.new("TextButton")
menuBtn.Size = UDim2.new(0, 40, 0, 40)
menuBtn.Position = UDim2.new(0, 10, 0, 60)
menuBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
menuBtn.Text = "⚡"
menuBtn.TextColor3 = Color3.new(1,1,1)
menuBtn.Font = Enum.Font.GothamBold
menuBtn.TextSize = 24
menuBtn.Parent = gui
Instance.new("UICorner", menuBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", menuBtn).Thickness = 2

local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 220, 0, 120)
menuFrame.Position = UDim2.new(0, 10, 0, 110)
menuFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
menuFrame.Visible = false
menuFrame.Parent = gui
Instance.new("UICorner", menuFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", menuFrame).Thickness = 2
Instance.new("UIStroke", menuFrame).Color = Color3.fromRGB(100,100,100)

-- Champ pour vitesse
local speedBox = Instance.new("TextBox", menuFrame)
speedBox.Size = UDim2.new(0, 180, 0, 40)
speedBox.Position = UDim2.new(0, 20, 0, 20)
speedBox.PlaceholderText = "Entrez votre vitesse"
speedBox.TextColor3 = Color3.new(1,1,1)
speedBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 20
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", speedBox).Color = Color3.fromRGB(100,100,100)
Instance.new("UIStroke", speedBox).Thickness = 2

-- Toggle pour la vitesse
local speedToggle = Instance.new("TextButton", menuFrame)
speedToggle.Size = UDim2.new(0, 180, 0, 40)
speedToggle.Position = UDim2.new(0, 20, 0, 70)
speedToggle.Text = "Vitesse: OFF"
speedToggle.BackgroundColor3 = Color3.fromRGB(200,50,50)
speedToggle.TextColor3 = Color3.new(1,1,1)
speedToggle.Font = Enum.Font.GothamBold
speedToggle.TextSize = 18
Instance.new("UICorner", speedToggle).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", speedToggle).Color = Color3.fromRGB(100,100,100)
Instance.new("UIStroke", speedToggle).Thickness = 2

local speedActive = false
local customSpeed = 16 -- par défaut

-- Toggle vitesse
speedToggle.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    if speedActive then
        speedToggle.Text = "Vitesse: ON"
        speedToggle.BackgroundColor3 = Color3.fromRGB(100,200,100)
        LocalPlayer.Character.Humanoid.WalkSpeed = customSpeed
    else
        speedToggle.Text = "Vitesse: OFF"
        speedToggle.BackgroundColor3 = Color3.fromRGB(200,50,50)
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-- Menu bouton toggle
menuBtn.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)

-- Détecter la vitesse entrée
speedBox.FocusLost:Connect(function(enterPressed)
    local val = tonumber(speedBox.Text)
    if val then
        customSpeed = val
        if speedActive and LocalPlayer.Character then
            LocalPlayer.Character.Humanoid.WalkSpeed = customSpeed
        end
    end
end)
