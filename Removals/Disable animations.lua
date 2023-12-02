-- Created by depso
local Animations = game:GetService("ReplicatedStorage"):WaitForChild("GunAnimations")
for _, Anim in next, Animations:GetChildren() do
	Anim.AnimationId = ""
end