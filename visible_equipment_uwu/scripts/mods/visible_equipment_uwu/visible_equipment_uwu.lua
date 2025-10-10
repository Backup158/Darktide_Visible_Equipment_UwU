local mod = get_mod("visible_equipment_uwu")
mod.version = "1.1.0"
local debug_mode = mod:get("debug_mode")

-- ####################
-- UTILITY/SETUP
-- ####################
-- Requirements
local WeaponTemplates = require("scripts/settings/equipment/weapon_templates/weapon_templates")

-- Performance
local vector3_box = Vector3Box
local tostring = tostring
local string = string
local string_match = string.match
local _string_find = string.find
local table = table
local table_insert = table.insert
local table_dump = table.dump

-- ----------
-- HOOKS
-- Defining actions for startup
-- ----------
function mod.on_all_mods_loaded()
    mod:info("v"..mod.version.." loaded uwu nya :3")
    mod:echo("{#color(255,0,0)}pipe down, skittle squad{#reset()}")

    -- putting this here because it's load order agnostic, so having the check before all mods loaded may throw errors if this is before the base mod
    if not get_mod("visible_equipment") then
        mod:error("Visible Equipment mod required! The standalone mod, not Extended Weapon Customization")
    elseif get_mod("weapon_customization") then
        mod:error("Visible Equipment is NOT compatible with the deprecated version of Extended Weapon Customization! {#color(255,0,0)}You will crash!{#reset()}")
    end
end

-- ----------
-- Automatically grabbing all weapons
-- ----------
local all_weapon_ids = {}
for weapon_id, _ in pairs(WeaponTemplates) do
    -- Only do this if it's a normal equippable weapon
    if (_string_find(weapon_id, "_p")) and (_string_find(weapon_id, "_m")) then
        table_insert(all_weapon_ids, weapon_id)
    end
end
if debug_mode then
    table_dump(all_weapon_ids, "All weapons found", 10)
end

-- ----------
-- Offsets for the base mod to read
--  This must be filled out BEFORE all mods are loaded
--  Because that's when the base mod reads this table
-- ----------
mod.visible_equipment_plugin = {
    offsets = { },
    placements = { },
    placement_camera = { },
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

local function open_mod_file(relative_file_path) 
    return mod:io_dofile("visible_equipment_uwu/scripts/mods/visible_equipment_uwu/"..relative_file_path)
end

local function add_offsets_to_table_from_file(table_to_add_to, offset_name)
    table_to_add_to[offset_name] = open_mod_file("offsets/"..offset_name)
end

-- ########################################
-- ***** DEFAULT OFFSETS *****
-- Each weapon has a table of offset
-- Each offset has a placement and placement camera
-- ########################################
local offsets_for_all_weapons = { }

-- Adding in the Stupid Options
if mod:get("owo_mode") then
    add_offsets_to_table_from_file(offsets_for_all_weapons, "butt")
    add_offsets_to_table_from_file(offsets_for_all_weapons, "butt_flip")
end

-- ----------
-- Looping through every weapon for offsets
--      Using a generic, default value (from that table above)
--      Will overwrite below if needed
-- ----------
for _, weapon_id in ipairs(all_weapon_ids) do
    -- Initializing the weapon's table
    if not mod.visible_equipment_plugin.offsets[weapon_id] then
        mod.visible_equipment_plugin.offsets[weapon_id] = {}
    end

    -- Adds all default offsets
    for offset_slot, _ in pairs(offsets_for_all_weapons) do
        mod.visible_equipment_plugin.offsets[weapon_id][offset_slot] = offsets_for_all_weapons[offset_slot].offsets
    end
end

-- ----------
-- Setting base node for placement and camera preview
--      Only done once for each slot I add
-- ----------
for offset_slot, _ in pairs(offsets_for_all_weapons) do
    mod.visible_equipment_plugin.placements[offset_slot] = offsets_for_all_weapons[offset_slot].placements
    mod.visible_equipment_plugin.placement_camera[offset_slot] = offsets_for_all_weapons[offset_slot].placement_camera
end

if debug_mode then
    mod:info("Offsets: ")
    for key, value in pairs(mod.visible_equipment_plugin.offsets) do
        mod:info("\tkey: "..type(key)..": "..tostring(key))
        mod:info("\tval: "..type(value)..": "..tostring(value))
    end
end

-- ########################################
-- ***** OFFSETS: ONLY FOR SOME WEAPONS *****
-- ########################################
--[[
Not necessary now that it's handled by the base mod
but it was fun to do
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
        mod:info(weapon_id)
        mod:info(type(mod.visible_equipment_plugin.offsets[weapon_id]))
    end

    local original_weapon_return = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/weapons/"..weapon_id)
    if (not original_weapon_return) or (not original_weapon_return.offsets) then 
        if debug_mode then mod:info("Original Offsets not found!") end
        return 
    end
    
    for original_slot_name, original_offset_table in pairs(original_weapon_return.offsets) do
        -- Copying the existing placement
        local slot_with_no_shield = original_slot_name.."_no_shield"
        local final_copied_offsets = original_offset_table
        final_copied_offsets.node = original_offset_table.node or "j_hips"
        final_copied_offsets.right = original_offset_table.right or default_table
        -- Removing the shield (by SENDING IT TO HELL)
        final_copied_offsets.left = left_table_to_hell

        -- Adding the offsets to this plugin
        overwrite_offset_slot_for_family(family, slot_with_no_shield, final_copied_offsets)
        -- Copying over the placements
        --  wait that's not where they're stored lol
        --mod.visible_equipment_plugin.placements[offset_slot] = original_weapon_return[original_slot_name].placements or 
        --mod.visible_equipment_plugin.placement_camera[offset_slot] = original_weapon_return[original_slot_name].placement_camera
    end
end
]]


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