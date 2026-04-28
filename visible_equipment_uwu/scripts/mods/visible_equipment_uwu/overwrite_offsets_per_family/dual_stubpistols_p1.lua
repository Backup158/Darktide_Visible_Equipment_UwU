local vector3_box = Vector3Box

return {
    -- Chest
    uwu_chest_middle = {
        left = {
            position = vector3_box(-0.061, -0.127, -0.168),
            rotation = vector3_box(7, 43, 72),
        },
    },
    uwu_chest_middle_sinister = {
        left = {
            position = vector3_box(-0.105, -0.07, 0.158),
            rotation = vector3_box(157, 57, 103),
        },
    },
    uwu_chest_pistol = {
        left = {
            position = vector3_box(0.046, -0.168, -0.165),
            rotation = vector3_box(-22, 51, 110),
        },
    },
    uwu_chest_pistol_sinister = {
        left = {
            position = vector3_box(0.043, -0.105, 0.152),
            rotation = vector3_box(161, 44, 100),
        },
    },
    -- Ankle Pistol Holsters
    uwu_right_ankle_pistol = {
        right = {
            position = vector3_box(0.109, -0.311, 0.073),
            rotation = vector3_box(78, -59, 80),
        },
        left = {
            node = "j_leftfoot",
            position = vector3_box(-0.218, 0.225, -0.078),
            rotation = vector3_box(-79, 61, -104),
        },
    },
    uwu_right_ankle_inside_pistol = {
        right = {
            position = vector3_box(0.1, -0.252, -0.088),
            rotation = vector3_box(79, -59, 72),
        },
        left = {
            node = "j_leftfoot",
            position = vector3_box(-0.234, 0.176, 0.053),
            rotation = vector3_box(-56, 55, -115),
        },
    },
    uwu_left_ankle_pistol = {
        right = {
            position = vector3_box(-0.063, 0.322, -0.056),
            rotation = vector3_box(-45, 53, -131),
        },
        left = {
            node = "j_rightfoot",
            position = vector3_box(0.227, -0.222, 0.067),
            rotation = vector3_box(89, -60, 96),
        },
    },
    uwu_left_ankle_inside_pistol = {
        right = {
            position = vector3_box(-0.126, 0.264, 0.104),
            rotation = vector3_box(-45, 53, -124),
        },
        left = {
            node = "j_rightfoot",
            position = vector3_box(0.247, -0.2, -0.111),
            rotation = vector3_box(77, -61, 76),
        },
    },
}