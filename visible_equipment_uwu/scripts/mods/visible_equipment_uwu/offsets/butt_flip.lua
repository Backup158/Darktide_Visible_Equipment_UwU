local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

return {
        offsets = {
            right = {
                node = "j_hips",
                position = vector3_box(0.007, -0.05, -0.069),
                rotation = vector3_box(170, 0, 90),
            },
        },
        placements = "hip_back",
        placement_camera = {
            position = vector3_box(-1.258, 2.639, 1.632),
            rotation = 3.5,
        },
    }