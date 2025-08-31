--[[
	Script du Shadow Hub - Version améliorée
	
	Ce script crée un menu d'interface utilisateur complet pour le jeu. Il inclut un
	système de mot de passe, un menu principal avec plusieurs sections (Hacks, Game, Graph),
	et des fonctionnalités interactives.
	
	Instructions :
	1. Placez ce script dans 'StarterPlayerScripts'.
	2. Assurez-vous que le jeu est en mode "Play" pour voir le menu apparaître.
	3. Le mot de passe par défaut pour ouvrir le menu est '95741'.
--]]

-- Initialisation de l'interface utilisateur et des services
game.StarterGui:SetCore("SendNotification", {
	Title = "😈SHADOW HUB😈",
	Text = "chargement... 😈",
	Duration = 7
})

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local camera = workspace.CurrentCamera
local RS = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Création de l'interface graphique principale
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ShadowHub"

-- Variables de couleur et de design
local mainColor = Color3.fromRGB(255, 50, 50) -- Rouge SHADOW
local darkGray = Color3.fromRGB(15, 15, 15)
local mediumGray = Color3.fromRGB(30, 30, 30)
local lightGray = Color3.fromRGB(255, 255, 255)

local function applyCorner(instance, radius)
	local corner = Instance.new("UICorner", instance)
	corner.CornerRadius = UDim.new(0, radius)
end

local function createStroke(instance, color, thickness)
	local stroke = Instance.new("UIStroke", instance)
	stroke.Color = color
	stroke.Thickness = thickness
end

-- =========================
-- PAGE MOT DE PASSE (la première fenêtre)
-- =========================
local passPage = Instance.new("Frame", gui)
passPage.Size = UDim2.new(0, 400, 0, 280)
passPage.Position = UDim2.new(0.5, 0, 0.5, 0)
passPage.AnchorPoint = Vector2.new(0.5, 0.5)
passPage.BackgroundColor3 = darkGray
passPage.BorderSizePixel = 0
applyCorner(passPage, 15)
createStroke(passPage, mainColor, 2)

-- Titre
local passTitle = Instance.new("TextLabel", passPage)
passTitle.Size = UDim2.new(1, -40, 0, 50)
passTitle.Position = UDim2.new(0, 20, 0, 20)
passTitle.Text = "😈 ACCÈS SHADOW HUB 😈"
passTitle.TextColor3 = mainColor
passTitle.Font = Enum.Font.GothamBold
passTitle.TextSize = 24
passTitle.BackgroundTransparency = 1
passTitle.TextStrokeColor3 = Color3.new(0, 0, 0)
passTitle.TextStrokeTransparency = 0.8

-- Boîte de saisie
local passBox = Instance.new("TextBox", passPage)
passBox.Size = UDim2.new(0, 280, 0, 45)
passBox.Position = UDim2.new(0.5, -140, 0.5, -20)
passBox.PlaceholderText = "Entrez le mot de passe"
passBox.TextColor3 = lightGray
passBox.BackgroundColor3 = mediumGray
passBox.Font = Enum.Font.Gotham
passBox.TextSize = 20
applyCorner(passBox, 10)
createStroke(passBox, mediumGray * 0.8, 2)

-- Bouton de soumission
local submitBtn = Instance.new("TextButton", passPage)
submitBtn.Size = UDim2.new(0, 160, 0, 45)
submitBtn.Position = UDim2.new(0.5, -80, 0.7, 0)
submitBtn.Text = "Valider"
submitBtn.TextColor3 = lightGray
submitBtn.BackgroundColor3 = mainColor
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 22
applyCorner(submitBtn, 12)

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
loadingBarFrame.Size = UDim2.new(0, 300, 0, 10)
loadingBarFrame.Position = UDim2.new(0.5, -150, 0.85, 0)
loadingBarFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
applyCorner(loadingBarFrame, 10)
loadingBarFrame.Visible = false

local loadingBar = Instance.new("Frame", loadingBarFrame)
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = mainColor
applyCorner(loadingBar, 10)

-- =========================
-- FRAME PRINCIPALE (La fenêtre principale du menu après connexion)
-- =========================
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 450, 0, 600)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = darkGray
frame.BorderSizePixel = 0
frame.Visible = false
frame.ClipsDescendants = true
applyCorner(frame, 15)
createStroke(frame, mainColor, 2)

