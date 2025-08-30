-- Création de l'écran
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SHADOWX"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Fenêtre principale
local mainWindow = Instance.new("Frame")
mainWindow.Name = "MainWindow"
mainWindow.Size = UDim2.new(0, 500, 0, 300)  -- Taille initiale de la fenêtre
mainWindow.Position = UDim2.new(0.5, -250, 0.5, -150)  -- Initialement cachée en dehors de l'écran
mainWindow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainWindow.BackgroundTransparency = 0.1
mainWindow.BorderSizePixel = 0
mainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
mainWindow.ClipsDescendants = true
mainWindow.Parent = screenGui

-- Style de la fenêtre (coins arrondis, ombre, etc.)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)  -- Coins arrondis
corner.Parent = mainWindow

-- Ajout de l'ombre
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 10, 1, 10)  -- Ombre légèrement décalée
shadow.Position = UDim2.new(0, 5, 0, 5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.5
shadow.BorderSizePixel = 0
shadow.Parent = mainWindow

-- Header (catégories)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
header.BorderSizePixel = 0
header.Parent = mainWindow

-- Titre de la fenêtre
local title = Instance.new("TextLabel")
title.Text = "SHADOWX"
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Fermeture (bouton X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.BorderSizePixel = 0
closeButton.Parent = header

closeButton.MouseButton1Click:Connect(function()
	mainWindow:TweenPosition(UDim2.new(0.5, -250, 0.5, -350), "Out", "Quad", 0.5, true)  -- Animation de fermeture
	reopenButton.Visible = true
end)

-- Bouton "Réouvrir" (discret, en bas à droite)
local reopenButton = Instance.new("TextButton")
reopenButton.Size = UDim2.new(0, 50, 0, 50)
reopenButton.Position = UDim2.new(1, -60, 1, -60)
reopenButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
reopenButton.Text = "+"
reopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
reopenButton.TextSize = 30
reopenButton.BorderSizePixel = 0
reopenButton.Visible = false  -- Visible seulement après fermeture de la fenêtre
reopenButton.Parent = screenGui

reopenButton.MouseButton1Click:Connect(function()
	mainWindow:TweenPosition(UDim2.new(0.5, -250, 0.5, -150), "Out", "Quad", 0.5, true)  -- Animation de réouverture
	reopenButton.Visible = false
end)

-- Bouton plein écran
local fullscreenButton = Instance.new("TextButton")
fullscreenButton.Size = UDim2.new(0, 50, 0, 50)
fullscreenButton.Position = UDim2.new(1, -60, 0, 60)
fullscreenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fullscreenButton.Text = "⬜"
fullscreenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
fullscreenButton.TextSize = 30
fullscreenButton.BorderSizePixel = 0
fullscreenButton.Parent = screenGui

fullscreenButton.MouseButton1Click:Connect(function()
	if mainWindow.Size == UDim2.new(0, 500, 0, 300) then
		mainWindow.Size = UDim2.new(0, 1000, 0, 600)
	else
		mainWindow.Size = UDim2.new(0, 500, 0, 300)
	end
end)

-- Animation d'entrée de la fenêtre
mainWindow.Position = UDim2.new(0.5, -250, 0.5, -350)  -- Initialement hors de l'écran
mainWindow:TweenPosition(UDim2.new(0.5, -250, 0.5, -150), "Out", "Quad", 1, true)  -- Animation d'entrée

-- Affichage du profil de l'utilisateur
local userFrame = Instance.new("Frame")
userFrame.Size = UDim2.new(0, 200, 0, 50)
userFrame.Position = UDim2.new(0, 10, 1, -60)
userFrame.BackgroundTransparency = 1
userFrame.Parent = mainWindow

-- Nom de l'utilisateur
local userNameLabel = Instance.new("TextLabel")
userNameLabel.Text = game.Players.LocalPlayer.Name
userNameLabel.Size = UDim2.new(1, -50, 1, 0)
userNameLabel.BackgroundTransparency = 1
userNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
userNameLabel.TextSize = 18
userNameLabel.TextXAlignment = Enum.TextXAlignment.Left
userNameLabel.Parent = userFrame

-- Image de profil ronde
local userProfilePicture = Instance.new("ImageLabel")
userProfilePicture.Size = UDim2.new(0, 40, 0, 40)
userProfilePicture.Position = UDim2.new(1, -40, 0, 5)
userProfilePicture.BackgroundTransparency = 1
userProfilePicture.Image = "https://www.roblox.com/bust-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=100&height=100&format=png"
userProfilePicture.ClipsDescendants = true  -- Masque l'image pour la rendre ronde
userProfilePicture.Parent = userFrame

-- Coins arrondis pour l'image de profil
local profileCorner = Instance.new("UICorner")
profileCorner.CornerRadius = UDim.new(1, 0)  -- Rendre l'image de profil ronde
profileCorner.Parent = userProfilePicture
