local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remoteFolder = ReplicatedStorage:FindFirstChild("PlayerTeleportRemotes")
if not remoteFolder then
    remoteFolder = Instance.new("Folder")
    remoteFolder.Name = "PlayerTeleportRemotes"
    remoteFolder.Parent = ReplicatedStorage
end

local requestTeleport = remoteFolder:FindFirstChild("RequestTeleport")
if not requestTeleport then
    requestTeleport = Instance.new("RemoteEvent")
    requestTeleport.Name = "RequestTeleport"
    requestTeleport.Parent = remoteFolder
end

local function getCharacterRoot(player)
    local character = player.Character
    if not character then
        return nil
    end

    return character:FindFirstChild("HumanoidRootPart")
end

requestTeleport.OnServerEvent:Connect(function(requestingPlayer, targetUserId)
    if typeof(targetUserId) ~= "number" then
        return
    end

    local targetPlayer = Players:GetPlayerByUserId(targetUserId)
    if not targetPlayer or targetPlayer == requestingPlayer then
        return
    end

    local requestingRoot = getCharacterRoot(requestingPlayer)
    local targetRoot = getCharacterRoot(targetPlayer)
    if not requestingRoot or not targetRoot then
        return
    end

    requestingRoot.CFrame = targetRoot.CFrame + Vector3.new(3, 0, 0)
end)
