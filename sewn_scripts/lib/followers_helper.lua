if FollowersHelper then return FollowersHelper end

FollowersHelper = { }

FollowersHelper.TrailPriority = {
    PRIORITY_KING_BABY = 1000,
    PRIORITY_INCUBUS = 900,
    PRIORITY_VERY_CLOSE = 500,
    PRIORITY_CLOSE = 300,
    PRIORITY_SHOOTERS = 100,
    PRIORITY_NONE = 10
}

local familiarsTrailPriority = {
    [FamiliarVariant.BROTHER_BOBBY] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.DEMON_BABY] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.LITTLE_CHUBBY] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.LITTLE_GISH] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.LITTLE_STEVEN] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.ROBO_BABY] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.SISTER_MAGGY] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.GHOST_BABY] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.HARLEQUIN_BABY] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.RAINBOW_BABY] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.ISAACS_HEAD] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.BOMB_BAG] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.SACK_OF_PENNIES] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.LITTLE_CHAD] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.RELIC] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.HOLY_WATER] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.KEY_PIECE_1] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.KEY_PIECE_2] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.KEY_FULL] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.DEAD_CAT] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.ONE_UP] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.DRY_BABY] = FollowersHelper.TrailPriority.PRIORITY_CLOSE,
    [FamiliarVariant.JUICY_SACK] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.ROTTEN_BABY] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.HEADLESS_BABY] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.MYSTERY_SACK] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.BOBS_BRAIN] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.LIL_BRIMSTONE] = FollowersHelper.TrailPriority.PRIORITY_VERY_CLOSE,
    [FamiliarVariant.MONGO_BABY] = FollowersHelper.TrailPriority.PRIORITY_CLOSE,
    [FamiliarVariant.INCUBUS] = FollowersHelper.TrailPriority.PRIORITY_INCUBUS,
    [FamiliarVariant.FATES_REWARD] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.LIL_CHEST] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.CHARGED_BABY] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.CENSER] = FollowersHelper.TrailPriority.PRIORITY_CLOSE,
    [FamiliarVariant.RUNE_BAG] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.SERAPHIM] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.GB_BUG] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.FARTING_BABY] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.LIL_LOKI] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.MILK] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.TONSIL] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.BIG_CHUBBY] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.DEPRESSION] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.LIL_MONSTRO] = FollowersHelper.TrailPriority.PRIORITY_VERY_CLOSE,
    [FamiliarVariant.KING_BABY] = FollowersHelper.TrailPriority.PRIORITY_KING_BABY,
    [FamiliarVariant.ACID_BABY] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.SACK_OF_SACKS] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.BUDDY_IN_A_BOX] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.MYSTERY_EGG] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.LIL_SPEWER] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.HALLOWED_GROUND] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.JAW_BONE] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.BLOOD_OATH] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.BOILED_BABY] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.FREEZER_BABY] = FollowersHelper.TrailPriority.PRIORITY_SHOOTERS,
    [FamiliarVariant.KNIFE_PIECE_1] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.KNIFE_PIECE_2] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.PASCHAL_CANDLE] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.KNIFE_FULL] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.LIL_ABADDON] = FollowersHelper.TrailPriority.PRIORITY_CLOSE,
    [FamiliarVariant.LIL_PORTAL] = FollowersHelper.TrailPriority.PRIORITY_NONE,
    [FamiliarVariant.VANISHING_TWIN] = FollowersHelper.TrailPriority.PRIORITY_NONE
}

---Add a trail priority for familiars with the given Variant ID.
---@param familiarVariant FamiliarVariant
---@param priority integer The priority value for the familiar. The enum FollowersHelper.TrailPriority is used to match with vanilla familiars, but any number works.
function FollowersHelper:AddFamiliarTrailPriority(familiarVariant, priority)
    familiarsTrailPriority[familiarVariant] = priority
end

