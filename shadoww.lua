-- Script Luau pour Roblox

-- Notifications de démarrage
game.StarterGui:SetCore("SendNotification", {
    Title = "😈SHADOW HUB😈",
    Text = "chargement... 😈",
    Duration = 7
})

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local camera = workspace.CurrentCamera
local RS = game:GetService("RunService")

-- Le ScreenGui principal pour toutes les fenêtres
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ShadowHub"

-- =========================
-- PAGE MOT DE PASSE (la première fenêtre qui s'affiche)
-- =========================
local passPage = Instance.new("Frame", gui)
passPage.Size = UDim2.new(0, 380, 0, 250)
passPage.Position = UDim2.new(0.5,0,0.5,0)
passPage.AnchorPoint = Vector2.new(0.5,0.5)
passPage.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", passPage).CornerRadius = UDim.new(0,15)
Instance.new("UIStroke", passPage).Color = Color3.fromRGB(255, 50, 50)
Instance.new("UIStroke", passPage).Thickness = 2
passPage.ClipsDescendants = true
passPage.Visible = true

local passTitle = Instance.new("TextLabel", passPage)
passTitle.Size = UDim2.new(1,-40,0,50)
passTitle.Position = UDim2.new(0,20,0,20)
passTitle.Text = "ACCÈS SÉCURISÉ"
passTitle.TextColor3 = Color3.fromRGB(255,50,50)
passTitle.Font = Enum.Font.GothamBold
passTitle.TextSize = 26
passTitle.BackgroundTransparency = 1

local passBox = Instance.new("TextBox", passPage)
passBox.Size = UDim2.new(0,250,0,40)
passBox.Position = UDim2.new(0.5,-125,0.5,-20)
passBox.PlaceholderText = "Entrez le mot de passe"
passBox.TextColor3 = Color3.fromRGB(255,255,255)
passBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
passBox.Font = Enum.Font.Gotham
passBox.TextSize = 20
Instance.new("UICorner", passBox).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", passBox).Color = Color3.fromRGB(50,50,50)
Instance.new("UIStroke", passBox).Thickness = 2

local submitBtn = Instance.new("TextButton", passPage)
submitBtn.Size = UDim2.new(0,140,0,40)
submitBtn.Position = UDim2.new(0.5,-70,0.7,0)
submitBtn.Text = "Valider"
submitBtn.TextColor3 = Color3.fromRGB(255,255,255)
submitBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 22
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0,12)

local loadingLabel = Instance.new("TextLabel", passPage)
loadingLabel.Size = UDim2.new(0, 300, 0, 20)
loadingLabel.Position = UDim2.new(0.5, -150, 0.8, 0)
loadingLabel.Text = "Chargement..."
loadingLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
loadingLabel.Font = Enum.Font.Gotham
loadingLabel.TextSize = 18
loadingLabel.BackgroundTransparency = 1
loadingLabel.Visible = false

local loadingBarFrame = Instance.new("Frame", passPage)
loadingBarFrame.Size = UDim2.new(0,300,0,10)
loadingBarFrame.Position = UDim2.new(0.5,-150,0.85,0)
loadingBarFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", loadingBarFrame).CornerRadius = UDim.new(0,10)
loadingBarFrame.Visible = false

local loadingBar = Instance.new("Frame", loadingBarFrame)
loadingBar.Size = UDim2.new(0,0,1,0)
loadingBar.BackgroundColor3 = Color3.fromRGB(255,0,0)
Instance.new("UICorner", loadingBar).CornerRadius = UDim.new(0,10)

-- =========================
-- FRAME PRINCIPALE (La fenêtre principale du menu après connexion)
-- =========================
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,400,0,300)
frame.Position = UDim2.new(0.5,0,0.5,0)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Visible = false
frame.ClipsDescendants = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,15)
local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Color3.fromRGB(255, 50, 50)
frameStroke.Thickness = 2

local function openFrame(f)
    f.Visible = true
    f.Size = UDim2.new(0,0,0,0)
    for i=0,1,0.05 do
        f.Size = UDim2.new(0,400*i,0,300*i)
        wait(0.01)
    end
end

local function closeFrame(f)
    for i=1,0,-0.05 do
        f.Size = UDim2.new(0,400*i,0,300*i)
        wait(0.01)
    end
    f.Visible = false
end

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1,0,0,45)
header.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", header).CornerRadius = UDim.new(0,15)

-- Le titre est maintenant un TextButton pour pouvoir cliquer dessus
local title = Instance.new("TextButton", header)
title.Size = UDim2.new(1,-90,1,0)
title.Position = UDim2.new(0,50,0,0)
title.Text = "SHADOW HUB"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.BackgroundTransparency = 1

