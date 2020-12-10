
M_SYR.TOT_SYR.Wunjo = M_SYR.GetSyringeIdByName("Wunjo")

M_SYR.EFF_TAB[M_SYR.TOT_SYR.Wunjo] = {
	ID = M_SYR.TOT_SYR.Wunjo,
	Type = M_SYR.TYPES.Positive,
	Name = "Wunjo",
	Description = "Remove familiars",
	EIDDescription = "Remove familiars for 30s",
	Duration = 900,
	Weight = 1.2,
	Effect = {
		[1] = {
				Function = function(_, familiar)
						local self = M_SYR.EFF_TAB[M_SYR.TOT_SYR.DPSBoost]
						familiar.Player.Damage = familiar.Player.Damage + 0.01
						if not familiar.Player:GetData().SyringeEffects[self.ID] then return end
						
						local c = familiar:GetColor()
						familiar:SetColor(Color(c.r, c.g, c.b, 0.5, c.ro, c.go, c.bo), 1, 3, true, false)
				end,
				Callback = ModCallbacks.MC_POST_FAMILIAR_RENDER
		}
	},
	
	OnUse = function(idx)

	end,
	
	Post = function(player)
		
	end,
}

sewingMachineMod.errFamiliars.Error()