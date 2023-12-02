DisableRemote = function(Remote)
	for i, connection in next, getconnections(Remote.OnClientEvent) do
		connection:Disable()
	end
end
DisableRemote(game.ReplicatedStorage.GunEvents.Shoot)