local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local remotes = ReplicatedStorage:WaitForChild("PlayerTeleportRemotes")
local requestTeleport = remotes:WaitForChild("RequestTeleport")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerTeleportGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 10
screenGui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Name = "PlayerListPanel"
panel.Size = UDim2.fromOffset(260, 360)
panel.Position = UDim2.new(1, -280, 0, 24)
panel.BackgroundColor3 = Color3.fromRGB(25, 28, 35)
panel.BorderSizePixel = 0
panel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 8)
panelCorner.Parent = panel

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -48, 0, 40)
title.Position = UDim2.fromOffset(14, 0)
title.BackgroundTransparency = 1
title.Text = "Players"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.fromOffset(32, 28)
minimizeButton.Position = UDim2.new(1, -40, 0, 6)
minimizeButton.BackgroundColor3 = Color3.fromRGB(55, 61, 72)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 20
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = panel

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = minimizeButton

local list = Instance.new("ScrollingFrame")
list.Name = "PlayerList"
list.Size = UDim2.new(1, -20, 1, -54)
list.Position = UDim2.fromOffset(10, 46)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 6
list.CanvasSize = UDim2.new()
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.Parent = panel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.Name
layout.Parent = list

local restoreButton = Instance.new("TextButton")
restoreButton.Name = "RestoreButton"
restoreButton.Size = UDim2.fromOffset(44, 44)
restoreButton.Position = UDim2.new(1, -64, 0, 24)
restoreButton.BackgroundColor3 = Color3.fromRGB(25, 28, 35)
restoreButton.Text = "+"
restoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreButton.TextSize = 26
restoreButton.Font = Enum.Font.GothamBold
restoreButton.Visible = false
restoreButton.Parent = screenGui

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 8)
restoreCorner.Parent = restoreButton

local function makePlayerButton(player)
    local button = Instance.new("TextButton")
    button.Name = tostring(player.UserId)
    button.Size = UDim2.new(1, -6, 0, 36)
    button.BackgroundColor3 = Color3.fromRGB(43, 48, 58)
    button.Text = player.DisplayName .. "  @" .. player.Name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.TextTruncate = Enum.TextTruncate.AtEnd
    button.Parent = list

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        requestTeleport:FireServer(player.UserId)
    end)
end

local function refreshPlayerList()
    for _, child in ipairs(list:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local currentPlayers = Players:GetPlayers()
    table.sort(currentPlayers, function(first, second)
        return string.lower(first.Name) < string.lower(second.Name)
    end)

    for _, player in ipairs(currentPlayers) do
        if player ~= localPlayer then
            makePlayerButton(player)
        end
    end
end

minimizeButton.MouseButton1Click:Connect(function()
    panel.Visible = false
    restoreButton.Visible = true
end)

restoreButton.MouseButton1Click:Connect(function()
    panel.Visible = true
    restoreButton.Visible = false
end)

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)
refreshPlayerList()