local settingsBtn = Instance.new("TextButton", header)
settingsBtn.Size = UDim2.new(0,35,0,35)
settingsBtn.Position = UDim2.new(0,5,0,5)
settingsBtn.Text = "⚙️"
settingsBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
settingsBtn.TextColor3 = Color3.fromRGB(255,255,255)
settingsBtn.Font = Enum.Font.GothamBold
settingsBtn.TextSize = 22
Instance.new("UICorner", settingsBtn).CornerRadius = UDim.new(0,8)

local backArrowBtn = Instance.new("TextButton", header)
backArrowBtn.Size = UDim2.new(0,35,0,35)
backArrowBtn.Position = UDim2.new(0,5,0,5)
backArrowBtn.Text = "←"
backArrowBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
backArrowBtn.TextColor3 = Color3.fromRGB(255,255,255)
backArrowBtn.Font = Enum.Font.GothamBold
backArrowBtn.TextSize = 22
Instance.new("UICorner", backArrowBtn).CornerRadius = UDim.new(0,8)
backArrowBtn.Visible = false

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,35,0,35)
closeBtn.Position = UDim2.new(1,-40,0,5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)

local reopenBtn = Instance.new("TextButton", gui)
reopenBtn.Size = UDim2.new(0,120,0,35)
reopenBtn.Position = UDim2.new(0,20,0,20)
reopenBtn.Text = "SHADOW"
reopenBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
reopenBtn.TextColor3 = Color3.fromRGB(255,0,0)
reopenBtn.Font = Enum.Font.GothamBold
reopenBtn.TextSize = 20
reopenBtn.Visible = false
Instance.new("UICorner", reopenBtn).CornerRadius = UDim.new(0,10)

-- Pages du menu
local mainPage = Instance.new("Frame", frame)
mainPage.Size = UDim2.new(1,0,1,-45)
mainPage.Position = UDim2.new(0,0,0,45)
mainPage.BackgroundTransparency = 1
local mainGradient = Instance.new("UIGradient", mainPage)
mainGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))

local settingsPage = Instance.new("Frame", frame)
settingsPage.Size = UDim2.new(1,0,1,-45)
settingsPage.Position = UDim2.new(0,0,0,45)
settingsPage.BackgroundTransparency = 1
local settingsGradient = Instance.new("UIGradient", settingsPage)
settingsGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
settingsPage.Visible = false

local infoPage = Instance.new("Frame", frame)
infoPage.Size = UDim2.new(1,0,1,-45)
infoPage.Position = UDim2.new(0,0,0,45)
infoPage.BackgroundTransparency = 1
local infoGradient = Instance.new("UIGradient", infoPage)
infoGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
infoPage.Visible = false

local playerList = Instance.new("ScrollingFrame", infoPage)
playerList.Size = UDim2.new(1,-40,1,-60)
playerList.Position = UDim2.new(0,20,0,20)
playerList.BackgroundTransparency = 1
playerList.CanvasSize = UDim2.new(0,0,0,0)
playerList.ScrollBarThickness = 6

local listLayout = Instance.new("UIListLayout", playerList)
listLayout.Padding = UDim.new(0,5)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

local infoText = Instance.new("TextLabel", playerList)
infoText.Size = UDim2.new(1,0,0,30)
infoText.Text = "👤 Joueurs dans le jeu :"
infoText.TextColor3 = Color3.fromRGB(200,200,200)
infoText.Font = Enum.Font.GothamBold
infoText.TextSize = 18
infoText.BackgroundTransparency = 1
infoText.TextXAlignment = Enum.TextXAlignment.Left

local function createPlayerButtons()
    for _, child in pairs(playerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player then
            local playerBtn = Instance.new("TextButton", playerList)
            playerBtn.Size = UDim2.new(1, -10, 0, 30)
            playerBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            playerBtn.TextColor3 = Color3.fromRGB(255,255,255)
            playerBtn.Font = Enum.Font.Gotham
            playerBtn.TextSize = 18
            playerBtn.Text = ""
            Instance.new("UICorner", playerBtn).CornerRadius = UDim.new(0,5)

            local contentFrame = Instance.new("Frame", playerBtn)
            contentFrame.Size = UDim2.new(1,0,1,0)
            contentFrame.BackgroundTransparency = 1

            local hLayout = Instance.new("UIListLayout", contentFrame)
            hLayout.FillDirection = Enum.FillDirection.Horizontal
            hLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            hLayout.Padding = UDim.new(0, 5)

            local avatarImage = Instance.new("ImageLabel", contentFrame)
            avatarImage.Size = UDim2.new(0, 24, 0, 24)
            avatarImage.BackgroundTransparency = 1
            Instance.new("UICorner", avatarImage).CornerRadius = UDim.new(0, 12)

            local playerNameLabel = Instance.new("TextLabel", contentFrame)
            playerNameLabel.Size = UDim2.new(1, -29, 1, 0)
            playerNameLabel.Text = plr.Name
            playerNameLabel.Font = Enum.Font.GothamBold
            playerNameLabel.TextSize = 18
            playerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerNameLabel.BackgroundTransparency = 1
            playerNameLabel.TextXAlignment = Enum.TextXAlignment.Left

            spawn(function()
                local userId = plr.UserId
                local success, url = pcall(function()
                    return game.Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
                end)
                if success then
                    avatarImage.Image = url
                end
            end)

            playerBtn.MouseButton1Click:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position + Vector3.new(0,3,0))
                end
            end)
        end
    end

    playerList.CanvasSize = UDim2.new(0,0,0,listLayout.AbsoluteContentSize.Y)
