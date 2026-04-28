local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod:add_global_localize_strings({
    loc_ve_placement_uwu_left_ankle = {
        en = "Left Boot/Ankle Sheath",
    }
})

return {
    offsets = {
        right = {
            node = "j_leftfoot",
            position = vector3_box(-0.083, 0.19, -0.071),
            rotation = vector3_box(86, 32, 110),
            center_mass = vector3_box(0, 0, -.15),
        },
    },
    placements = "uwu_left_ankle",
    placement_camera = {
        position = vector3_box(-1.5, 3, 2),
        rotation = 0.5,
    },
}