local function openFrame(f)
	f.Visible = true
	f.Size = UDim2.new(0, 0, 0, 0)
	for i = 0, 1, 0.05 do
		f.Size = UDim2.new(0, 450 * i, 0, 600 * i)
		wait(0.01)
	end
end

local function closeFrame(f)
	for i = 1, 0, -0.05 do
		f.Size = UDim2.new(0, 450 * i, 0, 600 * i)
		wait(0.01)
	end
	f.Visible = false
end

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = darkGray
applyCorner(header, 15)

-- Le titre est maintenant un TextButton pour le clic
local title = Instance.new("TextButton", header)
title.Size = UDim2.new(1, -90, 1, 0)
title.Position = UDim2.new(0, 50, 0, 0)
title.Text = "SHADOW HUB"
title.TextColor3 = mainColor
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.BackgroundTransparency = 1
title.TextScaled = false
title.Active = true
title.ZIndex = 2
title.TextStrokeColor3 = Color3.new(0, 0, 0)
title.TextStrokeTransparency = 0.8

title.MouseButton1Click:Connect(function()
	mainPage.Visible = false
	settingsPage.Visible = false
	infoPage.Visible = false
	gamePage.Visible = false
	hackPage.Visible = false
	graphPage.Visible = false
	profilePage.Visible = true
	backArrowBtn.Visible = true
	settingsBtn.Visible = false
end)

local settingsBtn = Instance.new("TextButton", header)
settingsBtn.Size = UDim2.new(0, 35, 0, 35)
settingsBtn.Position = UDim2.new(0, 5, 0, 5)
settingsBtn.Text = "⚙️"
settingsBtn.BackgroundColor3 = mediumGray
settingsBtn.TextColor3 = lightGray
settingsBtn.Font = Enum.Font.GothamBold
settingsBtn.TextSize = 22
applyCorner(settingsBtn, 8)

local backArrowBtn = Instance.new("TextButton", header)
backArrowBtn.Size = UDim2.new(0, 35, 0, 35)
backArrowBtn.Position = UDim2.new(0, 5, 0, 5)
backArrowBtn.Text = "←"
backArrowBtn.BackgroundColor3 = mediumGray
backArrowBtn.TextColor3 = lightGray
backArrowBtn.Font = Enum.Font.GothamBold
backArrowBtn.TextSize = 22
applyCorner(backArrowBtn, 8)
backArrowBtn.Visible = false

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
closeBtn.TextColor3 = lightGray
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
applyCorner(closeBtn, 8)

-- NOUVEAU DESIGN POUR LE BOUTON REOPEN
local reopenBtn = Instance.new("TextButton", gui)
reopenBtn.Size = UDim2.new(0, 180, 0, 50) -- Taille plus grande
reopenBtn.Position = UDim2.new(0, 20, 0, 20)
reopenBtn.Text = "😈 SHADOW HUB"
reopenBtn.BackgroundColor3 = darkGray
reopenBtn.TextColor3 = mainColor
reopenBtn.Font = Enum.Font.GothamBold
reopenBtn.TextSize = 20
reopenBtn.Visible = false
reopenBtn.ClipsDescendants = true
applyCorner(reopenBtn, 10)

-- Effet de bordure animée pour le bouton de réouverture
local reopenBtnStroke = Instance.new("UIStroke", reopenBtn)
reopenBtnStroke.Color = mainColor
reopenBtnStroke.Thickness = 2

local function animateReopenButton()
	local startTime = tick()
	while reopenBtn.Visible do
		local hue = (tick() - startTime) % 1
		reopenBtnStroke.Color = Color3.fromHSV(hue, 1, 1)
		wait(0.01)
	end
end
spawn(animateReopenButton)

reopenBtn.MouseButton1Click:Connect(function()
	openFrame(frame)
	reopenBtn.Visible = false
end)

local mainPage = Instance.new("Frame", frame)
mainPage.Size = UDim2.new(1, 0, 1, -45)
mainPage.Position = UDim2.new(0, 0, 0, 45)
mainPage.BackgroundTransparency = 1
local mainGradient = Instance.new("UIGradient", mainPage)
mainGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))

