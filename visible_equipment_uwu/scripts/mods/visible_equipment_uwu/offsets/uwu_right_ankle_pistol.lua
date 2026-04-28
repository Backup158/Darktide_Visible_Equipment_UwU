local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod:add_global_localize_strings({
    loc_ve_placement_uwu_right_ankle_pistol = {
        en = "Right Boot/Ankle Sheath",
    }
})

return {
    offsets = {
        right = {
            node = "j_rightfoot",
            position = vector3_box(0.093, -0.355, 0.077),
            rotation = vector3_box(78, -59, 80),
            center_mass = vector3_box(0, 0, -.15),
        },
    },
    placements = "uwu_right_ankle_pistol",
    placement_camera = {
        position = vector3_box(-1.5, 3, 2),
        rotation = 1.5,
    },
}