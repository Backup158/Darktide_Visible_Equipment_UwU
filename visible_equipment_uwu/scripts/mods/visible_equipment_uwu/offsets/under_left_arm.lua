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
            position = vector3_box(-0.16, 0.05, 0.29),
            rotation = vector3_box(15, -10, 180),
        },
    },
    placements = "under_left_arm",
    placement_camera = {
        position = vector3_box(-1.258, 2.639, 1.632),
        rotation = 1.5,
    },
}