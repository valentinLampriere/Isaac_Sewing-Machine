local CustomPickup = {
    Variant = 0,
    SubType = 0,
    PickupSound = {
        ID = 0,
        Volume = 1,
        FrameDelay = 2,
        Loop = false,
        Pitch = 1
    }
}

local defaultSounds = {
    [10] = SoundEffect.SOUND_BOSS2_BUBBLES,
    [20] = SoundEffect.SOUND_PENNYPICKUP,
    [30] = SoundEffect.SOUND_KEYPICKUP_GAUNTLET,
    [40] = SoundEffect.SOUND_FETUS_FEET,
    [90] = SoundEffect.SOUND_BATTERYCHARGE
}

function CustomPickup:New(o)
    o = o or { }
    setmetatable(o, self)

    o.PickupSound = o.PickupSound or { }
    o.PickupSound.ID = o.PickupSound.ID or defaultSounds[o.Variant]

    self.__index = self
    return o
end

function CustomPickup:OnInit(pickup)

end

function CustomPickup:OnUpdate(pickup)

end

function CustomPickup:OnCollision(pickup, player)
    return false
end

function CustomPickup:OnPickedUp(pickup, player)
    
end

return CustomPickup