end

infoBtn.MouseButton1Click:Connect(function()
    settingsPage.Visible = false
    infoPage.Visible = true
    spawn(function()
        while infoPage.Visible do
            createPlayerButtons()
            wait(1)
        end
    end)
end)

local gameSetBtn = Instance.new("TextButton", settingsPage)
gameSetBtn.Size = UDim2.new(0,180,0,35)
gameSetBtn.Position = UDim2.new(0.5,-90,0.35,0)
gameSetBtn.Text = "Game Set"
gameSetBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
gameSetBtn.TextColor3 = Color3.fromRGB(255,255,255)
gameSetBtn.Font = Enum.Font.GothamBold
gameSetBtn.TextSize = 20
Instance.new("UICorner", gameSetBtn).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", gameSetBtn).Color = Color3.fromRGB(255,50,50)

local gamePage = Instance.new("Frame", frame)
gamePage.Size = UDim2.new(1,0,1,-45)
gamePage.Position = UDim2.new(0,0,0,45)
gamePage.BackgroundTransparency = 1
local gameGradient = Instance.new("UIGradient", gamePage)
gameGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
gamePage.Visible = false

local setPointBtn = Instance.new("TextButton", gamePage)
setPointBtn.Size = UDim2.new(0,120,0,35)
setPointBtn.Position = UDim2.new(0.5,-60,0.3,0)
setPointBtn.Text = "Set Point"
setPointBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
setPointBtn.TextColor3 = Color3.fromRGB(255,255,255)
setPointBtn.Font = Enum.Font.GothamBold
setPointBtn.TextSize = 20
Instance.new("UICorner", setPointBtn).CornerRadius = UDim.new(0,10)

local goPointBtn = Instance.new("TextButton", gamePage)
goPointBtn.Size = UDim2.new(0,120,0,35)
goPointBtn.Position = UDim2.new(0.5,-60,0.45,0)
goPointBtn.Text = "Go To Point"
goPointBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
goPointBtn.TextColor3 = Color3.fromRGB(0,0,0)
goPointBtn.Font = Enum.Font.GothamBold
goPointBtn.TextSize = 20
Instance.new("UICorner", goPointBtn).CornerRadius = UDim.new(0,10)

local removePointBtn = Instance.new("TextButton", gamePage)
removePointBtn.Size = UDim2.new(0,120,0,35)
removePointBtn.Position = UDim2.new(0.5,-60,0.6,0)
removePointBtn.Text = "Remove Point"
removePointBtn.BackgroundColor3 = Color3.fromRGB(255,100,100)
removePointBtn.TextColor3 = Color3.fromRGB(0,0,0)
removePointBtn.Font = Enum.Font.GothamBold
removePointBtn.TextSize = 20
Instance.new("UICorner", removePointBtn).CornerRadius = UDim.new(0,10)

local teleportPoint
local marker

setPointBtn.MouseButton1Click:Connect(function()
    teleportPoint = character.HumanoidRootPart.Position
    if marker then marker:Destroy() end
    marker = Instance.new("Part", workspace)
    marker.Size = Vector3.new(2,2,2)
    marker.Anchored = true
    marker.CanCollide = false
    marker.BrickColor = BrickColor.Red()
    marker.Position = teleportPoint + Vector3.new(0,2,0)
    marker.Name = "TeleportMarker"
end)

goPointBtn.MouseButton1Click:Connect(function()
    if teleportPoint then
        character.HumanoidRootPart.CFrame = CFrame.new(teleportPoint + Vector3.new(0,3,0))
    end
end)

removePointBtn.MouseButton1Click:Connect(function()
    teleportPoint = nil
    if marker then
        marker:Destroy()
        marker = nil
    end
end)

gameSetBtn.MouseButton1Click:Connect(function()
    settingsPage.Visible = false
    gamePage.Visible = true
end)

