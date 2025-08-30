local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local Gui = Instance.new("ScreenGui")
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
Gui.Name = "InvisibleToggleGui"

-- Création du bouton discret
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 60, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10) -- Coin supérieur gauche
toggleButton.Text = "Invis"
toggleButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
toggleButton.BorderSizePixel = 0
toggleButton.Parent = Gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = toggleButton

local invisible = false
local oldTransparency = {}

-- Fonction pour rendre le personnage invisible
local function setInvisible(state)
    if not Character then return end
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            if state then
                oldTransparency[part] = part.Transparency
                part.Transparency = 1
                if part:IsA("Decal") then
                    part.Transparency = 1
                end
            else
                if oldTransparency[part] then
                    part.Transparency = oldTransparency[part]
                else
                    part.Transparency = 0
                end
            end
        elseif part:IsA("Accessory") then
            if part:FindFirstChild("Handle") then
                if state then
                    oldTransparency[part.Handle] = part.Handle.Transparency
                    part.Handle.Transparency = 1
                else
                    if oldTransparency[part.Handle] then
                        part.Handle.Transparency = oldTransparency[part.Handle]
                    else
                        part.Handle.Transparency = 0
                    end
                end
            end
        end
    end
end

toggleButton.MouseButton1Click:Connect(function()
    invisible = not invisible
    setInvisible(invisible)
    toggleButton.Text = invisible and "Visible" or "Invis"
end)

-- Mettre à jour si le personnage réapparaît
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    if invisible then
        wait(1)
        setInvisible(true)
    end
end)
