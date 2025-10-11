# 2025-10-nyaa
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
- Majorly refactored code to be cleaner
    - offsets are defined in their own files
    - offset overwrites are defined in each weapon family
        - only overwrites if given something to overwrite with
        - so I don't have to copy over the whole offset, just the parts that changed
    - adding to the file's main table is done through a function no matter what
        - before it would only use a function if adding to all weapons
        - then if it's specialized, it'd be done manually one by one
        - now it takes a table of weapons to add to, then does that

# some day idk
v1.0.0

- Generic locations for all weapons
- up butt and up butt (flipped)