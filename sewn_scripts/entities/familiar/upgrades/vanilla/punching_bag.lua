local CColor = require("sewn_scripts.helpers.ccolor")
local Globals = require("sewn_scripts.core.globals")
local Enums = require("sewn_scripts.core.enums")
local ShootTearsCircular = require("sewn_scripts.helpers.shoot_tears_circular")
local FindCloserNpc = require("sewn_scripts.helpers.find_closer_npc")

local PunchingBag = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.PUNCHING_BAG, CollectibleType.COLLECTIBLE_PUNCHING_BAG)

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.PUNCHING_BAG,
--     "Gains random champion forms each with special abilities, such as:#"..
--     "{{ColorPink}}Pink{{CR}}: Fires a tear in a random direction#"..
--     "{{ColorPurple}}Violet{{CR}}: Pulls enemies and bullets#"..
--     "{{ColorCyan}}Light Blue{{CR}}: Fires tears in 8 directions when player gets hit#"..
--     "{{ColorCyan}}Blue{{CR}}: Spawns 2-3 flies when player gets hit#"..
--     "{{ColorOrange}}Orange{{CR}}: Spawns a coin when player get hit#"..
--     "Blocks bullets",
--     "Gain more powerful champion forms:#"..
--     "{{ColorGreen}}Green{{CR}}: Spawns green creep#"..
--     "{{ColorBlack}}Black{{CR}}: Explodes when the player gets hit. Explosion deal 40 damage#"..
--     "{{ColorRainbow}}Rainbow{{CR}}: Copies the effect of every other champion forms. Lasts less time than other champion forms#"..
--     "Deals contact damage", nil, "Punching Bag"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.PUNCHING_BAG,
    "像敌人一样具有精英形态，每隔一段时间随机改变颜色，可阻挡弹幕 {{Blank}}粉色：向随机方向发射眼泪 {{Blank}}紫色：将敌人和弹幕牵引到自身 {{Blank}}淡蓝色：玩家受伤时发射 8 向弹幕 {{Blank}}蓝色：玩家受伤时生成 2-3 只蓝蜘蛛 {{Blank}}橙色：玩家受伤时掉落一枚硬币 #可阻挡弹幕",
    "具有更多的精英形态： {{Blank}}绿色：移动路径生成绿色水迹造成伤害 {{Blank}}黑色：玩家受伤时爆炸，造成40点伤害 {{Blank}}彩虹色：具有以上所有形态的能力，但持续时间比上述形态都短 #可造成接触伤害", nil, "受气包","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.PUNCHING_BAG,
    "Получает случайную форму чемпиона, каждая со своими особенностями:#{{ColorPink}}Розовый{{CR}}: Стреляет слезой в случайном направлении#{{ColorPurple}}Фиолетовый{{CR}}: Всасывает врагов и вражеские снаряды#{{ColorCyan}}Голубой{{CR}}: Стреляет 8 слезами во всех направлениях когда игрок получает урон#{{ColorBlue}}Синий{{CR}}: Спавнит 2-3 синие мухи когда игрок получает урон#{{ColorOrange}}Оранжевый{{CR}}: Спавнит монетку когда игрок получает урон#Блокирует вражеские снаряды",
    "Получает более сильные версии чемпиона:#{{ColorGreen}}Зелёный{{CR}}: Оставляет зелёные лужи#{{ColorBlack}}Black{{CR}}: Взрывается когда игрок получает урон. Взрыв наносит 40 урона#{{ColorRainbow}}Радужный{{CR}}: Копирует эффект каждой формы чемпиона. Пропадает быстрее чем другие формы#Наносит контактный урон", nil, "Терпила", "ru"
)
-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.PUNCHING_BAG,
--     "Obtient différentes formes d'élite#"..
--     "{{ColorPink}}Rose{{CR}}: Tire une larme dans une direction aléatoire#"..
--     "{{ColorPurple}}Violet{{CR}}: Attire les ennemis et les projectiles#"..
--     "{{ColorCyan}}Bleu Clair{{CR}}: Tire 8 larmes en cercles quand Isaac subit des dégâts#"..
--     "{{ColorCyan}}Bleu{{CR}}: Invoque 2-3 mouches bleues quand Isaac subit des dégâts#"..
--     "{{ColorOrange}}Orange{{CR}}: Fait apparaître 1 pièce quand Isaac subit des dégâts#"..
--     "Bloque les projectiles",
--     "Obtient de puissantes formes d'élite :#"..
--     "{{ColorGreen}}Vert{{CR}}: Répand une trainée de liquide vert#"..
--     "{{ColorBlack}}Noir{{CR}}: Provoque une explosion qui inflige 40 dégâts quand Isaac subit des dégâts#"..
--     "{{ColorRainbow}}Arc-en-Ciel{{CR}}: Regroupe les effets des autres élites. Dure moins longtemps que les autres formes#"..
--     "Inflige des dégâts de contact", nil, "Théodule", "fr"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.PUNCHING_BAG,
    "Gana formas champion aleatorias con cada abilidad especial#Rosa : Dispara una lágrima en una dirección aleatoria#Violeta : Empuja enemigos y lágrimas#Azul Claro : Dispara lágrimas en 8 direcciones cuando hacen daño al jugador#Azul : Spawnea entre 2 y 3 moscas azules cuando el jugador se hace daño#Naranja: Spawnea una moneda cuando el jugador se hace daño#Bloquea lágrimas",
    "Gana formas champion más poderosas :#Verde : Spawnea creep verde#Negro : Explota cuando el jugador recibe daño. La explosión hace 40 de daño#Arcoíris : Copia los efectos de todas las otras formas champion. Dura menos tieme que las otras formas#Hace daño por contacto", nil, "Saco de Boxeo", "spa"
)

