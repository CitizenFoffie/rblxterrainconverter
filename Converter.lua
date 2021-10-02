--put this in Terrain
local region = Region3.new(Vector3.new(0,-1,0), Vector3.new(600,512,600))
region = region:ExpandToGrid(4)
local material, occupancy = game.Workspace.Terrain:ReadVoxels(region, 4)
local size = material.Size
local Budget = 1/60 -- seconds

local expireTime = 0
local function ResetTimer()
	expireTime = tick() + Budget
end
local function MaybeYield()
	if tick() >= expireTime then
		wait() -- insert preferred yielding method
		ResetTimer()
	end
end
for x = 1, size.X do
	for y = 1, size.Y do
		for z = 1, size.Z do
			if material[x][y][z] ~= Enum.Material.Air then
				MaybeYield()
				--print("Material at (", x, y, z, "): ", material[x][y][z])
				local pos = script.Parent:CellCenterToWorld(x,y,z)
				--local part = Instance.new("Part")
				--part.Size = Vector3.new(4,4,4)
				--part.Anchored = true
				--part.Parent = game.Workspace
				--part.Position = pos

				game.ServerScriptService.LegacyTerrainManager.PlaceTerrainBlock2:Fire(pos,"MegaGrass")
				
			end
		end
	end
end
