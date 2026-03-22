repeat task.wait() until game:IsLoaded()

local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

-- 🔥 TOGGLE AUTOMÁTICO
getgenv().HITBOX_ENABLED = not getgenv().HITBOX_ENABLED

-- 🔥 CONFIG (si no existen)
getgenv().HITBOX_SIZE = getgenv().HITBOX_SIZE or 10
getgenv().HITBOX_TRANSPARENCY = getgenv().HITBOX_TRANSPARENCY or 0.8

-- evitar duplicar loops
if getgenv().HITBOX_LOOP then return end

local OriginalData = {}

getgenv().HITBOX_LOOP = RunService.RenderStepped:Connect(function()

	local EnemiesFolder = workspace:FindFirstChild("Enemies")
	if not EnemiesFolder then return end

	for _, NPC in ipairs(EnemiesFolder:GetChildren()) do
		
		local RootPart = NPC:FindFirstChild("HumanoidRootPart")
		local Humanoid = NPC:FindFirstChildOfClass("Humanoid")
		
		if RootPart and Humanoid then
			
			if not OriginalData[NPC] then
				OriginalData[NPC] = {
					Size = RootPart.Size,
					Transparency = RootPart.Transparency
				}
			end
			
			if getgenv().HITBOX_ENABLED and Humanoid.Health > 0 then
				
				local size = getgenv().HITBOX_SIZE
				local trans = getgenv().HITBOX_TRANSPARENCY
				
				RootPart.Size = Vector3.new(size, size, size)
				RootPart.Transparency = trans
				RootPart.BrickColor = BrickColor.new("Really red")
				RootPart.Material = Enum.Material.Neon
				
			else
				if OriginalData[NPC] then
					RootPart.Size = OriginalData[NPC].Size
					RootPart.Transparency = OriginalData[NPC].Transparency
				end
			end
			
			RootPart.CanCollide = false
		end
	end

end)
