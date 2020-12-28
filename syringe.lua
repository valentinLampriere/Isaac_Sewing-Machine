sewingMachineMod.sewnSyringes = {}
sewnSyringes = sewingMachineMod.sewnSyringes

M_SYR.TOT_SYR.familiarBuff = M_SYR.GetSyringeIdByName("Familiar Buff")

sewnSyringes.data = {}

function sewnSyringes:addSyringe(id, type, name, description, EIDDescription, duration, counterpart, weight, effect, onuse, post, data)
	M_SYR.EFF_TAB[id] = {
		ID = id,
		Type = type,
		Name = name,
		Description = description,
		EIDDescription = EIDDescription,
		Duration = duration,
		Weight = weight,
		Effect = effect,
		OnUse = onuse,
		Post = post
	}

	sewnSyringes.data[id] = data
end

--------------------
-- FAMILIARS BUFF --
--------------------
function sewnSyringes.familiarsBuff_onUse(idx)
	local sData = sewnSyringes.data[M_SYR.TOT_SYR.familiarBuff]
	local player = M_SYR.GetPlayerUsingActive()
	-- Loop through familiars
	for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
		local fData = familiar:GetData()
		familiar = familiar:ToFamiliar()
		-- Check if the familiar is from the current player
		if GetPtrHash(familiar.Player) == GetPtrHash(player) then
			-- Save the original level
			sData.familiarsLevels[GetPtrHash(familiar)] = fData.Sewn_upgradeState or 0
			
			sewingMachineMod:resetFamiliarData(familiar, {"Sewn_upgradeState_temporary"})

			-- Set the familiar's level (unless it is already ultra)
			if fData.Sewn_upgradeState ~= sewingMachineMod.UpgradeState.ULTRA then
				fData.Sewn_upgradeState = fData.Sewn_upgradeState + 1
			end

			-- Upgrade the familiar
			sewingMachineMod:callFamiliarUpgrade(familiar)
		end
	end
end
function sewnSyringes.familiarsBuff_post(player)
	local sData = sewnSyringes.data[M_SYR.TOT_SYR.familiarBuff]
	-- Loop through familiars
	for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
		local fData = familiar:GetData()
		familiar = familiar:ToFamiliar()
		-- Check if the familiar is from the current player
		if GetPtrHash(familiar.Player) == GetPtrHash(player) then
			-- If there is a saved level for the familiar
			if sData.familiarsLevels[GetPtrHash(familiar)] then
				-- Set the level of the familiar depending on the saved one
				fData.Sewn_upgradeState = sData.familiarsLevels[GetPtrHash(familiar)]
				
				-- Upgrade the familiar
				sewingMachineMod:resetFamiliarData(familiar, {"Sewn_upgradeState_temporary"})
				sewingMachineMod:callFamiliarUpgrade(familiar)
			end
		end
	end
end
sewnSyringes:addSyringe(
	M_SYR.TOT_SYR.familiarBuff,
	M_SYR.TYPES.Positive,
	"Familiar Buff",
	"Upgrade familiars", 
	"Upgrade your familiar from Normal to Super or Super to Ultra",
	45 * 30,
	nil,
	1.1,
	{},
	sewnSyringes.familiarsBuff_onUse,
	sewnSyringes.familiarsBuff_post,
	{familiarsLevels = {}}
)

sewingMachineMod.errFamiliars.Error()