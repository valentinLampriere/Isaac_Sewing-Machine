local Globals = require("sewn_scripts.core.globals")

local function SpawnBones(spawner, position, min, max, force)
    if spawner == nil then return end
    min = min or 1
    max = max or 1
    force = force or 15.0
    position = position or spawner.Position

    local amount = spawner:GetDropRNG():RandomInt( max - min ) + min
    for i = 1, amount do
        local velo = Vector(math.random(-force, force), math.random(-force, force))
        local bone = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BONE_SPUR, 0, position, Globals.V0, spawner)
        bone.Velocity = velo
    end
end

return SpawnBones