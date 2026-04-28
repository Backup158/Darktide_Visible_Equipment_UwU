# 2026-04-27
v1.2.0
- Added support for knives
    - These are just the Combat Blades
    - Ogryn blades are too different to group them together
    - Shivs will have details worked out later
- Added placements
    - Thigh Drop Holsters, `uwu_thigh_drop` and `uwu_thigh_drop_sinister`
        - For pistols
        - On right and left thighs respectively, pointing straight down
    - Ankle Holsters
        - For pistols: `uwu_right_ankle_pistol`, `uwu_right_ankle_inside_pistol`, `uwu_left_ankle_pistol`, `uwu_left_ankle_inside_pistol`
        - For knives: `uwu_right_ankle`, `uwu_right_ankle_inside`, `uwu_left_ankle`, `uwu_left_ankle_inside`
        - Blade facing down, pistol grips facing the back. Side indicates which leg it's on, with the implication that you're using the same arm to drop down and grab (not crossing)
- Improved performance by refactoring array access from using ipairs to using numeric for-loops (it is so minute that nobody will notice)

# 2025-10-15
v1.1.0

- Added placements
    - Chest Pistol, `chest_pistol`
        - For pistols
        - On the right side of the upper chest, pointing away from the right shoulder
    - Shoulder Holster, `under_left_arm`
        - For pistols
        - Under the left armpit, pointing to the back
    - Shoulder Holster (Sinister), `under_right_arm`
        - For pistols
        - Under the right armpit, pointing to the back
    - Chest Middle, `chest_middle`
        - On the stomach, pointing down and away from the right shoulder
        - Has Sinister variant
- Majorly refactored code to be cleaner
    - offsets are defined in their own files
    - offset overwrites are defined in each weapon family
        - only overwrites if given something to overwrite with
        - so I don't have to copy over the whole offset, just the parts that changed
    - automated placement values
        - automatically assumes it'll give its own custom camera angle
        - (is this possible) defaults to `hip_front` if no custom placement given
    - adding to the file's main table is done through a function no matter what
        - before it would only use a function if adding to all weapons
        - then if it's specialized, it'd be done manually one by one
        - now it takes a table of weapons to add to, then does that
    - renamed slots to begin with `uwu_` to avoid namespace collisions
    - made function to create an offset based on an existing offset `create_offset_variant`
        - makes a copy of the values, then changes the position/rotation with a multiplier
        - made helper to use this to create left handed version
            - position flipped right-left (x)
            - rotation flipped across right-left and up-down (z and y, because fuck you)

# 2025-08-???
v1.0.0

- Generic locations for all weapons
- up butt and up butt (flipped)