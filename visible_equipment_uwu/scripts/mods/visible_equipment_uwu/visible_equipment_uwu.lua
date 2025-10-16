local mod = get_mod("visible_equipment_uwu")
mod.version = "1.1.0"
local enable_debug_mode = mod:get("enable_debug_mode")
if enable_debug_mode then mod:info("Debug mode activated. Pwepawe youw anus >:3") end

-- ####################
-- UTILITY/SETUP
-- ####################
-- --------------------
-- Requirements
-- --------------------
local WeaponTemplates = require("scripts/settings/equipment/weapon_templates/weapon_templates")

-- --------------------
-- Performance
-- --------------------
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
local table_merge_recursive = table.merge_recursive

local vector3 = Vector3
local vector3_box = Vector3Box
local vector3_to_elements = Vector3.to_elements
local vector3_from_table = Vector3.from_table
local quaternion = Quaternion
local quaternion_to_euler_angles_xyz = quaternion.to_euler_angles_xyz
local quaternion_from_euler_angles_xyz = quaternion.from_euler_angles_xyz

-- --------------------
-- Mod Data
-- --------------------
-- ----------
-- Automatically grabbing all weapons
-- ----------
local all_weapon_ids = {}
for weapon_id, _ in pairs(WeaponTemplates) do
    -- Only do this if it's a normal equippable weapon
    --  _p<digit>_m<digit>
    if _string_find(weapon_id, "_p%d_m%d") then
        table_insert(all_weapon_ids, weapon_id)
    end
end
if false and enable_debug_mode then
    --mod:echo("WEAPON TEMPLATES DUMPED! Don't forget to remove these!")
    --table_dump(WeaponTemplates, "WeaponTemplatussy", 10)
    
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

local quaternion_to_vector = function(quaternion)
    local x, y, z = quaternion_to_euler_angles_xyz(quaternion)
    return vector3(x, y, z)
end
local quaternion_from_vector = function(vector)
    return quaternion_from_euler_angles_xyz(vector[1], vector[2], vector[3])
end

-- ----------
-- Apply 2D Transformation to Vector3Box
-- DESC: given a vector3box, multiply it with the transformation given
--  not just modifying the vector without returning because that affects the one it was cloned from
--  maybe vectors are pointers being passed around?
--  not using the vector3 functions becaus returning a vector3 doesn't work (just defaults to 0)
-- PARAM:
--      vector_userdata; Vector3Box; the position/rotation
--      two_dimensional_array; table of numbers; like {x = 1, y = 2, z = 1}
-- RETURN: Vector3Box
-- ----------
local function apply_two_dimensional_transformation_to_vector(vector_userdata, two_dimensional_array)
    -- if different lengths, error
    if not 3 == #two_dimensional_array then
        mod:error("Scalar array is not sized 3")
        return
    end

    return vector3_box(vector_userdata[1] * two_dimensional_array.x, 
        vector_userdata[2] * two_dimensional_array.y, 
        vector_userdata[3] * two_dimensional_array.z)
end

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
-- Offsets Manual Override Helper
-- DESC: Overwrites default offsets for all marks of a weapon family
-- PARAM:
--      weapon_id_without_mark; string; "powersword_p1"
--      offset_slot; string; "butt"
--      table_for_this_offset; table; no example because fuck you
-- ----------
local function overwrite_offset_slot_for_family(weapon_id_without_mark, offset_slot, table_for_this_offset)
    if not table_for_this_offset then 
        mod:info("No custom offsets for "..weapon_id_without_mark)
        return
    end
    
    -- Loop over 3 marks
    --  range: [1, 3]
    for i = 1, 3 do
        local weapon_id = weapon_id_without_mark.."_m"..tostring(i)
        -- If this mark doesn't exist (doesn't have an offset already), don't try it
        --      weapon may just not exist and this is cheaper than checking the masteritems
        if not visible_equipment_plugin.offsets[weapon_id] then
            return
        -- If trying to overwrite an offset that wasn't added to that weapon, yell at me
        elseif not visible_equipment_plugin.offsets[weapon_id][offset_slot] then
            mod:error("Cannot overwrite slot <"..offset_slot.."> for <"..weapon_id.."> because that offset isn't on that weapon!")
            return
        end
        table_merge_recursive(visible_equipment_plugin.offsets[weapon_id][offset_slot], table_for_this_offset)
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

    -- Copy offsets for EACH weapon
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
    --  if no custom camera position given, use one of the existing positions
    --  otherwise, use the custom placement
    if not values_from_file.placement_camera then
        visible_equipment_plugin.placements[offset_name] = values_from_file.placements or "hip_front"
    else
        visible_equipment_plugin.placements[offset_name] = offset_name
    end

    visible_equipment_plugin.placement_camera[offset_name] = values_from_file.placement_camera