local hackBtn = Instance.new("TextButton", settingsPage)
hackBtn.Size = UDim2.new(0,180,0,35)
hackBtn.Position = UDim2.new(0.5,-90,0.5,0)
hackBtn.Text = "Hacks"
hackBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
hackBtn.TextColor3 = Color3.fromRGB(255,255,255)
hackBtn.Font = Enum.Font.GothamBold
hackBtn.TextSize = 20
Instance.new("UICorner", hackBtn).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", hackBtn).Color = Color3.fromRGB(255,50,50)

local hackPage = Instance.new("Frame", frame)
hackPage.Size = UDim2.new(1,0,1,-45)
hackPage.Position = UDim2.new(0,0,0,45)
hackPage.BackgroundTransparency = 1
local hackGradient = Instance.new("UIGradient", hackPage)
hackGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
hackPage.Visible = false

hackBtn.MouseButton1Click:Connect(function()
    settingsPage.Visible = false
    hackPage.Visible = true
end)

settingsBtn.MouseButton1Click:Connect(function()
    settingsBtn.Visible = false
    backArrowBtn.Visible = true
    settingsPage.Visible = true
    mainPage.Visible = false
end)

backArrowBtn.MouseButton1Click:Connect(function()
    settingsBtn.Visible = true
    backArrowBtn.Visible = false
    settingsPage.Visible = false
    infoPage.Visible = false
    gamePage.Visible = false
    hackPage.Visible = false
    
    -- Cache les nouvelles pages
    personalInfoPage.Visible = false
    graphPage.Visible = false

    mainPage.Visible = true
end)

infoBtn.MouseButton1Click:Connect(function()
    settingsPage.Visible = false
    infoPage.Visible = true
end)
gameSetBtn.MouseButton1Click:Connect(function()
    settingsPage.Visible = false
    gamePage.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
    closeFrame(frame)
    reopenBtn.Visible = true
end)

reopenBtn.MouseButton1Click:Connect(function()
    openFrame(frame)
    reopenBtn.Visible = false
end)

local signature = Instance.new("TextLabel", frame)
signature.Size = UDim2.new(1,0,0,15)
signature.Position = UDim2.new(0,0,1,-20)
signature.Text = "Powered by SHADOW"
signature.Font = Enum.Font.GothamBold
signature.TextSize = 12
signature.TextColor3 = Color3.fromRGB(255,0,0)
signature.BackgroundTransparency = 1
signature.TextScaled = false
signature.TextXAlignment = Enum.TextXAlignment.Center

spawn(function()
    while true do
        for i=0,1,0.01 do
            signature.TextColor3 = Color3.fromHSV(i,1,1)
            wait(0.02)
        end
    end
end)

-- =========================
-- VARIABLES GLOBALES ET BOUTONS DES CHEATS
-- =========================
_G.flyEnabled = false
_G.speedEnabled = false
_G.jumpEnabled = false
_G.noclip = false
_G.killAuraEnabled = false
_G.nameViewEnabled = false
_G.trackerEnabled = false
_G.spectatingEnabled = false
_G.lightEnabled = false
_G.fpsEnabled = false

local buttonYMain = 0.1
local spacing = 0.18

local function animateButtonColor(btn, startColor, endColor, duration)
    local startTime = tick()
    while tick() - startTime < duration do
        local progress = (tick() - startTime) / duration
        btn.BackgroundColor3 = startColor:Lerp(endColor, progress)
        wait()
    end
    btn.BackgroundColor3 = endColor
end

local function createButton(name, parent, toggleVar, callback, yPosition)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0,280,0,35)
    btn.Position = UDim2.new(0.5,-140, yPosition, 0)
    btn.Text = name..": OFF"
    local originalColor = Color3.fromRGB(30,30,30)
    local onColor = Color3.fromRGB(0, 180, 0)
    local originalStrokeColor = Color3.fromRGB(255,50,50)
    local onStrokeColor = Color3.fromRGB(0, 255, 0)

    btn.BackgroundColor3 = originalColor
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = originalStrokeColor
    btnStroke.Thickness = 2

    btn.MouseButton1Click:Connect(function()
        _G[toggleVar] = not _G[toggleVar]
        btn.Text = name..(_G[toggleVar] and ": ON" or ": OFF")
        callback(_G[toggleVar])

        if _G[toggleVar] then
            animateButtonColor(btn, originalColor, onColor, 0.2)
            btnStroke.Color = onStrokeColor
        else
            btn.BackgroundColor3 = originalColor
            btnStroke.Color = originalStrokeColor
        end
    end)
    return btn
end

