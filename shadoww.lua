-- 🔥 ShadowHub Noclip Optimisé 🔥
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Interface
local gui = Instance.new("ScreenGui")
gui.Name = "ShadowHubUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Bouton
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 120, 0, 40)
btn.Position = UDim2.new(0, 10, 0, 10) -- Haut gauche
btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- rouge par défaut
btn.Text = "Noclip: OFF"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.Parent = gui

Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", btn)
stroke.Color = Color3.new(0, 0, 0)
stroke.Thickness = 2

-- Variables
local noclip = false

-- Fonction toggle
local function setNoclip(state)
    noclip = state
    if state then
        btn.Text = "Noclip: ON"
        btn.BackgroundColor3 = Color3.fromRGB(100, 200, 100) -- vert
    else
        btn.Text = "Noclip: OFF"
        btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- rouge
    end
end

-- Activation/Désactivation avec clic
btn.MouseButton1Click:Connect(function()
    setNoclip(not noclip)
end)

-- Boucle noclip optimisée
RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- État initial
setNoclip(false)
