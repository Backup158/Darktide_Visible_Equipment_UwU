local mod = get_mod("visible_equipment_uwu")
mod.version = "1.0.0"

-- ####################
-- UTILITY/SETUP
-- ####################
-- Requirements
local WeaponTemplates = require("scripts/settings/equipment/weapon_templates/weapon_templates")

-- Performance
local vector3_box = Vector3Box
local tostring = tostring

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

-- ----------
-- Offsets Manual Override Helper
-- DESC: Overwrites default offsets for all marks of a weapon family
-- PARAM:
--      weapon_id_without_mark; string; "powersword_p1"
--      offset_slot; string; "butt"
--      table_for_offset; table; no example because fuck you
-- ----------
local function overwrite_offset_slot_for_family(weapon_id_without_mark, offset_slot, table_for_offset)
    -- Loop over 3 marks
    --  range: [1, 3]
    for i = 1, 3 do
        local weapon_id = weapon_id_without_mark.."_m"..tostring(i)
        -- If this mark doesn't exist (doesn't have an offset already), don't try it
        if not mod.visible_equipment_plugin.offsets[weapon_id] then
            return
        end

        mod.visible_equipment_plugin.offsets[weapon_id][offset_slot] = table_for_offset
    end
end

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
overwrite_offset_slot_for_family("powersword_p1", "butt_flip", {
    right = {
        node = "j_hips",
        position = vector3_box(0.007, 0.0, -0.0),
        rotation = vector3_box(140, 0, 0),
    },
})

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