local settingsPage = Instance.new("Frame", frame)
settingsPage.Size = UDim2.new(1, 0, 1, -45)
settingsPage.Position = UDim2.new(0, 0, 0, 45)
settingsPage.BackgroundTransparency = 1
local settingsGradient = Instance.new("UIGradient", settingsPage)
settingsGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
settingsPage.Visible = false

local infoBtn = Instance.new("TextButton", settingsPage)
infoBtn.Size = UDim2.new(0, 180, 0, 35)
infoBtn.Position = UDim2.new(0.5, -90, 0.2, 0)
infoBtn.Text = "Infos Joueurs"
infoBtn.BackgroundColor3 = mediumGray
infoBtn.TextColor3 = lightGray
infoBtn.Font = Enum.Font.GothamBold
infoBtn.TextSize = 20
applyCorner(infoBtn, 10)
createStroke(infoBtn, mainColor, 2)

local infoPage = Instance.new("Frame", frame)
infoPage.Size = UDim2.new(1, 0, 1, -45)
infoPage.Position = UDim2.new(0, 0, 0, 45)
infoPage.BackgroundTransparency = 1
local infoGradient = Instance.new("UIGradient", infoPage)
infoGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
infoPage.Visible = false

local playerList = Instance.new("ScrollingFrame", infoPage)
playerList.Size = UDim2.new(1, -40, 1, -60)
playerList.Position = UDim2.new(0, 20, 0, 20)
playerList.BackgroundTransparency = 1
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.ScrollBarThickness = 6

local listLayout = Instance.new("UIListLayout", playerList)
listLayout.Padding = UDim.new(0, 5)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

local infoText = Instance.new("TextLabel", playerList)
infoText.Size = UDim2.new(1, 0, 0, 30)
infoText.Text = "👤 Joueurs dans le jeu :"
infoText.TextColor3 = Color3.fromRGB(200, 200, 200)
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
			playerBtn.BackgroundColor3 = mediumGray
			playerBtn.TextColor3 = lightGray
			playerBtn.Font = Enum.Font.Gotham
			playerBtn.TextSize = 18
			playerBtn.Text = ""
			applyCorner(playerBtn, 5)

			local contentFrame = Instance.new("Frame", playerBtn)
			contentFrame.Size = UDim2.new(1, 0, 1, 0)
			contentFrame.BackgroundTransparency = 1

			local hLayout = Instance.new("UIListLayout", contentFrame)
			hLayout.FillDirection = Enum.FillDirection.Horizontal
			hLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			hLayout.Padding = UDim.new(0, 5)

			local avatarImage = Instance.new("ImageLabel", contentFrame)
			avatarImage.Size = UDim2.new(0, 24, 0, 24)
			avatarImage.BackgroundTransparency = 1
			applyCorner(avatarImage, 12)

			local playerNameLabel = Instance.new("TextLabel", contentFrame)
			playerNameLabel.Size = UDim2.new(1, -29, 1, 0)
			playerNameLabel.Text = plr.Name
			playerNameLabel.Font = Enum.Font.GothamBold
			playerNameLabel.TextSize = 18
			playerNameLabel.TextColor3 = lightGray
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
					character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
				end
			end)
		end
	end

	playerList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
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
gameSetBtn.Size = UDim2.new(0, 180, 0, 35)
gameSetBtn.Position = UDim2.new(0.5, -90, 0.35, 0)
gameSetBtn.Text = "Game Set"
gameSetBtn.BackgroundColor3 = mediumGray
gameSetBtn.TextColor3 = lightGray
gameSetBtn.Font = Enum.Font.GothamBold
gameSetBtn.TextSize = 20
applyCorner(gameSetBtn, 10)
createStroke(gameSetBtn, mainColor, 2)

local gamePage = Instance.new("Frame", frame)
gamePage.Size = UDim2.new(1, 0, 1, -45)
gamePage.Position = UDim2.new(0, 0, 0, 45)
gamePage.BackgroundTransparency = 1
local gameGradient = Instance.new("UIGradient", gamePage)
gameGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
gamePage.Visible = false

local setPointBtn = Instance.new("TextButton", gamePage)
setPointBtn.Size = UDim2.new(0, 120, 0, 35)
setPointBtn.Position = UDim2.new(0.5, -60, 0.3, 0)
setPointBtn.Text = "Set Point"
setPointBtn.BackgroundColor3 = mainColor
setPointBtn.TextColor3 = lightGray
setPointBtn.Font = Enum.Font.GothamBold
setPointBtn.TextSize = 20
applyCorner(setPointBtn, 10)