local function FireTear(familiar, direction, force, damage, scale)
    scale = scale or 1
    force = force or 5
    damage = damage or 3.5
    direction = direction or Vector(1, 1):Rotated(math.random() * 360):Normalized()
    local velocity = direction * force
    local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, familiar.Position, velocity, familiar):ToTear()
    tear.Scale = tear.Scale * scale
    tear.CollisionDamage = damage
    --sewnFamiliars:toBabyBenderTear(punchingBag, tear)
end

local function RemovePullingEffects()
    local pullingEffects = Isaac.FindByType(EntityType.ENTITY_EFFECT, Enums.EffectVariant.PUNCHING_BAG_PULLING_EFFECT, -1, false, false)
    for _, pullingEffect in ipairs(pullingEffects) do
        pullingEffect:Remove()
    end
end

local championForms = {
    STRONG_LIME_GREEN = 1,
    PURE_MAGENTA = 2,
    MOSTLY_PURE_VIOLET = 3,
    VERY_LIGHT_BLUE = 4,
    VIVID_BLUE = 5,
    DARK_CYAN = 6,
    ORANGE = 7,
    RAINBOW = 8,
    NUM_CHAMPION = 9
}

local championEffects = { }
championEffects[championForms.STRONG_LIME_GREEN] = {
    Color = CColor(0.1, 0.8, 0.2),
    Stats = {
        CreepTimeout = 75,
        CreepDamage = 0.07,
        CreepSpawnRate = 15,
    },
    Update = function (_, this, familiar)
        if familiar.FrameCount % this.Stats.CreepSpawnRate == 0 then
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, familiar.Position, Globals.V0, familiar):ToEffect()
            creep.Timeout = this.Stats.CreepTimeout
            creep.CollisionDamage = this.Stats.CreepDamage
        end
    end
}
championEffects[championForms.PURE_MAGENTA] = {
    Color = CColor(1, 0, 1),
    Stats = {
        TearForce = 4,
        TearScale = 1.1,
        TearDamage = 8,
        TearCooldownMax = 160,
        TearCooldownMin = 80,
    },
    Init = function (_, this, familiar)
        local fData = familiar:GetData()
        fData.Sewn_punchingBag_magenta_tearCooldown = 0
    end,
    Update = function (_, this, familiar)
        local fData = familiar:GetData()
        if fData.Sewn_punchingBag_magenta_tearCooldown == 0 then
            local closerNpc = FindCloserNpc(familiar.Position)
            if closerNpc == nil then
                FireTear(familiar, nil, this.Stats.TearForce, this.Stats.TearDamage, this.Stats.TearScale)
            else
                FireTear(familiar, (closerNpc.Position - familiar.Position):Normalized(), this.Stats.TearForce, this.Stats.TearDamage, this.Stats.TearScale)
            end
            fData.Sewn_punchingBag_magenta_tearCooldown = familiar:GetDropRNG():RandomInt( this.Stats.TearCooldownMax - this.Stats.TearCooldownMin ) + this.Stats.TearCooldownMin
        elseif fData.Sewn_punchingBag_magenta_tearCooldown > 0 then
            fData.Sewn_punchingBag_magenta_tearCooldown = fData.Sewn_punchingBag_magenta_tearCooldown - 1
        end
    end
}
championEffects[championForms.MOSTLY_PURE_VIOLET] = {
    Color = CColor(0.75, 0, 1),
    Update = function (_, this, familiar)
        local fData = familiar:GetData()
        if fData.Sewn_punchingBag_mostlyPureViolet_pullEffect == nil or fData.Sewn_punchingBag_mostlyPureViolet_pullEffect:Exists() == false then
            fData.Sewn_punchingBag_mostlyPureViolet_pullEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, Enums.EffectVariant.PUNCHING_BAG_PULLING_EFFECT, 0, familiar.Position, familiar.Velocity, familiar)
        end
        fData.Sewn_punchingBag_mostlyPureViolet_pullEffect.Position = familiar.Position
        fData.Sewn_punchingBag_mostlyPureViolet_pullEffect.Velocity = familiar.Velocity
    end,
    OnChange = function (_, this, familiar)
        RemovePullingEffects()
    end
}
championEffects[championForms.VERY_LIGHT_BLUE] = {
    Color = CColor(0.5, 0.5, 1),
    PlayerTakeDamage = function (_, this, familiar, player)
        ShootTearsCircular(familiar, 8, nil, nil, nil, 5)
    end
}
championEffects[championForms.VIVID_BLUE] = {
    Color = CColor(0.2, 0.2, 1),
    PlayerTakeDamage = function (_, this, familiar, player)
        player:AddBlueFlies(familiar:GetDropRNG():RandomInt(3)+1, familiar.Position, nil)
    end
}
championEffects[championForms.DARK_CYAN] = {
    Color = CColor(0.03, 0.24, 0.24),
    PlayerTakeDamage = function (_, this, familiar, player)
        Isaac.Explode(familiar.Position, player, 40)
    end
}
championEffects[championForms.ORANGE] = {
    Color = CColor(1, 0.6, 0.2),
    PlayerTakeDamage = function (_, this, familiar, player)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, familiar.Position, Globals.V0, familiar)
    end
}
championEffects[championForms.RAINBOW] = {
    Stats = {
        DurationMultiplier = 0.5
    },
    Init = function (_, this, familiar)
        local fData = familiar:GetData()
        championEffects[championForms.PURE_MAGENTA]:Init(championEffects[championForms.PURE_MAGENTA], familiar)

        fData.Sewn_punchingBag_championCooldown = fData.Sewn_punchingBag_championCooldown * this.Stats.DurationMultiplier

        local randomColor = CColor(math.random(), math.random(), math.random(), 1)
        familiar:SetColor(randomColor, -1, 2, false, false)
    end,
    OnChange = function (_, this, familiar)
        championEffects[championForms.MOSTLY_PURE_VIOLET]:OnChange(championEffects[championForms.MOSTLY_PURE_VIOLET], familiar)
    end,
    Update = function (_, this, familiar)
        championEffects[championForms.STRONG_LIME_GREEN]:Update(championEffects[championForms.STRONG_LIME_GREEN], familiar)
        championEffects[championForms.PURE_MAGENTA]:Update(championEffects[championForms.PURE_MAGENTA], familiar)
        championEffects[championForms.MOSTLY_PURE_VIOLET]:Update(championEffects[championForms.MOSTLY_PURE_VIOLET], familiar)

        local color = familiar:GetColor()
        local r = color.R - 0.1 > 0 and color.R - math.random() * 0.1 or 1
        local g = color.G - 0.1 > 0 and color.G - math.random() * 0.1 or 1
        local b = color.B - 0.1 > 0 and color.B - math.random() * 0.1 or 1
        familiar:SetColor(CColor(r, g, b), -1, 2, false, false)
    end,
    PlayerTakeDamage = function (_, this, familiar, player)
        championEffects[championForms.VERY_LIGHT_BLUE]:PlayerTakeDamage(championEffects[championForms.VERY_LIGHT_BLUE], familiar, player)
        championEffects[championForms.VIVID_BLUE]:PlayerTakeDamage(championEffects[championForms.VIVID_BLUE], familiar, player)
        championEffects[championForms.DARK_CYAN]:PlayerTakeDamage(championEffects[championForms.DARK_CYAN], familiar, player)
        championEffects[championForms.ORANGE]:PlayerTakeDamage(championEffects[championForms.ORANGE], familiar, player)
    end
}

