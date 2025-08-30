local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "ShadowXGui"
gui.Parent = player:WaitForChild("PlayerGui")

-- Fenêtre principale
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 400)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Visible = false
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)
frame.Parent = gui

-- Animation ouverture
local function openFrame()
    frame.Size = UDim2.new(0,0,0,0)
    frame.Visible = true
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0,350,0,400)}):Play()
end

local function closeFrame()
    TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0,0,0,0)}):Play()
    wait(0.2)
    frame.Visible = false
end

-- Bouton discret pour réouvrir
local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(0,80,0,30)
reopenBtn.Position = UDim2.new(0, 10, 0, 10)
reopenBtn.Text = "SHADOWX"
reopenBtn.TextColor3 = Color3.fromRGB(255,0,0)
reopenBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
reopenBtn.Font = Enum.Font.GothamBold
reopenBtn.TextSize = 16
reopenBtn.Parent = gui
Instance.new("UICorner", reopenBtn).CornerRadius = UDim.new(0, 8)
reopenBtn.Visible = false

reopenBtn.MouseButton1Click:Connect(function()
    openFrame()
    reopenBtn.Visible = false
end)

-- Bouton menu (≡)
local menuBtn = Instance.new("TextButton")
menuBtn.Size = UDim2.new(0,35,0,35)
menuBtn.Position = UDim2.new(0,5,0,5)
menuBtn.Text = "≡"
menuBtn.TextColor3 = Color3.fromRGB(255,255,255)
menuBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
menuBtn.Font = Enum.Font.GothamBold
menuBtn.TextSize = 22
menuBtn.Parent = frame
Instance.new("UICorner", menuBtn).CornerRadius = UDim.new(0, 8)

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 40)
title.Position = UDim2.new(0, 50, 0, 5)
title.Text = "SHADOWX"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- PAGES
local pages = {}

-- PAGE 1 : liste des joueurs
local page1 = Instance.new("ScrollingFrame")
page1.Size = UDim2.new(1, -20, 1, -60)
page1.Position = UDim2.new(0,10,0,50)
page1.BackgroundTransparency = 1
page1.ScrollBarThickness = 6
page1.Visible = true
page1.Parent = frame
pages[1] = page1

local listLayout = Instance.new("UIListLayout", page1)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0,5)

local function createPlayerButton(plr)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,50)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.Text = ""
    btn.Parent = page1
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size48x48
    local thumb, _ = Players:GetUserThumbnailAsync(plr.UserId, thumbType, thumbSize)

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0,40,0,40)
    img.Position = UDim2.new(0,5,0,5)
    img.Image = thumb
    img.Parent = btn
    img.BackgroundTransparency = 1
    Instance.new("UICorner", img).CornerRadius = UDim.new(1,0)

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -50, 1, 0)
    nameLbl.Position = UDim2.new(0,50,0,0)
    nameLbl.Text = plr.Name
    nameLbl.TextColor3 = Color3.fromRGB(255,255,255)
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 20
    nameLbl.BackgroundTransparency = 1
    nameLbl.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
        end
    end)
end

local function updatePlayerList()
    page1:ClearAllChildren()
    listLayout.Parent = page1
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            createPlayerButton(plr)
        end
    end
end

spawn(function()
    while true do
        updatePlayerList()
        wait(2)
    end
end)

-- PAGE 2 : sliders vitesse & saut
local page2 = Instance.new("Frame")
page2.Size = UDim2.new(1, -20, 1, -60)
page2.Position = UDim2.new(0,10,0,50)
page2.BackgroundTransparency = 1
page2.Visible = false
page2.Parent = frame
pages[2] = page2

-- Fonction pour créer un slider
local function createSlider(parent, titleText, default, minVal, maxVal, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1,0,0,70)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,20)
    title.Text = titleText
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.BackgroundTransparency = 1
    title.Parent = container

    local sliderBack = Instance.new("Frame")
    sliderBack.Size = UDim2.new(1, -40,0,15)
    sliderBack.Position = UDim2.new(0,0,0,30)
    sliderBack.BackgroundColor3 = Color3.fromRGB(60,60,60)
    sliderBack.Parent = container
    Instance.new("UICorner", sliderBack).CornerRadius = UDim.new(0,8)

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0.5,0,1,0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255,0,0)
    sliderFill.Parent = sliderBack
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0,8)

    local valueLbl = Instance.new("TextLabel")
    valueLbl.Size = UDim2.new(0,40,0,20)
    valueLbl.Position = UDim2.new(1,-40,0,25)
    valueLbl.Text = tostring(default)
    valueLbl.TextColor3 = Color3.fromRGB(255,255,255)
    valueLbl.Font = Enum.Font.Gotham
    valueLbl.TextSize = 16
    valueLbl.BackgroundTransparency = 1
    valueLbl.Parent = container

    local dragging = false

    local function update(inputX)
        local rel = math.clamp((inputX - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(rel,0,1,0)
        local val = math.floor(minVal + (maxVal-minVal)*rel)
        valueLbl.Text = tostring(val)
        callback(val)
    end

    sliderBack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input.Position.X)
        end
    end)

    sliderBack.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input.Position.X)
        end
    end)

    update(sliderBack.AbsolutePosition.X + sliderBack.AbsoluteSize.X * 0.5) -- init
end

-- Sliders dans page2
createSlider(page2, "Vitesse du joueur", humanoid.WalkSpeed, 16, 1000, function(val)
    humanoid.WalkSpeed = val
end)

createSlider(page2, "Saut du joueur", humanoid.JumpPower, 50, 1000, function(val)
    humanoid.JumpPower = val
end)

-- Navigation des pages avec le bouton menu
local currentPage = 1
menuBtn.MouseButton1Click:Connect(function()
    pages[currentPage].Visible = false
    currentPage = currentPage % #pages + 1
    pages[currentPage].Visible = true
end)

-- Ouverture initiale
openFrame()