-- =========================
-- MISE EN PAGE DES BOUTONS PRINCIPAUX ET HACKS
-- =========================
createButton("Vol", mainPage, "flyEnabled", function(state)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then return end

    if state then
        humanoid.PlatformStand = true

        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "FlyVelocity"
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Velocity = Vector3.zero

        local bg = Instance.new("BodyGyro", hrp)
        bg.Name = "FlyGyro"
        bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bg.P = 1e4
        bg.CFrame = hrp.CFrame

        local speed = 60
        local smoothing = 0.2

        local conn
        conn = RS.Heartbeat:Connect(function(dt)
            if not _G.flyEnabled then
                conn:Disconnect()
                if bv and bv.Parent == hrp then bv:Destroy() end
                if bg and bg.Parent == hrp then bg:Destroy() end
                humanoid.PlatformStand = false
                return
            end

            local moveDir = humanoid.MoveDirection
            local camCF = camera.CFrame

            local targetVelocity
            local velocityY = 0

            if moveDir.Magnitude > 0 then
                local moveDirection = Vector3.new(moveDir.X, 0, moveDir.Z).unit
                targetVelocity = moveDirection * speed

                velocityY = camCF.LookVector.Y * speed
            else
                targetVelocity = Vector3.new(0, 0, 0)
            end

            bv.Velocity = Vector3.new(targetVelocity.X, velocityY, targetVelocity.Z)
            bv.Velocity = bv.Velocity:Lerp(targetVelocity, smoothing)

            bg.CFrame = CFrame.new(hrp.Position, hrp.Position + camCF.LookVector)
        end)
    else
        local oldBV = hrp:FindFirstChild("FlyVelocity")
        if oldBV then oldBV:Destroy() end
        local oldBG = hrp:FindFirstChild("FlyGyro")
        if oldBG then oldBG:Destroy() end
        humanoid.PlatformStand = false
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end, buttonYMain)
buttonYMain = buttonYMain + spacing

createButton("Vitesse", mainPage, "speedEnabled", function(state)
    character.Humanoid.WalkSpeed = state and 100 or 16
end, buttonYMain)
buttonYMain = buttonYMain + spacing

createButton("Saut", mainPage, "jumpEnabled", function(state)
    character.Humanoid.JumpPower = state and 150 or 50
end, buttonYMain)
buttonYMain = buttonYMain + spacing

createButton("Noclip", mainPage, "noclip", function(state)
    RS.Stepped:Connect(function()
        if _G.noclip and character then
            for _,part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = false
                end
            end
        end
    end)
end, buttonYMain)
buttonYMain = buttonYMain + spacing

local buttonYHack = 0.1
local function createHackButton(name, toggleVar, callback)
    local btn = createButton(name, hackPage, toggleVar, callback, buttonYHack)
    buttonYHack = buttonYHack + spacing
    return btn
end

createHackButton("Kill Aura", "killAuraEnabled", function(state) end)

local nameTags = {}
createHackButton("Name View", "nameViewEnabled", function(state)
    if not state then
        for _, tag in pairs(nameTags) do
            tag:Destroy()
        end
        nameTags = {}
    end
end)

local trackerFrame = Instance.new("Frame", gui)
trackerFrame.Size = UDim2.new(0,180,0,40)
trackerFrame.Position = UDim2.new(0,10,1,-50)
trackerFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
trackerFrame.Visible = false
Instance.new("UICorner", trackerFrame).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", trackerFrame).Color = Color3.fromRGB(255,50,50)

local trackerLabel = Instance.new("TextLabel", trackerFrame)
trackerLabel.Size = UDim2.new(1,-20,1,-10)
trackerLabel.Position = UDim2.new(0,10,0,5)
trackerLabel.Text = "Distance: N/A"
trackerLabel.TextColor3 = Color3.fromRGB(255,255,255)
trackerLabel.Font = Enum.Font.GothamBold
trackerLabel.TextSize = 18
trackerLabel.BackgroundTransparency = 1

createHackButton("Tracker", "trackerEnabled", function(state)
    trackerFrame.Visible = state
end)


--- BOUTON SPECTATEUR ET INTERFACE ---
local leftArrowBtn = Instance.new("TextButton", gui)
leftArrowBtn.Size = UDim2.new(0, 50, 0, 50)
leftArrowBtn.Position = UDim2.new(0, 10, 0.5, -25)
leftArrowBtn.Text = "←"
leftArrowBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
leftArrowBtn.BackgroundTransparency = 0.5
leftArrowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
leftArrowBtn.Font = Enum.Font.GothamBold
leftArrowBtn.TextSize = 30
leftArrowBtn.Visible = false
Instance.new("UICorner", leftArrowBtn).CornerRadius = UDim.new(0.5,0)
Instance.new("UIStroke", leftArrowBtn).Color = Color3.fromRGB(255, 50, 50)
Instance.new("UIStroke", leftArrowBtn).Thickness = 2

