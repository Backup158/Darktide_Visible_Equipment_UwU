local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod:add_global_localize_strings({
    loc_ve_uwu_under_left_arm = {
        en = "Shoulder Holster",
    }
})

return {
    offsets = {
        right = {
            node = "j_hips",
            position = vector3_box(-0.1, 0.1, 0.3),
            rotation = vector3_box(10, -40, 180),
        },
    },
    placements = "under_left_arm",
    placement_camera = {
        position = vector3_box(-1.258, 2.639, 1.632),
        rotation = 0.5,
    },
}