local goPointBtn = Instance.new("TextButton", gamePage)
goPointBtn.Size = UDim2.new(0, 120, 0, 35)
goPointBtn.Position = UDim2.new(0.5, -60, 0.45, 0)
goPointBtn.Text = "Go To Point"
goPointBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
goPointBtn.TextColor3 = lightGray
goPointBtn.Font = Enum.Font.GothamBold
goPointBtn.TextSize = 20
applyCorner(goPointBtn, 10)

local removePointBtn = Instance.new("TextButton", gamePage)
removePointBtn.Size = UDim2.new(0, 120, 0, 35)
removePointBtn.Position = UDim2.new(0.5, -60, 0.6, 0)
removePointBtn.Text = "Remove Point"
removePointBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
removePointBtn.TextColor3 = lightGray
removePointBtn.Font = Enum.Font.GothamBold
removePointBtn.TextSize = 20
applyCorner(removePointBtn, 10)

local teleportPoint
local marker

setPointBtn.MouseButton1Click:Connect(function()
	teleportPoint = character.HumanoidRootPart.Position
	if marker then marker:Destroy() end
	marker = Instance.new("Part", workspace)
	marker.Size = Vector3.new(2, 2, 2)
	marker.Anchored = true
	marker.CanCollide = false
	marker.BrickColor = BrickColor.Red()
	marker.Position = teleportPoint + Vector3.new(0, 2, 0)
	marker.Name = "TeleportMarker"
end)