end

-- ----------
-- Create Left-handed variant
-- From an already generated offset, create a version suited for left handed use
-- PARAM
--  offset_to_copy; string; such as "uwu_butt"
-- RETURN: N/A just writes values
-- ----------
local function create_sinister_offset(original_offset_name)
    for weapon_id, _ in pairs(visible_equipment_plugin.offsets) do
        -- if original offset did not exist
        if visible_equipment_plugin.offsets[weapon_id][original_offset_name] then
            -- if it has original offset, copy and modify
            local sinister_name = original_offset_name.."_sinister"
            --  copy original offset
            visible_equipment_plugin.offsets[weapon_id][sinister_name] = table_clone(visible_equipment_plugin.offsets[weapon_id][original_offset_name])
            --  flip values
            for weapon_hand, _ in pairs(visible_equipment_plugin.offsets[weapon_id][sinister_name]) do
                visible_equipment_plugin.offsets[weapon_id][sinister_name][weapon_hand].position = apply_two_dimensional_transformation_to_vector(visible_equipment_plugin.offsets[weapon_id][sinister_name][weapon_hand].position, {x = -1, y = 1, z = 1})
                visible_equipment_plugin.offsets[weapon_id][sinister_name][weapon_hand].rotation = apply_two_dimensional_transformation_to_vector(visible_equipment_plugin.offsets[weapon_id][sinister_name][weapon_hand].rotation, {x = 1, y = -1, z = -1})
            end
            
            if visible_equipment_plugin.placement_camera[original_offset_name] then
                visible_equipment_plugin.placements[sinister_name] = {
                    [sinister_name] = sinister_name
                }
                visible_equipment_plugin.placement_camera[sinister_name] = table_clone(visible_equipment_plugin.placement_camera[original_offset_name])
            end
        else
            mod:error("Cannot make sinister variant. Original does not exist: "..original_offset_name.." for "..weapon_id)
        end
    end
end

-- ########################################
-- ***** DEFAULT OFFSETS *****
-- Each weapon has a table of offset
-- Each offset has a placement and placement camera
-- ########################################
-- Adding in the Stupid Options
if mod:get("xd_mode") then
    add_whole_offset_from_file_direct("uwu_butt", all_weapon_ids)
    add_whole_offset_from_file_direct("uwu_butt_flip", all_weapon_ids)
end

--add_whole_offset_from_file_direct("zero", all_weapon_ids)
add_whole_offset_from_file_direct("uwu_chest_middle", all_weapon_ids)
create_sinister_offset("uwu_chest_middle")

local pistol_ids = {}
for _, weapon_id in ipairs(all_weapon_ids) do
    if (_string_find(weapon_id, "pistol")) or (_string_find(weapon_id, "revolver")) then
        table_insert(pistol_ids, weapon_id)
    end 
end
add_whole_offset_from_file_direct("uwu_chest_pistol", pistol_ids)
add_whole_offset_from_file_direct("uwu_under_left_arm", pistol_ids)
add_whole_offset_from_file_direct("uwu_under_right_arm", pistol_ids)

if enable_debug_mode then 
    table_dump(visible_equipment_plugin, "BULGING OFFSETS AND POSITIONS", 10) 
end

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