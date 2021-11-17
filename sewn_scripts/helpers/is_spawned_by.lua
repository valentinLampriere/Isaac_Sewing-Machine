local function IsSpawnedBy(entity, familiar)
    local repentance = REPENTANCE and entity.SpawnerEntity ~= nil and GetPtrHash(entity.SpawnerEntity) == GetPtrHash(familiar)
    local afterbirthPlus = not REPENTANCE and entity.SpawnerType == familiar.Type and entity.SpawnerVariant == familiar.Variant
    return repentance or afterbirthPlus
end
return IsSpawnedBy