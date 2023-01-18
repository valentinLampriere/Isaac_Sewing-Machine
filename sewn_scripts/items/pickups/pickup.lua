local Globals = require("sewn_scripts.core.globals")
local CustomPickup = require("sewn_scripts.items.pickups.variants.custom_pickup")

local Pickup = { }

local registeredPickups = { }

function Pickup:RegisterNewPickup(pickupTable)
    local variant = pickupTable.Variant
    local subtype = pickupTable.SubType

    if registeredPickups[variant] == nil then
        registeredPickups[variant] = {}
    end

    registeredPickups[variant][subtype] = CustomPickup:New(pickupTable)
end

local function GetRegisteredPickup(variant, subtype)
    if registeredPickups[variant] ~= nil and registeredPickups[variant][subtype] ~= nil then
        return registeredPickups[variant][subtype]
    end
end

function Pickup:OnInit(pickup)
    local variant = pickup.Variant
    local subtype = pickup.SubType

    local customPickup = GetRegisteredPickup(variant, subtype)
    local sprite = pickup:GetSprite()
    if customPickup == nil then
        return
    end

    if pickup:IsShopItem() == true then
        return
    end
    
    if not sprite:IsPlaying("Appear") then
        return
    end

    customPickup:OnInit(pickup)
end

function Pickup:OnUpdate(pickup)
    local variant = pickup.Variant
    local subtype = pickup.SubType

    local customPickup = GetRegisteredPickup(variant, subtype)
    if customPickup == nil then
        return
    end

    customPickup:OnUpdate(pickup)
end

function Pickup:OnCollision(pickup, collider, low)
    local variant = pickup.Variant
    local subtype = pickup.SubType

    local customPickup = GetRegisteredPickup(variant, subtype)
    if customPickup == nil then
        return
    end
    
    local player = collider:ToPlayer()
    if collider.Type ~= EntityType.ENTITY_PLAYER or player == nil then
        return
    end

    local sprite = pickup:GetSprite()
    if sprite:IsPlaying("Idle") then

        local collision = customPickup:OnCollision(pickup, player)
        if collision ~= true then
            customPickup:OnPickedUp(pickup, player)

            sprite:Play("Collect", true)
            pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
            pickup.Touched = true
            pickup.Velocity = Globals.V0
            pickup:Die()

            Globals.SFX:Play(customPickup.PickupSound.ID, customPickup.PickupSound.Volume, customPickup.PickupSound.FrameDelay, customPickup.PickupSound.Loop, customPickup.PickupSound.Pitch)
        end
        
        return collision
    else
        return true
    end
end

return Pickup