goPointBtn.MouseButton1Click:Connect(function()
	if teleportPoint then
		character.HumanoidRootPart.CFrame = CFrame.new(teleportPoint + Vector3.new(0, 3, 0))
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
hackBtn.Size = UDim2.new(0, 180, 0, 35)
hackBtn.Position = UDim2.new(0.5, -90, 0.5, 0)
hackBtn.Text = "Hacks"
hackBtn.BackgroundColor3 = mediumGray
hackBtn.TextColor3 = lightGray
hackBtn.Font = Enum.Font.GothamBold
hackBtn.TextSize = 20
applyCorner(hackBtn, 10)
createStroke(hackBtn, mainColor, 2)

local hackPage = Instance.new("Frame", frame)
hackPage.Size = UDim2.new(1, 0, 1, -45)
hackPage.Position = UDim2.new(0, 0, 0, 45)
hackPage.BackgroundTransparency = 1
local hackGradient = Instance.new("UIGradient", hackPage)
hackGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
hackPage.Visible = false

hackBtn.MouseButton1Click:Connect(function()
	settingsPage.Visible = false
	hackPage.Visible = true
end)

local graphBtn = Instance.new("TextButton", settingsPage)
graphBtn.Size = UDim2.new(0, 180, 0, 35)
graphBtn.Position = UDim2.new(0.5, -90, 0.65, 0)
graphBtn.Text = "Graph"
graphBtn.BackgroundColor3 = mediumGray
graphBtn.TextColor3 = lightGray
graphBtn.Font = Enum.Font.GothamBold
graphBtn.TextSize = 20
applyCorner(graphBtn, 10)
createStroke(graphBtn, mainColor, 2)

local graphPage = Instance.new("Frame", frame)
graphPage.Size = UDim2.new(1, 0, 1, -45)
graphPage.Position = UDim2.new(0, 0, 0, 45)
graphPage.BackgroundTransparency = 1
local graphGradient = Instance.new("UIGradient", graphPage)
graphGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
graphPage.Visible = false

graphBtn.MouseButton1Click:Connect(function()
	settingsPage.Visible = false
	graphPage.Visible = true
end)

local lightBtn = Instance.new("TextButton", graphPage)
lightBtn.Size = UDim2.new(0, 180, 0, 35)
lightBtn.Position = UDim2.new(0.5, -90, 0.3, 0)
lightBtn.Text = "Lumière: OFF"
lightBtn.BackgroundColor3 = mediumGray
lightBtn.TextColor3 = lightGray
lightBtn.Font = Enum.Font.GothamBold
lightBtn.TextSize = 20
applyCorner(lightBtn, 10)
createStroke(lightBtn, mainColor, 2)

local playerLight = nil
_G.lightEnabled = false

lightBtn.MouseButton1Click:Connect(function()
	_G.lightEnabled = not _G.lightEnabled
	if _G.lightEnabled then
		if not playerLight then
			playerLight = Instance.new("PointLight", character.HumanoidRootPart)
			playerLight.Brightness = 5
			playerLight.Range = 60
			playerLight.Color = Color3.new(1, 1, 1)
		end
		lightBtn.Text = "Lumière: ON"
		lightBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
	else
		if playerLight then
			playerLight:Destroy()
			playerLight = nil
		end
		lightBtn.Text = "Lumière: OFF"
		lightBtn.BackgroundColor3 = mediumGray
	end
end)

local wallhackBtn = Instance.new("TextButton", graphPage)
wallhackBtn.Size = UDim2.new(0, 180, 0, 35)
wallhackBtn.Position = UDim2.new(0.5, -90, 0.45, 0)
wallhackBtn.Text = "Wallhack: OFF"
wallhackBtn.BackgroundColor3 = mediumGray
wallhackBtn.TextColor3 = lightGray
wallhackBtn.Font = Enum.Font.GothamBold
wallhackBtn.TextSize = 20
applyCorner(wallhackBtn, 10)
createStroke(wallhackBtn, mainColor, 2)

_G.wallhackEnabled = false
local wallhackConnection = nil
local playerMarkers = {}

wallhackBtn.MouseButton1Click:Connect(function()
	_G.wallhackEnabled = not _G.wallhackEnabled
	if _G.wallhackEnabled then
		wallhackBtn.Text = "Wallhack: ON"
		wallhackBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)

		wallhackConnection = RS.Heartbeat:Connect(function()
			for _, targetPlayer in ipairs(game.Players:GetPlayers()) do
				if targetPlayer.Name ~= player.Name and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
					if not playerMarkers[targetPlayer] then
						local tag = Instance.new("BillboardGui")
						tag.Adornee = targetPlayer.Character:FindFirstChild("Head") or targetPlayer.Character.HumanoidRootPart
						tag.AlwaysOnTop = true
						tag.Size = UDim2.new(0, 50, 0, 50)
						tag.ExtentsOffset = Vector3.new(0, 5, 0)
						tag.Parent = targetPlayer.Character

						local stroke = Instance.new("UIStroke")
						stroke.Color = Color3.fromRGB(255, 0, 0)
						stroke.Thickness = 5
						stroke.Parent = tag

						local tracerFrame = Instance.new("Frame", tag)
						tracerFrame.Size = UDim2.new(1, 0, 1, 0)
						tracerFrame.BackgroundTransparency = 1

						local uStroke = Instance.new("UIStroke", tracerFrame)
						uStroke.Color = Color3.fromRGB(255, 0, 0)
						uStroke.Thickness = 5
						uStroke.Transparency = 0.5

						playerMarkers[targetPlayer] = tag
					end
				else
					if playerMarkers[targetPlayer] then
						playerMarkers[targetPlayer]:Destroy()
						playerMarkers[targetPlayer] = nil
					end
				end
			end
		end)

	else
		wallhackBtn.Text = "Wallhack: OFF"
		wallhackBtn.BackgroundColor3 = mediumGray
		if wallhackConnection then
			wallhackConnection:Disconnect()
			wallhackConnection = nil
		end
		for _, tag in pairs(playerMarkers) do
			tag:Destroy()
		end
		playerMarkers = {}
	end
end)

local profilePage = Instance.new("Frame", frame)
profilePage.Size = UDim2.new(1, 0, 1, -45)
profilePage.Position = UDim2.new(0, 0, 0, 45)
profilePage.BackgroundTransparency = 1
local profileGradient = Instance.new("UIGradient", profilePage)
profileGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15))
profilePage.Visible = false

local profileImage = Instance.new("ImageLabel", profilePage)
profileImage.Size = UDim2.new(0, 100, 0, 100)
profileImage.Position = UDim2.new(0.5, -50, 0.2, 0)
profileImage.BackgroundTransparency = 1
profileImage.BorderSizePixel = 0
applyCorner(profileImage, 50)
createStroke(profileImage, mainColor, 2)

