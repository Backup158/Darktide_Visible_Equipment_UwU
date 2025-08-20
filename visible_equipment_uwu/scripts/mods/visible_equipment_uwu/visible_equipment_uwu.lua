local mod = get_mod("visible_equipment_uwu")
mod.version = "1.0.0"

-- ####################
-- UTILITY/SETUP
-- ####################
-- Requirements
local WeaponTemplates = require("scripts/settings/equipment/weapon_templates/weapon_templates")

-- Performance
local vector3_box = Vector3Box

-- Offsets for the base mod to read
--  This must be created BEFORE all mods are loaded
--  Since that's when the base mod looks for this
mod.visible_equipment_plugin = {
    offsets = {
        
    },
    placements = {
        
    },
    placement_camera = {
        
    },
}

-- ####################
-- MY OFFSETS
-- ####################
-- ----------
-- Looping through every weapon for offsets
--      Using a generic, default value
--      Will overwrite below if needed
-- ----------
for weapon_id, _ in pairs(WeaponTemplates) do
	mod.visible_equipment_plugin.offsets[weapon_id] = {
        butt = {
            right = {
                node = "j_hips",
                position = vector3_box(0.005, -0.05, -0.069),
                rotation = vector3_box(-5, 0, 90),
            },
        },
        butt_flip = {
            right = {
                node = "j_hips",
                position = vector3_box(0.007, -0.05, 0.069),
                rotation = vector3_box(170, 0, 90),
            },
        },
    }
end

-- ----------
-- Setting base node for placement and camera preview
--      Only done once for each slot I add
-- ----------
mod.visible_equipment_plugin.placements["butt"] = "hip_back"
mod.visible_equipment_plugin.placements["butt_flip"] = "hip_back"
mod.visible_equipment_plugin.placement_camera["butt"] = {
    position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
    rotation = 3.5,
}
mod.visible_equipment_plugin.placement_camera["butt_flip"] = {
    position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
    rotation = 3.5,
}

-- ----------
-- Manual Overrides
-- ----------
mod.visible_equipment_plugin.offsets.powersword_p1_m2["butt_flip"] = {
    right = {
        node = "j_hips",
        position = vector3_box(0.007, 0.0, -0.0),
        rotation = vector3_box(140, 0, 0),
    },
}

-- ####################
-- HOOKS
-- ####################
function mod.on_all_mods_loaded()
    mod:info("v"..mod.version.." loaded uwu nya :3")

    local visible_equipment = get_mod("visible_equipment")
    if not visible_equipment then
        mod:error("Visible Equipment mod required! The standalone mod, not Extended Weapon Customization")
    end
end