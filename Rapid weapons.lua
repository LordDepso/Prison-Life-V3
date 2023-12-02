-- Created by depso 
-- Execute this, then pickup a weapon
local LoadWeaponRemote = game:GetService("ReplicatedStorage").Events.LoadTool

for i, connection in next, getconnections(LoadWeaponRemote.OnClientEvent) do
	local Old;Old=hookfunction(connection.Function, function(Tool, ...)
		xpcall(function()
            local GunStates = require(Tool:WaitForChild("GunStates"))
			GunStates.FireRate = 0	
			GunStates.Spread = 100000
			GunStates.Range = 100000
			GunStates.AutoFire = true
			print("Hijacked GunStates for", Tool.Name)
		end, function()
			warn("Failed to write new GunStates")
		end)

		Old(Tool, ...)
	end)
end