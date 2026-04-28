local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod:add_global_localize_strings({
    loc_ve_placement_uwu_thigh_drop = {
        en = "Drop Leg Holster",
    }
})

return {
    offsets = {
        right = {
            node = "j_rightupleg",
            position = vector3_box(-0.031, -0.067, 0.134),
            rotation = vector3_box(90, -4, 93),
            center_mass = vector3_box(-.02, .1, -.07),
        },
        left = {
            node = "j_leftupleg",
            position = vector3_box(0.045, 0.035, -0.115),
            rotation = vector3_box(-84, -4, -96),
            center_mass = vector3_box(-.02, .1, -.07),
        },
    },
    placements = "uwu_thigh_drop",
    placement_camera = {
        position = vector3_box(-1.258, 2.639, 1.632),
        rotation = 0.5,
    },
}