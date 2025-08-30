local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local camera = workspace.CurrentCamera

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "ShadowXGui"
gui.Parent = player:WaitForChild("PlayerGui")

-- Fenêtre principale
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Visible = false
frame.ClipsDescendants = true
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 15)
frame.Parent = gui

-- Animation ouverture
local function openFrame()
    frame.Size = UDim2.new(0,0,0,0)
    frame.Visible = true
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0,400,0,500)}):Play()
end

local function closeFrame()
    TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0,0,0,0)}):Play()
    wait(0.2)
    frame.Visible = false
end

-- Bouton croix pour fermer
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,35,0,35)
closeBtn.Position = UDim2.new(1,-40,0,5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

closeBtn.MouseButton1Click:Connect(function()
    closeFrame()
    reopenBtn.Visible = true
end)

-- Bouton discret pour réouvrir
local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(0,100,0,30)
reopenBtn.Position = UDim2.new(0, 10, 0, 10)
reopenBtn.Text = "SHADOWX"
reopenBtn.TextColor3 = Color3.fromRGB(255,0,0)
reopenBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
reopenBtn.Font = Enum.Font.GothamBold
reopenBtn.TextSize = 18
reopenBtn.Parent = gui
reopenBtn.Visible = false
Instance.new("UICorner", reopenBtn).CornerRadius = UDim.new(0, 10)

reopenBtn.MouseButton1Click:Connect(function()
    openFrame()
    reopenBtn.Visible = false
end)

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 20, 0, 10)
title.Text = "SHADOWX"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.BackgroundTransparency = 1
title.Parent = frame

-- ScrollFrame pour la liste des joueurs
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.Position = UDim2.new(0,10,0,50)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.Parent = frame

local listLayout = Instance.new("UIListLayout", scroll)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0,5)

-- Fonction pour créer un bouton joueur
local function createPlayerButton(plr)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,50)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.Text = ""
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    -- Image rond
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0,40,0,40)
    img.Position = UDim2.new(0,5,0,5)
    img.Image = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    img.Parent = btn
    img.BackgroundTransparency = 1
    Instance.new("UICorner", img).CornerRadius = UDim.new(1,0)

    -- Nom du joueur
    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -50, 1, 0)
    nameLbl.Position = UDim2.new(0,50,0,0)
    nameLbl.Text = plr.Name
    nameLbl.TextColor3 = Color3.fromRGB(255,255,255)
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 20
    nameLbl.BackgroundTransparency = 1
    nameLbl.Parent = btn

    -- Clique pour te téléporter
    btn.MouseButton1Click:Connect(function()
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position + Vector3.new(0,3,0))
        end
    end)
end

-- Mettre à jour la liste
local function updatePlayerList()
    scroll:ClearAllChildren()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            createPlayerButton(plr)
        end
    end
end

-- Rafraîchir en continu
spawn(function()
    while true do
        updatePlayerList()
        wait(1)
    end
end)

-- Ouvre la fenêtre au démarrage
openFrame()