local profileNameLabel = Instance.new("TextLabel", profilePage)
profileNameLabel.Size = UDim2.new(1, -40, 0, 30)
profileNameLabel.Position = UDim2.new(0, 20, 0.5, 0)
profileNameLabel.BackgroundTransparency = 1
profileNameLabel.TextColor3 = lightGray
profileNameLabel.Font = Enum.Font.GothamBold
profileNameLabel.TextSize = 22
profileNameLabel.TextXAlignment = Enum.TextXAlignment.Center

local profileIdLabel = Instance.new("TextLabel", profilePage)
profileIdLabel.Size = UDim2.new(1, -40, 0, 20)
profileIdLabel.Position = UDim2.new(0, 20, 0.6, 0)
profileIdLabel.BackgroundTransparency = 1
profileIdLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
profileIdLabel.Font = Enum.Font.Gotham
profileIdLabel.TextSize = 16
profileIdLabel.TextXAlignment = Enum.TextXAlignment.Center

local profileAgeLabel = Instance.new("TextLabel", profilePage)
profileAgeLabel.Size = UDim2.new(1, -40, 0, 20)
profileAgeLabel.Position = UDim2.new(0, 20, 0.7, 0)
profileAgeLabel.BackgroundTransparency = 1
profileAgeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
profileAgeLabel.Font = Enum.Font.Gotham
profileAgeLabel.TextSize = 16
profileAgeLabel.TextXAlignment = Enum.TextXAlignment.Center

spawn(function()
	local userId = player.UserId
	local success, url = pcall(function()
		return game.Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)
	if success then
		profileImage.Image = url
	end
	profileNameLabel.Text = player.Name
	profileIdLabel.Text = "ID: " .. userId
	profileAgeLabel.Text = "Ancienneté: " .. player.AccountAge .. " jours"
end)

settingsBtn.MouseButton1Click:Connect(function()
	settingsBtn.Visible = false
	backArrowBtn.Visible = true
	settingsPage.Visible = true
	mainPage.Visible = false
	profilePage.Visible = false
end)

