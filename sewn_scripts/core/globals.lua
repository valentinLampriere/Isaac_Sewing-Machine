local Globals = { }

Globals.V0 = Vector(0, 0)

Globals.game = Game()
Globals.sound = SFXManager()
Globals.rng = RNG()
Globals.rng:SetSeed(Random() + 1, 75)

Globals.Room = nil
Globals.Level = nil

return Globals
