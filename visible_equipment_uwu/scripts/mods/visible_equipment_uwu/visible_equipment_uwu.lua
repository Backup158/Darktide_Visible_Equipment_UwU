local mod = get_mod("visible_equipment_uwu")
mod.version = "1.0.0"
local debug_mode = mod:get("debug_mode")

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
    
}

-- Adding in the Stupid Options
if mod:get("owo_mode") then
    default_offsets_table["butt"] = {
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
    }
    default_offsets_table["butt_flip"] = {
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
    }
end

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
    mod.visible_equipment_plugin.placements[offset_slot] = default_offsets_table[offset_slot].placements
    mod.visible_equipment_plugin.placement_camera[offset_slot] = default_offsets_table[offset_slot].placement_camera
end

if debug_mode then
    for key, value in pairs(mod.visible_equipment_plugin.offsets) do
        mod:echo("key: "..type(key)..": "..tostring(key))
        mod:echo("val: "..type(value)..": "..tostring(value))
    end
end

-- ########################################
-- ***** OFFSETS: ONLY FOR SOME WEAPONS *****
-- ########################################
-- ----------
-- Shield hiding
-- Copies all existing placements, then makes versions without the shield
-- ----------
local weapon_families_with_shields = {
    "shotpistol_shield_p1", -- Subductor Shotpistol and Riot Shield
    "powermaul_shield_p1", -- Shock Maul and Suppression Shield
    "ogryn_powermaul_slabshield_p1", -- Ogryn Power Maul and Slab Shield
}
local default_table = {
    position = vector3_box(0, 0, 0),
    rotation = vector3_box(0, 0, 0),
}
local left_table_to_hell = {
    position = vector3_box(0, 0, -99),
    rotation = vector3_box(0, 0, 0),
}

for _, family in ipairs(weapon_families_with_shields) do
    
    local weapon_id = family.."_m1"

    if debug_mode then
        mod:echo(weapon_id)
        mod:echo(type(mod.visible_equipment_plugin.offsets[weapon_id]))
    end

    local original_weapon_return = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/weapons/"..weapon_id)
    if (not original_weapon_return) or (not original_weapon_return.offsets) then 
        if debug_mode then mod:echo("Original Offsets not found!") end
        return 
    end
    
    for slot_name, offset_table in pairs(original_weapon_return.offsets) do
        -- Copying the existing placement
        local copied_slot = slot_name.."_no_shield"
        local final_copied_offsets = offset_table
        final_copied_offsets.right = offset_table.right or default_table
        -- Removing the shield (by SENDING IT TO HELL)
        final_copied_offsets.left = left_table_to_hell

        overwrite_offset_slot_for_family(family, copied_slot, final_copied_offsets)
    end
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