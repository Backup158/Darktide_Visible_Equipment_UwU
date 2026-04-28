local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod:add_global_localize_strings({
    loc_ve_placement_uwu_right_ankle = {
        en = "Boot/Ankle Sheath",
    }
})

return {
    offsets = {
        right = {
            node = "j_rightfoot",
            position = vector3_box(0.095, -0.193, 0.056),
            rotation = vector3_box(-90, -28, -83),
            center_mass = vector3_box(0, 0, -.15),
        },
    },
    placements = "uwu_right_ankle",
    placement_camera = {
        position = vector3_box(-1.5, 3, 2),
        rotation = 0.5,
    },
}