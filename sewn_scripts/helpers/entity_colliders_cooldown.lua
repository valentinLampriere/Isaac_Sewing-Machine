local EntityCollidersCooldown = { }

function EntityCollidersCooldown:Add(entity, collider, name, cooldown)
    local data = entity:GetData()
    name = name or "cooldown"
    cooldown = cooldown or 60
    local sewn_name = "Sewn_" .. name
    
    if data[sewn_name] == nil then
        data[sewn_name] = { }
    else
        if EntityCollidersCooldown:IsInCooldown(entity, collider, name) then
            return
        end
    end

    data[sewn_name][GetPtrHash(collider)] = entity.FrameCount + cooldown
end

function EntityCollidersCooldown:IsInCooldown(entity, collider, name)
    local data = entity:GetData()
    name = name or "cooldown"
    local sewn_name = "Sewn_" .. name

    if data[sewn_name] == nil or data[sewn_name][GetPtrHash(collider)] == nil then
        return false
    end
    
    return data[sewn_name][GetPtrHash(collider)] >= entity.FrameCount
end

return EntityCollidersCooldown