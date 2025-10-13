local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod:add_global_localize_strings({
    loc_ve_placement_uwu_chest_middle = {
        en = "Chest Middle",
    }
})

return {
    offsets = {
        right = {
            node = "j_hips",
            position = vector3_box(0.02, 0.17, 0.25),
            rotation = vector3_box(20, -40, 90),
        },
    },
    -- handled automatically
    --placements = "hip_back",
    placement_camera = {
        position = vector3_box(-1.5, 3, 2),
        rotation = 0.5,
    },
}