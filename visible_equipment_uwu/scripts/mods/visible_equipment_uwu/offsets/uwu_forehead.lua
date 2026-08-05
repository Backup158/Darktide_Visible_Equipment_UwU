local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod:add_global_localize_strings({
    loc_ve_placement_uwu_forehead = {
        en = "Forehead",
    }
})

return {
    offsets = {
        right = {
            node = "j_head",
            position = vector3_box(0.0, 0.05, 0.0),
            rotation = vector3_box(0, 0, 90),
        },
        left = {
            node = "j_head",
            position = vector3_box(0.0, -0.05, 0.0),
            rotation = vector3_box(0, 0, 90),
        },
    },
    -- handled automatically
    --placements = "hip_back",
    placement_camera = {
        position = vector3_box(-1.258, 2.639, 1.632),
        rotation = 3.5,
    },
}