sewingMachineMod.sewnSyringes = {}
sewnSyringes = sewingMachineMod.sewnSyringes

M_SYR.TOT_SYR.familiarBuff = M_SYR.GetSyringeIdByName("Familiar Buff")
M_SYR.TOT_SYR.lonerEssence = M_SYR.GetSyringeIdByName("Loner Essence")


sewnSyringes.data = {}

function sewnSyringes:addSyringe(id, type, name, description, EIDDescription, duration, counterpart, weight, effect, onuse, post)
	M_SYR.EFF_TAB[id] = {
		ID = id,
		Type = type,
		Name = name,
		Description = description,
		EIDDescription = EIDDescription,
		Duration = duration,
		Counterpart = counterpart;
		Weight = weight,
		Effect = effect,
		OnUse = onuse,
		Post = post
	}
end

function sewnSyringes:goodSyringeOnUse()
	local player = M_SYR.GetPlayerUsingActive()
	player:AnimateSad()
	Sfx:Play(SoundEffect.SOUND_THUMBS_DOWN, 1, 0, false, 1)
end
function sewnSyringes:badSyringeOnUse()
	local player = M_SYR.GetPlayerUsingActive()
	player:AnimateSad()
	Sfx:Play(SoundEffect.SOUND_THUMBS_DOWN, 1, 0, false, 1)
end

function sewnSyringes:loopThroughFamiliars(_function)
	local player = M_SYR.GetPlayerUsingActive()
	-- Loop through familiars
	for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
		familiar = familiar:ToFamiliar()
		-- Check if the familiar is from the current player
		if sewingMachineMod.availableFamiliar[familiar.Variant] ~= nil and GetPtrHash(familiar.Player) == GetPtrHash(player) then
			_function(familiar)
		end
	end
end

--------------------
-- FAMILIARS BUFF --
--------------------
function sewnSyringes.familiarsBuff_onUse(idx)
	sewnSyringes:loopThroughFamiliars(function(familiar)	
		sewingMachineMod:temporaryUpgradeFamiliar(familiar)
	end)
	sewnSyringes:goodSyringeOnUse()
end
function sewnSyringes.familiarsBuff_post(player)
	sewnSyringes:loopThroughFamiliars(function(familiar)
		sewingMachineMod:resetFamiliarData(familiar)
		sewingMachineMod:callFamiliarUpgrade(familiar)
	end)
end
sewnSyringes:addSyringe(
	M_SYR.TOT_SYR.familiarBuff,
	M_SYR.TYPES.Positive,
	"Familiar Buff",
	"Upgrade familiars", 
	"Upgrade your familiar from Normal to Super or Super to Ultra",
	45 * 30,
	M_SYR.TOT_SYR.lonerEssence,
	1.1,
	nil,
	sewnSyringes.familiarsBuff_onUse,
	sewnSyringes.familiarsBuff_post
)

-------------------
-- LONER ESSENCE --
-------------------
function sewnSyringes.lonerEssence_onUse(idx)
	sewnSyringes:loopThroughFamiliars(function(familiar)
		local fData = familiar:GetData()
		sewingMachineMod:resetFamiliarData(familiar, {"Sewn_upgradeState_temporary"})
        fData.Sewn_upgradeState_temporary = 0
        sewingMachineMod:callFamiliarUpgrade(familiar)
	end)
	sewnSyringes:badSyringeOnUse()
end
function sewnSyringes.lonerEssence_post(player)
	sewnSyringes:loopThroughFamiliars(function(familiar)
		sewingMachineMod:resetFamiliarData(familiar)
		sewingMachineMod:callFamiliarUpgrade(familiar)
	end)
end
sewnSyringes:addSyringe(
	M_SYR.TOT_SYR.lonerEssence,
	M_SYR.TYPES.Negative,
	"Loner Essence",
	"Crownless familiars", 
	"Familiars lose their crowns and their abilities",
	60 * 30,
	M_SYR.TOT_SYR.familiarBuff,
	1.1,
	nil,
	sewnSyringes.lonerEssence_onUse,
	sewnSyringes.lonerEssence_post
)

sewingMachineMod.errFamiliars.Error()