backArrowBtn.MouseButton1Click:Connect(function()
	settingsBtn.Visible = true
	backArrowBtn.Visible = false
	settingsPage.Visible = false
	infoPage.Visible = false
	gamePage.Visible = false
	hackPage.Visible = false
	graphPage.Visible = false
	profilePage.Visible = false
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
signature.Size = UDim2.new(1, 0, 0, 15)
signature.Position = UDim2.new(0, 0, 1, -20)
signature.Text = "Powered by SHADOW"
signature.Font = Enum.Font.GothamBold
signature.TextSize = 12
signature.TextColor3 = mainColor
signature.BackgroundTransparency = 1
signature.TextScaled = false
signature.TextXAlignment = Enum.TextXAlignment.Center

spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			signature.TextColor3 = Color3.fromHSV(i, 1, 1)
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

local noclipConnection = nil -- Variable pour la connexion Noclip

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
	btn.Size = UDim2.new(0, 280, 0, 35)
	btn.Position = UDim2.new(0.5, -140, yPosition, 0)
	btn.Text = name .. ": OFF"
	local originalColor = mediumGray
	local onColor = Color3.fromRGB(0, 180, 0)
	local originalStrokeColor = mainColor
	local onStrokeColor = Color3.fromRGB(0, 255, 0)

	btn.BackgroundColor3 = originalColor
	btn.TextColor3 = lightGray
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 20
	applyCorner(btn, 10)
	local btnStroke = Instance.new("UIStroke", btn)
	btnStroke.Color = originalStrokeColor
	btnStroke.Thickness = 2

	btn.MouseButton1Click:Connect(function()
		_G[toggleVar] = not _G[toggleVar]
		btn.Text = name .. (_G[toggleVar] and ": ON" or ": OFF")
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
				bv:Destroy()
				bg:Destroy()
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

-- Correction de la fonction Noclip
createButton("Noclip", mainPage, "noclip", function(state)
	if noclipConnection then
		noclipConnection:Disconnect()
		noclipConnection = nil
	end

	if state then
		noclipConnection = RS.Stepped:Connect(function()
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end)
	else
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end
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
trackerFrame.Size = UDim2.new(0, 180, 0, 40)
trackerFrame.Position = UDim2.new(0, 10, 1, -50)
trackerFrame.BackgroundColor3 = darkGray
trackerFrame.Visible = false
applyCorner(trackerFrame, 10)
createStroke(trackerFrame, mainColor, 2)

local trackerLabel = Instance.new("TextLabel", trackerFrame)
trackerLabel.Size = UDim2.new(1, -20, 1, -10)
trackerLabel.Position = UDim2.new(0, 10, 0, 5)
trackerLabel.Text = "Distance: N/A"
trackerLabel.TextColor3 = lightGray
trackerLabel.Font = Enum.Font.GothamBold
trackerLabel.TextSize = 18
trackerLabel.BackgroundTransparency = 1

createHackButton("Tracker", "trackerEnabled", function(state)
	trackerFrame.Visible = state
end)

local leftArrowBtn = Instance.new("TextButton", gui)
leftArrowBtn.Size = UDim2.new(0, 50, 0, 50)
leftArrowBtn.Position = UDim2.new(0, 10, 0.5, -25)
leftArrowBtn.Text = "←"
leftArrowBtn.BackgroundColor3 = darkGray
leftArrowBtn.BackgroundTransparency = 0.5
leftArrowBtn.TextColor3 = lightGray
leftArrowBtn.Font = Enum.Font.GothamBold
leftArrowBtn.TextSize = 30
leftArrowBtn.Visible = false
applyCorner(leftArrowBtn, 25)
createStroke(leftArrowBtn, mainColor, 2)

local rightArrowBtn = Instance.new("TextButton", gui)
rightArrowBtn.Size = UDim2.new(0, 50, 0, 50)
rightArrowBtn.Position = UDim2.new(1, -60, 0.5, -25)
rightArrowBtn.Text = "→"
rightArrowBtn.BackgroundColor3 = darkGray
rightArrowBtn.BackgroundTransparency = 0.5
rightArrowBtn.TextColor3 = lightGray
rightArrowBtn.Font = Enum.Font.GothamBold
rightArrowBtn.TextSize = 30
rightArrowBtn.Visible = false
applyCorner(rightArrowBtn, 25)
createStroke(rightArrowBtn, mainColor, 2)

local spectatorPlayers = {}
local currentSpectatorIndex = 1
local cameraConnection

local spectatorNameLabel = Instance.new("TextLabel", gui)
spectatorNameLabel.Size = UDim2.new(0, 250, 0, 30)
spectatorNameLabel.Position = UDim2.new(0.5, -125, 0, 50)
spectatorNameLabel.BackgroundTransparency = 1
spectatorNameLabel.Font = Enum.Font.GothamBold
spectatorNameLabel.TextSize = 25
spectatorNameLabel.TextColor3 = lightGray
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
					camera.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 15)
					spectatorNameLabel.Text = target.Name
				end
			end)
			startSpectatorNameAnimation()
		else
			_G.spectatingEnabled = false
			leftArrowBtn.Visible = false
			rightArrowBtn.Visible = false
			spectatorNameLabel.Visible = false
			camera.CameraType = Enum.CameraType.Custom
		end
	else
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
					nameLabel.Size = UDim2.new(1, 0, 1, 0)
					nameLabel.Text = plr.Name
					nameLabel.TextColor3 = mainColor
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
			trackerLabel.Text = "Distance: " .. math.floor(closestDistance) .. " m"
		else
			trackerLabel.Text = "Distance: N/A"
		end
	end
end)

local function animateColor(textLabel)
	spawn(function()
		while true do
			for i = 0, 1, 0.01 do
				textLabel.TextColor3 = Color3.fromHSV(i, 1, 1)
				wait(0.02)
			end
		end
	end)
end

animateColor(title)
animateColor(reopenBtn.TextLabel)

submitBtn.MouseButton1Click:Connect(function()
	if passBox.Text == "95741" then
		loadingLabel.Visible = true
		loadingBarFrame.Visible = true
		for i = 1, 100 do
			loadingBar.Size = UDim2.new(i / 100, 0, 1, 0)
			loadingBar.BackgroundColor3 = Color3.fromHSV(i / 100, 1, 1)
			wait(0.01)
		end
		passPage:Destroy()
		openFrame(frame)
	else
		passBox.Text = ""
		passBox.PlaceholderText = "Mot de passe incorrect"
	end
end)
