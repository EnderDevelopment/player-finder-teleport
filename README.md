# Roblox Player Teleport Script

Player Finder Teleport is a Roblox script that displays other players in the current server and lets you request a teleport beside a selected player. The player list shows display names and usernames, refreshes when players join or leave, and can be minimized and restored.

## Install

1. Add a Script to ServerScriptService and paste in the contents of `PlayerTeleportServer.server.lua`.
2. Add a LocalScript to StarterPlayer > StarterPlayerScripts and paste in the contents of `PlayerTeleportGui.client.lua`.
3. Test in Roblox Studio with at least two players using Test > Start with multiple players.

The server script creates the `PlayerTeleportRemotes` folder and `RequestTeleport` RemoteEvent in ReplicatedStorage automatically.

## Use

1. Open the experience. The panel lists other players currently in the server.
2. Select a player to request a teleport beside them.
3. Select the minus button to minimize the panel, then the plus button to restore it.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/80634ec4-bd3a-4d84-8b4a-7f36b3575bc9?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=80634ec4-bd3a-4d84-8b4a-7f36b3575bc9
