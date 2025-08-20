return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`visible_equipment_uwu` encountered an error loading the Darktide Mod Framework.")

		new_mod("visible_equipment_uwu", {
			mod_script       = "visible_equipment_uwu/scripts/mods/visible_equipment_uwu/visible_equipment_uwu",
			mod_data         = "visible_equipment_uwu/scripts/mods/visible_equipment_uwu/visible_equipment_uwu_data",
			mod_localization = "visible_equipment_uwu/scripts/mods/visible_equipment_uwu/visible_equipment_uwu_localization",
		})
	end,
	packages = {},
}
