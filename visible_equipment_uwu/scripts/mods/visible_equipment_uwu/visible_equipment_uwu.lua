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

-- ----------
-- HOOKS
-- Defining actions for startup
-- ----------
function mod.on_all_mods_loaded()
    mod:info("v"..mod.version.." loaded uwu nya :3")

    local visible_equipment = get_mod("visible_equipment")
    if not visible_equipment then
        mod:error("Visible Equipment mod required! The standalone mod, not Extended Weapon Customization")
    end
end

-- ----------
-- Offsets for the base mod to read
--  This must be filled out BEFORE all mods are loaded
--  Because that's when the base mod reads this table
-- ----------
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

-- ########################################
-- ***** DEFAULT OFFSETS *****
-- ########################################
local default_offsets_table = {
    butt = {
        offsets = {
            right = {
                node = "j_hips",
                position = vector3_box(0.005, -0.05, -0.069),
                rotation = vector3_box(-5, 0, 90),
            },
        },
        placements = "hip_back",
        placement_camera = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 3.5,
        },
    },
    butt_flip = {
        offsets = {
            right = {
                node = "j_hips",
                position = vector3_box(0.007, -0.05, -0.069),
                rotation = vector3_box(170, 0, 90),
            },
        },
        placements = "hip_back",
        placement_camera = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 3.5,
        },
    },
}

-- ----------
-- Looping through every weapon for offsets
--      Using a generic, default value (from that table above)
--      Will overwrite below if needed
-- ----------
for weapon_id, _ in pairs(WeaponTemplates) do
    -- Initializing the weapon's table
    mod.visible_equipment_plugin.offsets[weapon_id] = {}

    -- Adds all default offsets
    for offset_slot, _ in pairs(default_offsets_table) do
        mod.visible_equipment_plugin.offsets[weapon_id][offset_slot] = default_offsets_table[offset_slot].offsets
    end
end

-- ----------
-- Setting base node for placement and camera preview
--      Only done once for each slot I add
-- ----------
for offset_slot, _ in pairs(default_offsets_table) do
    mod.visible_equipment_plugin.placements[weapon_id][offset_slot] = default_offsets_table[offset_slot].placements
    mod.visible_equipment_plugin.placement_camera[weapon_id][offset_slot] = default_offsets_table[offset_slot].placement_camera
end

-- ########################################
-- ***** OFFSETS: MANUAL OVERRIDES *****
-- ########################################
overwrite_offset_slot_for_family("powersword_p1", "butt_flip", {
    right = {
        node = "j_hips",
        position = vector3_box(0.007, 0.0, -0.0),
        rotation = vector3_box(140, 0, 0),
    },
})