local rightArrowBtn = Instance.new("TextButton", gui)
rightArrowBtn.Size = UDim2.new(0, 50, 0, 50)
rightArrowBtn.Position = UDim2.new(1, -60, 0.5, -25)
rightArrowBtn.Text = "→"
rightArrowBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
rightArrowBtn.BackgroundTransparency = 0.5
rightArrowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rightArrowBtn.Font = Enum.Font.GothamBold
rightArrowBtn.TextSize = 30
rightArrowBtn.Visible = false
Instance.new("UICorner", rightArrowBtn).CornerRadius = UDim.new(0.5,0)
Instance.new("UIStroke", rightArrowBtn).Color = Color3.fromRGB(255, 50, 50)
Instance.new("UIStroke", rightArrowBtn).Thickness = 2

local spectatorPlayers = {}
local currentSpectatorIndex = 1
local cameraConnection

-- NOUVEAU : Label pour le nom du spectateur
local spectatorNameLabel = Instance.new("TextLabel", gui)
spectatorNameLabel.Size = UDim2.new(0, 250, 0, 30)
spectatorNameLabel.Position = UDim2.new(0.5, -125, 0, 50) -- Centré, 50 pixels depuis le haut
spectatorNameLabel.BackgroundTransparency = 1
spectatorNameLabel.Font = Enum.Font.GothamBold
spectatorNameLabel.TextSize = 25
spectatorNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
spectatorNameLabel.TextScaled = false
spectatorNameLabel.TextStrokeTransparency = 0.5
spectatorNameLabel.Visible = false

local spectatorColorAnimation
local function startSpectatorNameAnimation()
    if spectatorColorAnimation then spectatorColorAnimation:Disconnect() end
    spectatorColorAnimation = spawn(function()
        while spectatorNameLabel.Visible do
            for i = 0, 1, 0.05 do
                spectatorNameLabel.TextColor3 = Color3.fromHSV(i, 1, 1)
                wait(0.01)
            end
        end
    end)
end

local function stopSpectatorNameAnimation()
    if spectatorColorAnimation then
        spectatorColorAnimation:Disconnect()
        spectatorColorAnimation = nil
    end
end

createHackButton("Spectateur", "spectatingEnabled", function(state)
    leftArrowBtn.Visible = state
    rightArrowBtn.Visible = state
    spectatorNameLabel.Visible = state

    if state then
        -- On entre en mode spectateur
        spectatorPlayers = {}
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                table.insert(spectatorPlayers, p)
            end
        end
        currentSpectatorIndex = 1
        
        if #spectatorPlayers > 0 then
            camera.CameraType = Enum.CameraType.Scriptable
            if cameraConnection then cameraConnection:Disconnect() end
            cameraConnection = RS.RenderStepped:Connect(function()
                local target = spectatorPlayers[currentSpectatorIndex]
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    camera.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 15) -- Déplace la caméra légèrement au-dessus et derrière le joueur
                    spectatorNameLabel.Text = target.Name
                end
            end)
            startSpectatorNameAnimation()
        else
            -- Aucun joueur à observer, on désactive le mode
            _G.spectatingEnabled = false
            leftArrowBtn.Visible = false
            rightArrowBtn.Visible = false
            spectatorNameLabel.Visible = false
            camera.CameraType = Enum.CameraType.Custom
        end
    else
        -- On quitte le mode spectateur
        if cameraConnection then cameraConnection:Disconnect() end
        camera.CameraType = Enum.CameraType.Custom
        stopSpectatorNameAnimation()
    end
end)

leftArrowBtn.MouseButton1Click:Connect(function()
    if #spectatorPlayers > 0 then
        currentSpectatorIndex = currentSpectatorIndex - 1
        if currentSpectatorIndex < 1 then
            currentSpectatorIndex = #spectatorPlayers
        end
        spectatorNameLabel.Text = spectatorPlayers[currentSpectatorIndex].Name
    end
end)

rightArrowBtn.MouseButton1Click:Connect(function()
    if #spectatorPlayers > 0 then
        currentSpectatorIndex = currentSpectatorIndex + 1
        if currentSpectatorIndex > #spectatorPlayers then
            currentSpectatorIndex = 1
        end
        spectatorNameLabel.Text = spectatorPlayers[currentSpectatorIndex].Name
    end
end)

--- NOUVEAU : BOUTON GRAPH DANS LES PARAMÈTRES ---
local graphBtn = Instance.new("TextButton", settingsPage)
graphBtn.Size = UDim2.new(0,180,0,35)
graphBtn.Position = UDim2.new(0.5,-90,0.65,0)
graphBtn.Text = "Graph"
graphBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
graphBtn.TextColor3 = Color3.fromRGB(255,255,255)
graphBtn.Font = Enum.Font.GothamBold
graphBtn.TextSize = 20
Instance.new("UICorner", graphBtn).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", graphBtn).Color = Color3.fromRGB(255,50,50)

