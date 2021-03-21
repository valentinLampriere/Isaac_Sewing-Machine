sewingMachineMod.CONFIG_CONSTANT = {}
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
sewingMachineMod.CONFIG_CONSTANT.EID_INDICATE_FAMILIAR_UPGRADABLE = {
    NONE = 1,
	NEW_LINE = 2,
	TOP = 3
}

local CONFIG = sewingMachineMod.CONFIG_CONSTANT



function sewingMachineMod:initMCM()
	if sewingMachineMod.Config == nil then
		sewingMachineMod.Config = {}
	end

	sewingMachineMod.Config.familiarCrownPosition = sewingMachineMod.Config.familiarCrownPosition or CONFIG.FAMILIAR_CROWN_POSITION.CENTER
	sewingMachineMod.Config.familiarNonReadyIndicator = sewingMachineMod.Config.familiarNonReadyIndicator or CONFIG.FAMILIAR_NON_READY_INDICATOR.ANIMATED
	sewingMachineMod.Config.familiarAllowedEffect = sewingMachineMod.Config.familiarAllowedEffect or CONFIG.ALLOWED_FAMILIARS_EFFECT.NONE
	sewingMachineMod.Config.familiarNotAllowedEffect = sewingMachineMod.Config.familiarNotAllowedEffect or CONFIG.NOT_ALLOWED_FAMILIARS_EFFECT.TRANSPARENT
	sewingMachineMod.Config.EID_enable = sewingMachineMod.Config.EID_enable or true
	sewingMachineMod.Config.EID_enable = sewingMachineMod.Config.EID_textColored or true
	sewingMachineMod.Config.EID_indicateFamiliarUpgradable = sewingMachineMod.Config.EID_indicateFamiliarUpgradable or CONFIG.EID_INDICATE_FAMILIAR_UPGRADABLE.NEW_LINE
	sewingMachineMod.Config.TrueCoop_removeMachine = sewingMachineMod.Config.TrueCoop_removeMachine or false
	sewingMachineMod.Config.TrueCoop_displayText = sewingMachineMod.Config.TrueCoop_displayText or true

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
			Type = ModConfigMenu.OptionType.NUMBER,
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
			Type = ModConfigMenu.OptionType.NUMBER,
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
			Type = ModConfigMenu.OptionType.NUMBER,
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
			Type = ModConfigMenu.OptionType.NUMBER,
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
		ModConfigMenu.AddSetting("Sewing Machine", {
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return sewingMachineMod.Config.EID_enable
			end,
			Display = function()
				onOff = "No"
				if sewingMachineMod.Config.EID_enable then
					onOff =  "Yes"
				end
				return "Enable EID for Sewing Machine : " .. onOff
			end,
			OnChange = function(IsOn)
				sewingMachineMod.Config.EID_enable = IsOn
				sewingMachineMod:updateMachinesDescription()
			end,
			Info = {
				"Enable EID for Sewing Machine"
			}
		})

		-- TEXT COLOR
		ModConfigMenu.AddSetting("Sewing Machine", {
			Type = ModConfigMenu.OptionType.BOOLEAN,
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
				sewingMachineMod:updateMachinesDescription()
			end,
			Info = {
				"Use a custom color for the text",
				"depending on the familiar color"
			}
		})		

		-- INDICATOR ON FAMILIAR COLLECTIBLE
		local eid_indicator_item = {1,2,3}
		ModConfigMenu.AddSetting("Sewing Machine", {
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return AnIndexOf(eid_indicator_item, sewingMachineMod.Config.EID_indicateFamiliarUpgradable)
			end,
			Minimum = 1,
			Maximum = #eid_indicator_item,
			Display = function()
				local indicator
				if AnIndexOf(eid_indicator_item, sewingMachineMod.Config.EID_indicateFamiliarUpgradable) == CONFIG.EID_INDICATE_FAMILIAR_UPGRADABLE.NONE then
					indicator = "None"
				elseif AnIndexOf(eid_indicator_item, sewingMachineMod.Config.EID_indicateFamiliarUpgradable) == CONFIG.EID_INDICATE_FAMILIAR_UPGRADABLE.NEW_LINE then
					indicator = "On a new line"
				elseif AnIndexOf(eid_indicator_item, sewingMachineMod.Config.EID_indicateFamiliarUpgradable) == CONFIG.EID_INDICATE_FAMILIAR_UPGRADABLE.TOP then
					indicator = "On top"
				end
				return "Familiar Collectible Indication : " .. indicator
			end,
			OnChange = function(num)
				sewingMachineMod.Config.EID_indicateFamiliarUpgradable = eid_indicator_item[num]
				sewingMachineMod:addEIDDescriptionForCollectible()
			end,
			Info = {
				"Add an indication in the EID Description of familiar collectible",
				"which indicates if the familiar can be upgraded.",
				"Note : Will be effective after the game has been exited."
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
			Type = ModConfigMenu.OptionType.BOOLEAN,
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
			Type = ModConfigMenu.OptionType.BOOLEAN,
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
end
sewingMachineMod:initMCM()

sewingMachineMod.errFamiliars.Error()