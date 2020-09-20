sewingMachineMod.CONFIG_CONSTANT = {}
sewingMachineMod.CONFIG_CONSTANT.EID = {
    AUTO = 1,
    ENABLED = 2,
    DISABLED = 3
}
sewingMachineMod.CONFIG_CONSTANT.ALLOWED_FAMILIARS_EFFECT = {
    NONE = 1,
    BLINK = 2
}
sewingMachineMod.CONFIG_CONSTANT.NOT_ALLOWED_FAMILIARS_EFFECT = {
    NONE = 1,
    TRANSPARENT = 2
}
sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_CROWN_POSITION = {
    CENTER = 1,
    RIGHT = 2
}
sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_NON_READY_INDICATOR = {
    NONE = 1,
    ANIMATED = 2,
    STATIC = 3
}

local CONFIG = sewingMachineMod.CONFIG_CONSTANT

sewingMachineMod.Config = {
	familiarCrownPosition = CONFIG.FAMILIAR_CROWN_POSITION.CENTER,
	familiarNonReadyIndicator = CONFIG.FAMILIAR_NON_READY_INDICATOR.ANIMATED,
	familiarAllowedEffect = CONFIG.ALLOWED_FAMILIARS_EFFECT.NONE,
	familiarNotAllowedEffect = CONFIG.NOT_ALLOWED_FAMILIARS_EFFECT.TRANSPARENT,
	EID_enable = CONFIG.EID.AUTO,
	EID_textSize = 0.5,
	EID_textColored = true,
	EID_textTransparency = 0.8,
    EID_hideCurseOfBlind = true,
	TrueCoop_removeMachine = false,
	TrueCoop_displayText = true
}