PunchingBag.Stats = {
    ChampionTimeoutMin = 5 * 30,
    ChampionTimeoutMax = 15 * 30,
    AvailableChampions = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = { championForms.PURE_MAGENTA, championForms.MOSTLY_PURE_VIOLET, championForms.VERY_LIGHT_BLUE, championForms.VIVID_BLUE, championForms.ORANGE },
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = { championForms.STRONG_LIME_GREEN, championForms.PURE_MAGENTA, championForms.MOSTLY_PURE_VIOLET, championForms.VERY_LIGHT_BLUE, championForms.VIVID_BLUE, championForms.DARK_CYAN, championForms.ORANGE, championForms.RAINBOW,  }
    },
    CollisionDamage = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 0.7,
    }
}

local function ResetColor(familiar)
    familiar:SetColor(CColor(1, 1, 1, 1), -1, 2, false, false)
end

local function ChangeColor(familiar)
    local fData = familiar:GetData()
    
    if fData.Sewn_punchingBag_champion ~= nil then
        local currentChampion = championEffects[fData.Sewn_punchingBag_champion]

        if currentChampion.OnChange ~= nil then
            currentChampion:OnChange(currentChampion, familiar)
        end
    end

    local level = Sewn_API:GetLevel(fData)

    local rollChampion = familiar:GetDropRNG():RandomInt( #PunchingBag.Stats.AvailableChampions[level] ) + 1
    fData.Sewn_punchingBag_champion = PunchingBag.Stats.AvailableChampions[level][rollChampion]

    local choosenChampion = championEffects[fData.Sewn_punchingBag_champion]

    if choosenChampion.Color ~= nil then
        familiar:SetColor(choosenChampion.Color, -1, 2, false, false)
    end

    if choosenChampion.Init ~= nil then
        choosenChampion:Init(choosenChampion, familiar)
    end
    
    fData.Sewn_punchingBag_championCooldown = familiar:GetDropRNG():RandomInt( PunchingBag.Stats.ChampionTimeoutMax - PunchingBag.Stats.ChampionTimeoutMin ) + PunchingBag.Stats.ChampionTimeoutMin
end

function PunchingBag:OnFamiliarUpgraded(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    fData.Sewn_punchingBag_championCooldown = 0
    ChangeColor(familiar)
    familiar.CollisionDamage = PunchingBag.Stats.CollisionDamage[Sewn_API:GetLevel(fData)]
end
function PunchingBag:OnFamiliarLoseUpgrade(familiar, losePermanentUpgrade)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if level == Sewn_API.Enums.FamiliarLevel.NORMAL then
        ResetColor(familiar)
        RemovePullingEffects()
    end
    familiar.CollisionDamage = 0
end
function PunchingBag:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_punchingBag_champion == nil then
        ChangeColor(familiar)
        return
    end

    local currentChampion = championEffects[fData.Sewn_punchingBag_champion]
    if currentChampion.Update ~= nil then
        currentChampion:Update(currentChampion, familiar)
    end

    -- Remove bullets
    local bullets = Isaac.FindInRadius(familiar.Position, familiar.Size, EntityPartition.BULLET)
    for _, bullet in ipairs(bullets) do
        bullet:Die()
    end

    if fData.Sewn_punchingBag_championCooldown == 0 then
        ChangeColor(familiar)
    elseif fData.Sewn_punchingBag_championCooldown > 0 then
        fData.Sewn_punchingBag_championCooldown = fData.Sewn_punchingBag_championCooldown - 1
    end
end
function PunchingBag:PlayerTakeDamage(familiar, player, flags, source)
    local fData = familiar:GetData()

    local currentChampion = championEffects[fData.Sewn_punchingBag_champion]
    if currentChampion.PlayerTakeDamage ~= nil then
        currentChampion:PlayerTakeDamage(currentChampion, familiar, player)
    end
end
function PunchingBag:AddToMachine(familiar, machine)
    RemovePullingEffects()
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, PunchingBag.OnFamiliarUpgraded, FamiliarVariant.PUNCHING_BAG)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE, PunchingBag.OnFamiliarLoseUpgrade, FamiliarVariant.PUNCHING_BAG)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, PunchingBag.OnFamiliarUpdate, FamiliarVariant.PUNCHING_BAG)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_PLAYER_TAKE_DAMAGE, PunchingBag.PlayerTakeDamage, FamiliarVariant.PUNCHING_BAG)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE, PunchingBag.AddToMachine, FamiliarVariant.PUNCHING_BAG)