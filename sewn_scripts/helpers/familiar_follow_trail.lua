local function FamiliarFollowTrail(familiar, position, forceChildLeash)
    if familiar.Player and (familiar.Player:HasTrinket(TrinketType.TRINKET_CHILD_LEASH) or forceChildLeash == true) and (familiar.Position-position):LengthSquared() > 9 then
        familiar:FollowPosition(position + (familiar.Position-position):Resized(3))
    elseif (familiar.Position-position):LengthSquared() > 625 then
        familiar:FollowPosition(position + (familiar.Position-position):Resized(25))
    else
        familiar:FollowPosition(familiar.Position)
    end
    familiar.Velocity = familiar.Velocity * 1.9
end
return FamiliarFollowTrail