if ModConfigMenu ~= nil then

	local function AnIndexOf(t,val)
		for k,v in ipairs(t) do 
			if v == val then return k end
		end
		return 1
	end
    
    -------------
    -- GENERAL --
    -------------
    
    ModConfigMenu.AddTitle("Sewing Machine", "General : ")
	ModConfigMenu.AddSpace("Sewing Machine")
    

    -- Familiar's crown position
    local familiars_crown_pos = {1,2}
    ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.NUMBER,
		CurrentSetting = function()
			return AnIndexOf(familiars_crown_pos, sewingMachineMod.Config.familiarCrownPosition)
		end,
		Minimum = 1,
		Maximum = #familiars_crown_pos,
		Display = function()
            local pos
            if AnIndexOf(familiars_crown_pos, sewingMachineMod.Config.familiarCrownPosition) == CONFIG.FAMILIAR_CROWN_POSITION.CENTER then
                pos = "Center"
            elseif AnIndexOf(familiars_crown_pos, sewingMachineMod.Config.familiarCrownPosition) == CONFIG.FAMILIAR_CROWN_POSITION.RIGHT then
                pos = "Right"
            end
			return "Crown position : " .. pos
		end,
		OnChange = function(num)
			sewingMachineMod.Config.familiarCrownPosition = familiars_crown_pos[num]
		end,
		Info = {
			"Set the position of the crown"
		}
	})

    -- Non-Ready indicators
    local familiars_non_ready_indicator = {1,2,3}
    ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.NUMBER,
		CurrentSetting = function()
			return AnIndexOf(familiars_non_ready_indicator, sewingMachineMod.Config.familiarNonReadyIndicator)
		end,
		Minimum = 1,
		Maximum = #familiars_non_ready_indicator,
		Display = function()
            local indicator
            if AnIndexOf(familiars_non_ready_indicator, sewingMachineMod.Config.familiarNonReadyIndicator) == CONFIG.FAMILIAR_NON_READY_INDICATOR.NONE then
                indicator = "None"
            elseif AnIndexOf(familiars_non_ready_indicator, sewingMachineMod.Config.familiarNonReadyIndicator) == CONFIG.FAMILIAR_NON_READY_INDICATOR.ANIMATED then
                indicator = "Animated"
            elseif AnIndexOf(familiars_non_ready_indicator, sewingMachineMod.Config.familiarNonReadyIndicator) == CONFIG.FAMILIAR_NON_READY_INDICATOR.STATIC then
                indicator = "Static"
            end
			return "Non-ready familiars indicator : " .. indicator
		end,
		OnChange = function(num)
			sewingMachineMod.Config.familiarNonReadyIndicator = familiars_non_ready_indicator[num]
		end,
		Info = {
			"Set indicators for non-ready familiars",
            "NB : Familiars have to visit a room and be 10s old"
		}
	})
    

    -- Allowed Familiar Effect
    local allowed_familiars_effect = {1,2}
    ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.NUMBER,
		CurrentSetting = function()
			return AnIndexOf(allowed_familiars_effect, sewingMachineMod.Config.familiarAllowedEffect)
		end,
		Minimum = 1,
		Maximum = #allowed_familiars_effect,
		Display = function()
            local effect
            if AnIndexOf(allowed_familiars_effect, sewingMachineMod.Config.familiarAllowedEffect) == CONFIG.ALLOWED_FAMILIARS_EFFECT.NONE then
                effect = "None"
            elseif AnIndexOf(allowed_familiars_effect, sewingMachineMod.Config.familiarAllowedEffect) == CONFIG.ALLOWED_FAMILIARS_EFFECT.BLINK then
                effect = "Blink"
            end
			return "Available familiar effect : " .. effect
		end,
		OnChange = function(num)
			sewingMachineMod.Config.familiarAllowedEffect = allowed_familiars_effect[num]
		end,
		Info = {
			"Set the effect of all familiars which can be upgraded",
			"The effect will be visible when the player is next to a machine"
		}
	})

    -- Not Allowed Familiar Effect
    local not_allowed_familiars_effect = {1,2}
    ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.NUMBER,
		CurrentSetting = function()
			return AnIndexOf(not_allowed_familiars_effect, sewingMachineMod.Config.familiarNotAllowedEffect)
		end,
		Minimum = 1,
		Maximum = #not_allowed_familiars_effect,
		Display = function()
            local effect
            if AnIndexOf(not_allowed_familiars_effect, sewingMachineMod.Config.familiarNotAllowedEffect) == CONFIG.ALLOWED_FAMILIARS_EFFECT.NONE then
                effect = "None"
            elseif AnIndexOf(not_allowed_familiars_effect, sewingMachineMod.Config.familiarNotAllowedEffect) == CONFIG.ALLOWED_FAMILIARS_EFFECT.BLINK then
                effect = "Transparent"
            end
			return "Unavailable familiar effect : " .. effect
		end,
		OnChange = function(num)
			sewingMachineMod.Config.familiarNotAllowedEffect = not_allowed_familiars_effect[num]
		end,
		Info = {
			"Set the effect of all familiars which can't be upgraded",
			"The effect will be visible when the player is next to a machine"
		}
	})

    -----------------------
    -- EID COMPATIBILITY --
    -----------------------
    
	ModConfigMenu.AddSpace("Sewing Machine")
    ModConfigMenu.AddTitle("Sewing Machine", "External Item Description :")
	ModConfigMenu.AddSpace("Sewing Machine")
    
    -- EID ENABLE
    local eid_enable = {1,2,3}
    ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.NUMBER,
		CurrentSetting = function()
			return AnIndexOf(eid_enable, sewingMachineMod.Config.EID_enable)
		end,
		Minimum = 1,
		Maximum = #eid_enable,
		Display = function()
            local state = "Auto"
            if AnIndexOf(eid_enable, sewingMachineMod.Config.EID_enable) == CONFIG.EID.ENABLED then
                state = "Enabled"
            elseif AnIndexOf(eid_enable, sewingMachineMod.Config.EID_enable) == CONFIG.EID.DISABLED then
                state = "Disabled"
            end
			return "EID for Sewing Machines : " .. state
		end,
		OnChange = function(num)
			sewingMachineMod.Config.EID_enable = eid_enable[num]
		end,
		Info = {
			"Enable or disable the External Description",
			"\"Auto\" will display the description if the mod EID is enabled"
		}
	})

    -- TEXT SIZE
    local textSizes = {0.45,0.5,0.55,0.6,0.65,0.7}
	ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.NUMBER,
		CurrentSetting = function()
			return AnIndexOf(textSizes, sewingMachineMod.Config.EID_textSize)
		end,
		Minimum = 1,
		Maximum = #textSizes,
		Display = function()
            local textSize = "Huge !"
            if sewingMachineMod.Config.EID_textSize == textSizes[1] then
                textSize = "Very Small"
            elseif sewingMachineMod.Config.EID_textSize == textSizes[2] then
                textSize = "Small"
            elseif sewingMachineMod.Config.EID_textSize == textSizes[3] then
                textSize = "Normal"
            elseif sewingMachineMod.Config.EID_textSize == textSizes[4] then
                textSize = "Large"
            elseif sewingMachineMod.Config.EID_textSize == textSizes[5] then
                textSize = "Very Large"
            end
            return "Text size : " .. textSize
		end,
		OnChange = function(num)
			sewingMachineMod.Config.EID_textSize = textSizes[num]
            -- Change the text size
            sewingMachineMod.descriptionValues.TEXT_SCALE = textSizes[num]
            -- Change the crown size
            sewingMachineMod.descriptionValues.crown.Scale = Vector(textSizes[num], textSizes[num])
