local function FindCloserNpc(position, range)
    range = range or 500
    local closestNpc = nil
    local closestNpc_distanceSqrt = 999999

    local npcs = Isaac.FindInRadius(position, range, EntityPartition.ENEMY)
    for _, npc in pairs(npcs) do
        if npc:IsVulnerableEnemy() and not npc:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
            local _distanceSqrt = (npc.Position - position):LengthSquared()
            if _distanceSqrt < closestNpc_distanceSqrt then
                closestNpc_distanceSqrt = _distanceSqrt
                closestNpc = npc
            end
        end
    end
    return closestNpc
end

return FindCloserNpc