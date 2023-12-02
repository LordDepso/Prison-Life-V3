-- Created by depso 

_G.DBulletSpam = {
	MaxBullets = 8, -- Reload after 8 shots
	Gun = "AK-47",
	Active = true
}

--------------------

local TargetTeam = game:GetService("Teams").Guards
local LocalPlayer = game:GetService("Players").LocalPlayer
local Gun =  LocalPlayer:FindFirstChild(_G.DBulletSpam.Gun, true)
local GunEvents = game:GetService("ReplicatedStorage").GunEvents

local Reload = GunEvents.Reload
local Shoot = GunEvents.Shoot
local CurrentBullets = 0 

if not Gun then
	return warn("Unable to find gun, make sure you are not holding it")
end

function ShootAtPart(Part)
	if CurrentBullets <= 0 then
		Reload:FireServer(Gun)
		wait(.5)
		CurrentBullets = _G.DBulletSpam.MaxBullets
	end
	
	local Data = {
		{
			["Ray"] = Ray.new(Vector3.new(0,-100,0), Vector3.new(0,-100,0)),
			["Hit"] = Part
		}
	}
	CurrentBullets = CurrentBullets - 1 -- I hate vistual studio's syntax
	Data[1].HitSize = Data[1].Hit.Size
	Shoot:FireServer(Data, Gun)
end

function KillPlayer(Player)
	if not Player or not Player.Character then
		return
	end

	local Head = Player.Character:FindFirstChild("Head")
	local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")

	if not Head or not Humanoid then
		return 
	end

	repeat 
		ShootAtPart(Player.Character.Head)
		wait()
	until Humanoid.Health <= 0 
end

while wait(.5) and _G.DBulletSpam.Active do
	for _, Player in next, TargetTeam:GetPlayers() do
		KillPlayer(Player)
	end
end