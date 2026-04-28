local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod:add_global_localize_strings({
    loc_ve_placement_uwu_left_ankle = {
        en = "Left Boot/Ankle Sheath (Inside)",
    }
})

return {
    offsets = {
        right = {
            node = "j_leftfoot",
            position = vector3_box(-0.081, 0.108, 0.062),
            rotation = vector3_box(93, 34, 106),
            center_mass = vector3_box(0, 0, -.15),
        },
    },
    placements = "uwu_left_ankle_inside",
    placement_camera = {
        position = vector3_box(-1.5, 3, 2),
        rotation = 1.5,
    },
}