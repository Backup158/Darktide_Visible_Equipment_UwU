local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod.visible_equipment_plugin = {
    offsets = {
        combataxe_p3_m1 = {
            butt = {
                right = {
                    node = "j_hips",
                    position = vector3_box(0.005, -0.05, -0.069),
                    rotation = vector3_box(-10, 0, 90),
                },
            },
            butt_flip = {
                right = {
                    node = "j_hips",
                    position = vector3_box(0.007, -0.05, 0.069),
                    rotation = vector3_box(170, 0, 90),
                },
            },
        },
    },
    placements = {
        butt = "hip_back",
        butt_flip = "hip_back",
    },
    placement_camera = {
        -- copy of hip_back
        butt = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 3.5,
        },
        -- copy of hip_back
        butt_flip = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 3.5,
        },
    }
}