sewingMachineMod.descriptionValues.crown:LoadGraphics()
		end,
		Info = {
			"Size of the EID text"
		}
	})

    -- TEXT COLOR
    ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.BOOLEAN,
		CurrentSetting = function()
			return sewingMachineMod.Config.EID_textColored
		end,
		Display = function()
            onOff = "No"
			if sewingMachineMod.Config.EID_textColored then
				onOff =  "Yes"
            end
			return "Use custom text color : " .. onOff
		end,
		OnChange = function(IsOn)
			sewingMachineMod.Config.EID_textColored = IsOn
            sewingMachineMod:InitFamiliarDescription()
		end,
		Info = {
			"Use a custom color for the text",
            "depending on the familiar color"
		}
	})

    -- TEXT TRANSPARENCY
    local transparencies = {0.25,0.3,0.4,0.5,0.6,0.75,0.8,0.9,1}
	ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.NUMBER,
		CurrentSetting = function()
			return AnIndexOf(transparencies, sewingMachineMod.Config.EID_textTransparency)
		end,
		Minimum = 1,
		Maximum = #transparencies,
		Display = function()
            return "Transparency: " .. sewingMachineMod.Config.EID_textTransparency
		end,
		OnChange = function(num)
            sewingMachineMod.Config.EID_textTransparency = transparencies[num]
		end,
		Info = {
			"Transparency of the EID text"
		}
	})

    -- HIDE ON CURSE OF THE BLIND
    ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.BOOLEAN,
		CurrentSetting = function()
			return sewingMachineMod.Config.EID_hideCurseOfBlind
		end,
		Display = function()
            onOff = "No"
			if sewingMachineMod.Config.EID_hideCurseOfBlind then
				onOff =  "Yes"
            end
			return "Hide on \"Curse of the Blind\" : " .. onOff
		end,
		OnChange = function(IsOn)
			sewingMachineMod.Config.EID_hideCurseOfBlind = IsOn
		end,
		Info = {
			"Hide description if there is the \"Curse of the Blind\""
		}
	})


    -----------------------------
    -- TRUE-COOP COMPATIBILITY --
    -----------------------------
    
	ModConfigMenu.AddSpace("Sewing Machine")
    ModConfigMenu.AddTitle("Sewing Machine", "True-Coop :")
    
	ModConfigMenu.AddSpace("Sewing Machine")
	ModConfigMenu.AddText("Sewing Machine", "Sewing machines are NOT")
	ModConfigMenu.AddText("Sewing Machine", "compatible with True-Coop")
	ModConfigMenu.AddSpace("Sewing Machine")
    
    ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.BOOLEAN,
		CurrentSetting = function()
			return sewingMachineMod.Config.TrueCoop_removeMachine
		end,
		Display = function()
            onOff = "No"
			if sewingMachineMod.Config.TrueCoop_removeMachine then
				onOff =  "Yes"
            end
			return "Remove machine with True-Coop : " .. onOff
		end,
		OnChange = function(IsOn)
			sewingMachineMod.Config.TrueCoop_removeMachine = IsOn
		end,
		Info = {
			"As the machine does nothing with True-Coop",
            "you can choose to remove them or not"
		}
	})
    
    ModConfigMenu.AddSetting("Sewing Machine", {
		Type = ModConfigMenuOptionType.BOOLEAN,
		CurrentSetting = function()
			return sewingMachineMod.Config.TrueCoop_displayText
		end,
		Display = function()
            onOff = "No"
			if sewingMachineMod.Config.TrueCoop_displayText then
				onOff =  "Yes"
            end
			return "Display warning text : " .. onOff
		end,
		OnChange = function(IsOn)
			sewingMachineMod.Config.TrueCoop_displayText = IsOn
		end,
		Info = {
			"A warning indicates True-Coop is not compatible.",
            "Display this message ?"
		}
	})
    
end

sewingMachineMod.errFamiliars.Error()