---Extract the given familiar from the familiar trail and throw it.
---@param familiar EntityFamiliar The familiar to throw.
---@param velocity Vector
function FollowersHelper:ThrowFollower(familiar, velocity)
    if familiar == nil or familiar:ToFamiliar() == nil then
        error("The function \"ThrowFollower\" from \"FollowersHelper\" requires an argument of type EntityFamiliar")
        return
    end

    local fData = familiar:GetData()
    local parent = familiar.Parent or familiar.Player
    local parentFamiliar = parent:ToFamiliar()
    local child = familiar.Child
    fData.followersHelper_parent = parent
    fData.followersHelper_child = child

    if parentFamiliar ~= nil then
        parent.Child = child
    end
    if child ~= nil then
        child.Parent = parent
    end
    
    familiar.Velocity = velocity
end

---Put the given familiar which have been extracted back in the familiar train, where it was.
---@param familiar EntityFamiliar
function FollowersHelper:PutBackInTrail(familiar)
    if familiar == nil or familiar:ToFamiliar() == nil then
        error("The function \"PutBackInTrail\" from \"FollowersHelper\" requires an argument of type EntityFamiliar")
        return
    end

    local fData = familiar:GetData()
    local parent = fData.followersHelper_parent
    local parentFamiliar = parent:ToFamiliar()
    local child = fData.followersHelper_child

    if parentFamiliar ~= nil then
        familiar.Parent = parent
        parent.Child = familiar
    end
    if child ~= nil then
        familiar.Child = child
        child.Parent = familiar
    end
end

function FollowersHelper:GetFollowers(player)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    local followers = { }

    for i, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if familiar ~= nil and familiar.IsFollower == true then
            if player ~= nil and GetPtrHash(player) == GetPtrHash(familiar.Player) or player == nil then
                table.insert(followers, familiar)
            end
        end
    end
    
    return followers
end

-- API OVerride --
if not APIOverride then
    APIOverride = {
        OverriddenClasses = {}
    }
    
    function APIOverride.GetClass(class)
        if type(class) == "function" then
            return getmetatable(class()).__class
        else
            return getmetatable(class).__class
        end
    end
    
    function APIOverride.OverrideClass(class)
        local class_mt = APIOverride.GetClass(class)
        
        local classDat = APIOverride.OverriddenClasses[class_mt.__type]
        if not classDat then
            classDat = {Original = class_mt, New = {}}

            local oldIndex = class_mt.__index
            
            rawset(class_mt, "__index", function(self, k)
                return classDat.New[k] or oldIndex(self, k)
            end)
            
            APIOverride.OverriddenClasses[class_mt.__type] = classDat
        end

        return classDat
    end

    function APIOverride.GetCurrentClassFunction(class, funcKey)
        local class_mt = APIOverride.GetClass(class)
        return class_mt[funcKey]
    end

    function APIOverride.OverrideClassFunction(class, funcKey, fn)
        local classDat = APIOverride.OverrideClass(class)
        classDat.New[funcKey] = fn
    end
end

local function TryPutFamiliarForwardInTrail(familiar)
    local parentFamiliar = familiar.Parent

    if parentFamiliar == nil then
        return -- Do not have other familiars in the trail.
    end
    
    local parentPriority = familiarsTrailPriority[parentFamiliar.Variant] or FollowersHelper.TrailPriority.PRIORITY_NONE
    local familiarPriority = familiarsTrailPriority[familiar.Variant] or FollowersHelper.TrailPriority.PRIORITY_NONE

    if parentPriority < familiarPriority then
        familiar.Parent = parentFamiliar.Parent
        familiar.Child = parentFamiliar
        parentFamiliar.Parent = familiar
        parentFamiliar.Child = familiar.Child

        TryPutFamiliarForwardInTrail(familiar)
    end
end

local oldFollowParent = APIOverride.GetCurrentClassFunction(EntityFamiliar, "FollowParent")
APIOverride.OverrideClassFunction(EntityFamiliar, "FollowParent", function(entity)
    oldFollowParent(entity)
    TryPutFamiliarForwardInTrail(entity)
end)


return FollowersHelper