--- NOUVEAU : PAGE GRAPH ---
local graphPage = Instance.new("Frame", frame)
graphPage.Size = UDim2.new(1,0,1,-45)
graphPage.Position = UDim2.new(0,0,0,45)
graphPage.BackgroundTransparency = 1
local graphGradient = Instance.new("UIGradient", graphPage)
graphGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
graphPage.Visible = false

graphBtn.MouseButton1Click:Connect(function()
    settingsPage.Visible = false
    graphPage.Visible = true
end)

local buttonYGraph = 0.1
local function createGraphButton(name, toggleVar, callback)
    local btn = createButton(name, graphPage, toggleVar, callback, buttonYGraph)
    buttonYGraph = buttonYGraph + spacing
    return btn
end

-- Bouton Lumière
local light = nil
createGraphButton("Lumière", "lightEnabled", function(state)
    if state then
        if light then light:Destroy() end
        light = Instance.new("PointLight", character.HumanoidRootPart)
        light.Name = "ShadowLight"
        light.Range = 25
        light.Brightness = 2
        light.Color = Color3.fromRGB(255, 255, 200)
    else
        if light then
            light:Destroy()
            light = nil
        end
    end
end)

-- Bouton FPS
createGraphButton("FPS", "fpsEnabled", function(state)
    local lighting = game:GetService("Lighting")
    if state then
        -- Tente d'améliorer la fluidité en désactivant les effets qui consomment des ressources
        lighting.Shadows = false
        lighting.GlobalShadows = false
        lighting.Ambient = Color3.new(0,0,0)
        lighting.Brightness = 0.5
    else
        -- Rétablit les paramètres par défaut (ou les plus courants)
        lighting.Shadows = true
        lighting.GlobalShadows = true
        lighting.Ambient = Color3.fromRGB(48, 48, 48)
        lighting.Brightness = 1
    end
end)


--- NOUVEAU : PAGE D'INFORMATION PERSONNELLE ---
local personalInfoPage = Instance.new("Frame", frame)
personalInfoPage.Size = UDim2.new(1,0,1,-45)
personalInfoPage.Position = UDim2.new(0,0,0,45)
personalInfoPage.BackgroundTransparency = 1
local personalInfoGradient = Instance.new("UIGradient", personalInfoPage)
personalInfoGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
personalInfoPage.Visible = false

local avatarImage = Instance.new("ImageLabel", personalInfoPage)
avatarImage.Size = UDim2.new(0, 100, 0, 100)
avatarImage.Position = UDim2.new(0.5, -50, 0.1, 0)
avatarImage.BackgroundTransparency = 1
Instance.new("UICorner", avatarImage).CornerRadius = UDim.new(0.5, 0)
Instance.new("UIStroke", avatarImage).Color = Color3.fromRGB(255, 50, 50)
Instance.new("UIStroke", avatarImage).Thickness = 2
Instance.new("UIAspectRatioConstraint", avatarImage).AspectRatio = 1
spawn(function()
    local success, url = pcall(function()
        return game.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    end)
    if success then
        avatarImage.Image = url
    end
end)

local infoLayout = Instance.new("UIListLayout", personalInfoPage)
infoLayout.FillDirection = Enum.FillDirection.Vertical
infoLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
infoLayout.VerticalAlignment = Enum.VerticalAlignment.Center
infoLayout.Padding = UDim.new(0, 10)

local infoTitle = Instance.new("TextLabel", personalInfoPage)
infoTitle.Size = UDim2.new(1,0,0,30)
infoTitle.Text = "Informations du compte"
infoTitle.TextColor3 = Color3.fromRGB(255,50,50)
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 24
infoTitle.BackgroundTransparency = 1

local nameLabel = Instance.new("TextLabel", personalInfoPage)
nameLabel.Size = UDim2.new(1,0,0,25)
nameLabel.Text = "Nom: "..player.Name
nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
nameLabel.Font = Enum.Font.Gotham
nameLabel.TextSize = 18
nameLabel.BackgroundTransparency = 1

local idLabel = Instance.new("TextLabel", personalInfoPage)
idLabel.Size = UDim2.new(1,0,0,25)
idLabel.Text = "ID: "..player.UserId
idLabel.TextColor3 = Color3.fromRGB(255,255,255)
idLabel.Font = Enum.Font.Gotham
idLabel.TextSize = 18
idLabel.BackgroundTransparency = 1

local accountAgeLabel = Instance.new("TextLabel", personalInfoPage)
accountAgeLabel.Size = UDim2.new(1,0,0,25)
accountAgeLabel.TextColor3 = Color3.fromRGB(255,255,255)
accountAgeLabel.Font = Enum.Font.Gotham
accountAgeLabel.TextSize = 18
accountAgeLabel.BackgroundTransparency = 1
spawn(function()
    local days = math.floor((os.time() - os.time(player.AccountAge.year, player.AccountAge.month, player.AccountAge.day)) / 86400)
    accountAgeLabel.Text = "Jours d'ancienneté: "..days
end)

