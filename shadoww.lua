local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ShadowXGui"
gui.Parent = player:WaitForChild("PlayerGui")

-- Fenêtre principale
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 350)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Bouton discret pour réouvrir
local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(0,70,0,25)
reopenBtn.Position = UDim2.new(0, 10, 0, 10)
reopenBtn.Text = "SHADOWX"
reopenBtn.TextColor3 = Color3.fromRGB(255,0,0)
reopenBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
reopenBtn.Font = Enum.Font.GothamBold
reopenBtn.TextSize = 14
reopenBtn.Parent = gui
Instance.new("UICorner", reopenBtn).CornerRadius = UDim.new(0, 8)
reopenBtn.Visible = false

-- Animation ouverture/fermeture
local function openFrame()
    frame.Visible = true
    frame.Size = UDim2.new(0,0,0,0)
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0,300,0,350)}):Play()
end

local function closeFrame()
    TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0,0,0,0)}):Play()
    task.delay(0.2, function()
        frame.Visible = false
        reopenBtn.Visible = true
    end)
end

reopenBtn.MouseButton1Click:Connect(function()
    openFrame()
    reopenBtn.Visible = false
end)

-- Bouton croix
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(closeFrame)

-- Bouton menu (≡)
local menuBtn = Instance.new("TextButton")
menuBtn.Size = UDim2.new(0,30,0,30)
menuBtn.Position = UDim2.new(0,5,0,5)
menuBtn.Text = "≡"
menuBtn.TextColor3 = Color3.fromRGB(255,255,255)
menuBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
menuBtn.Font = Enum.Font.GothamBold
menuBtn.TextSize = 20
menuBtn.Parent = frame
Instance.new("UICorner", menuBtn).CornerRadius = UDim.new(0, 6)

-- Menu déroulant
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0,120,0,80)
menuFrame.Position = UDim2.new(0,5,0,40)
menuFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
menuFrame.Visible = false
menuFrame.Parent = frame
Instance.new("UICorner", menuFrame).CornerRadius = UDim.new(0, 8)

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 0, 30)
title.Position = UDim2.new(0, 40, 0, 5)
title.Text = "SHADOWX"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Pages
local pages = {}

-- PAGE 1 : liste des joueurs
local page1 = Instance.new("ScrollingFrame")
page1.Size = UDim2.new(1,-20,1,-50)
page1.Position = UDim2.new(0,10,0,40)
page1.BackgroundTransparency = 1
page1.ScrollBarThickness = 6
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

    local thumb, _ = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0,40,0,40)
    img.Position = UDim2.new(0,5,0,5)
    img.Image = thumb
    img.BackgroundTransparency = 1
    img.Parent = btn
    Instance.new("UICorner", img).CornerRadius = UDim.new(1,0)

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1,-50,1,0)
    nameLbl.Position = UDim2.new(0,50,0,0)
    nameLbl.Text = plr.Name
    nameLbl.TextColor3 = Color3.fromRGB(255,255,255)
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 18
    nameLbl.BackgroundTransparency = 1
    nameLbl.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            character:MoveTo(plr.Character.HumanoidRootPart.Position + Vector3.new(0,3,0))
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

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

-- PAGE 2 : sliders
local page2 = Instance.new("Frame")
page2.Size = UDim2.new(1,-20,1,-50)
page2.Position = UDim2.new(0,10,0,40)
page2.BackgroundTransparency = 1
page2.Visible = false
page2.Parent = frame
pages[2] = page2

local listLayout2 = Instance.new("UIListLayout", page2)
listLayout2.Padding = UDim.new(0,15)

local function createSlider(parent, titleText, default, minVal, maxVal, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1,0,0,60)
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
    sliderBack.Size = UDim2.new(1,-40,0,15)
    sliderBack.Position = UDim2.new(0,0,0,30)
    sliderBack.BackgroundColor3 = Color3.fromRGB(60,60,60)
    sliderBack.Parent = container
    Instance.new("UICorner", sliderBack).CornerRadius = UDim.new(0,8)

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0,0,1,0)
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

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    update(sliderBack.AbsolutePosition.X + sliderBack.AbsoluteSize.X * 0.5)
end

createSlider(page2,"Vitesse du joueur", humanoid.WalkSpeed,16,1000,function(val)
    humanoid.WalkSpeed = val
end)

createSlider(page2,"Saut du joueur", humanoid.JumpPower,50,1000,function(val)
    humanoid.JumpPower = val
end)

-- Fonction pour créer les boutons du menu
local function createMenuButton(name, pageIndex)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Parent = menuFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        for i, pg in pairs(pages) do
            pg.Visible = (i == pageIndex)
        end
        menuFrame.Visible = false
    end)
end

-- Menu navigation
createMenuButton("Page 1 : Joueurs",1)
createMenuButton("Page 2 : Stats",2)

menuBtn.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)
