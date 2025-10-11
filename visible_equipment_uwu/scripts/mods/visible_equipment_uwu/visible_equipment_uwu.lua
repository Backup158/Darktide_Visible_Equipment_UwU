local mod = get_mod("visible_equipment_uwu")
mod.version = "1.1.0"
local debug_mode = mod:get("debug_mode")
if debug_mode then mod:info("Debug mode activated. Pwepawe youw anus >:3") end

-- ####################
-- UTILITY/SETUP
-- ####################
-- Requirements
local WeaponTemplates = require("scripts/settings/equipment/weapon_templates/weapon_templates")

-- Performance
local pairs = pairs
local ipairs = ipairs

local tostring = tostring
local string = string
local string_match = string.match
local _string_find = string.find

local table = table
local table_insert = table.insert
local table_clone = table.clone
local table_dump = table.dump

-- --------------------
-- HOOKS
-- Defining actions for startup
-- --------------------
function mod.on_all_mods_loaded()
    mod:info("v"..mod.version.." loaded uwu nya :3")
    
    -- putting this here because it's load order agnostic, so having the check before all mods loaded may throw errors if this is before the base mod
    if not get_mod("visible_equipment") then
        mod:error("Visible Equipment mod required! The standalone mod, not Extended Weapon Customization")
    elseif get_mod("weapon_customization") then
        mod:error("Visible Equipment is NOT compatible with the deprecated version of Extended Weapon Customization! {#color(255,0,0)}You will crash!{#reset()}")
    end
end

-- --------------------
-- HELPER FUNCTIONS
-- --------------------
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
local visible_equipment_plugin = {
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
    if not table_for_offset then 
        mod:info("No custom offsets for "..weapon_id_without_mark)
        return
    end
    
    -- Loop over 3 marks
    --  range: [1, 3]
    for i = 1, 3 do
        local weapon_id = weapon_id_without_mark.."_m"..tostring(i)
        -- If this mark doesn't exist (doesn't have an offset already), don't try it
        if not visible_equipment_plugin.offsets[weapon_id] then
            return
        end

        visible_equipment_plugin.offsets[weapon_id][offset_slot] = table_for_offset
    end
end

-- ----------
-- Opens File in this Mod's Folder
-- PARAM: 
--         relative_file_path; string; "offsets/nyaaa" to go to "./offsets/nyaaa.lua"
-- RETURN: whatever that file returns
-- ----------
local function open_mod_file(relative_file_path) 
    return mod:io_dofile("visible_equipment_uwu/scripts/mods/visible_equipment_uwu/"..relative_file_path)
end

-- ----------
-- add_whole_offset_from_file_direct
-- PARAM: 
--         table_of_weapons_to_add_to; table of strings; all the weapons (e.g. "autogun_p1_m2") this offset is added to
--         offset_name; string; "nyaaa" to go to "./offsets/nyaaa.lua"
-- RETURN: N/A
-- ----------
local function add_whole_offset_from_file_direct(offset_name, table_of_weapons_to_add_to)
    local values_from_file = open_mod_file("offsets/"..offset_name)

    -- Copy offsets for each weapon
    --  uses a generic offset, which may be overwritten later
    for _, weapon_id in ipairs(table_of_weapons_to_add_to) do
        -- Initializing the weapon's table if not done yet
        if not visible_equipment_plugin.offsets[weapon_id] then
            visible_equipment_plugin.offsets[weapon_id] = {}
        end

        -- need to clone bc it may get overwritten
        visible_equipment_plugin.offsets[weapon_id][offset_name] = table_clone(values_from_file.offsets)
    end
    -- Add placement info
    visible_equipment_plugin.placements[offset_name] = values_from_file.placements
    visible_equipment_plugin.placement_camera[offset_name] = values_from_file.placement_camera
end

-- ########################################
-- ***** DEFAULT OFFSETS *****
-- Each weapon has a table of offset
-- Each offset has a placement and placement camera
-- ########################################
-- Adding in the Stupid Options
if mod:get("xd_mode") then
    add_whole_offset_from_file_direct("butt", all_weapon_ids)
    add_whole_offset_from_file_direct("butt_flip", all_weapon_ids)
end

local pistol_ids = {}
for _, weapon_id in ipairs(all_weapon_ids) do
    if (_string_find(weapon_id, "pistol")) or (_string_find(weapon_id, "revolver")) then
        table_insert(pistol_ids, weapon_id)
    end 
end
add_whole_offset_from_file_direct("chest_pistol", pistol_ids)

if debug_mode then table_dump(visible_equipment_plugin.offsets, "BULGING OFFSETS", 10) end

-- ########################################
-- ***** OFFSETS: MANUAL OVERRIDES *****
-- ########################################
local families_that_need_overrides = { "powersword_p1", }
for _, weapon_family in ipairs(families_that_need_overrides) do
    for slot, offset in pairs(open_mod_file("overwrite_offsets_per_family/"..weapon_family)) do
        overwrite_offset_slot_for_family(weapon_family, slot, offset)
    end
end

mod.visible_equipment_plugin = visible_equipment_plugin