local function showPage(pageToShow)
    local allPages = {mainPage, settingsPage, infoPage, gamePage, hackPage, personalInfoPage, graphPage}
    for _, page in ipairs(allPages) do
        page.Visible = (page == pageToShow)
    end
end

-- Gestion des boutons
settingsBtn.MouseButton1Click:Connect(function()
    settingsBtn.Visible = false
    backArrowBtn.Visible = true
    showPage(settingsPage)
end)

backArrowBtn.MouseButton1Click:Connect(function()
    settingsBtn.Visible = true
    backArrowBtn.Visible = false
    showPage(mainPage)
end)

infoBtn.MouseButton1Click:Connect(function()
    showPage(infoPage)
    -- Lancement de la mise à jour des joueurs
    spawn(function()
        while infoPage.Visible do
            createPlayerButtons()
            wait(1)
        end
    end)
end)
gameSetBtn.MouseButton1Click:Connect(function()
    showPage(gamePage)
end)

graphBtn.MouseButton1Click:Connect(function()
    showPage(graphPage)
end)

hackBtn.MouseButton1Click:Connect(function()
    showPage(hackPage)
end)

-- NOUVEAU : Clic sur le titre pour afficher les informations personnelles
title.MouseButton1Click:Connect(function()
    settingsBtn.Visible = false
    backArrowBtn.Visible = true
    showPage(personalInfoPage)
end)

closeBtn.MouseButton1Click:Connect(function()
    closeFrame(frame)
    reopenBtn.Visible = true
end)

reopenBtn.MouseButton1Click:Connect(function()
    openFrame(frame)
    reopenBtn.Visible = false
end)

-- LOGIQUE GLOBALE DANS UNE BOUCLE
RS.Heartbeat:Connect(function()
    local myPosition = character.HumanoidRootPart.Position

    if _G.killAuraEnabled and character and character:FindFirstChildOfClass("HumanoidRootPart") then
        local hasAxe = false
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and (tool.Name:lower():find("hache") or tool.Name:lower():find("axe")) then
            hasAxe = true
        end

        if hasAxe then
            for _, target in pairs(workspace:GetChildren()) do
                local humanoid = target:FindFirstChildOfClass("Humanoid")
                local rootPart = target:FindFirstChildOfClass("HumanoidRootPart") or (target:FindFirstChild("Torso") or target:FindFirstChild("Head"))

                if humanoid and rootPart and humanoid.Health > 0 and target.Name ~= player.Name then
                    if (myPosition - rootPart.Position).Magnitude <= 500 then
                        humanoid.Health = 0
                    end
                end
            end
        end
    end

    if _G.nameViewEnabled then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if not nameTags[plr.Name] then
                    local nameTag = Instance.new("BillboardGui")
                    nameTag.Size = UDim2.new(0, 150, 0, 20)
                    nameTag.Adornee = plr.Character:FindFirstChild("Head") or plr.Character.HumanoidRootPart
                    nameTag.AlwaysOnTop = true
                    nameTag.Parent = plr.Character

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1,0,1,0)
                    nameLabel.Text = plr.Name
                    nameLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.TextSize = 18
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Parent = nameTag
                    nameTags[plr.Name] = nameTag
                end
            elseif nameTags[plr.Name] then
                nameTags[plr.Name]:Destroy()
                nameTags[plr.Name] = nil
            end
        end
    else
        for _, tag in pairs(nameTags) do
            tag:Destroy()
        end
        nameTags = {}
    end

    if _G.trackerEnabled then
        local closestPlayer
        local closestDistance = math.huge

        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (myPosition - plr.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = plr
                end
            end
        end

        if closestPlayer then
            trackerLabel.Text = "Distance: "..math.floor(closestDistance).." m"
        else
            trackerLabel.Text = "Distance: N/A"
        end
    end
end)

local function animateColor(textLabel)
    spawn(function()
        while true do
            for i=0,1,0.01 do
                textLabel.TextColor3 = Color3.fromHSV(i,1,1)
                wait(0.03)
            end
        end
    end)
end

animateColor(title)
animateColor(reopenBtn)

submitBtn.MouseButton1Click:Connect(function()
    if passBox.Text == "95741" then
        loadingLabel.Visible = true
        loadingBarFrame.Visible = true
        for i=1,100 do
            loadingBar.Size = UDim2.new(i/100,0,1,0)
            loadingBar.BackgroundColor3 = Color3.fromHSV(i/100,1,1)
            wait(0.01)
        end
        passPage:Destroy()
        openFrame(frame)
    else
        passBox.Text = ""
        passBox.PlaceholderText = "Mot de passe incorrect"
    end
end)
