# 2025-10-nyaa
v1.1.0

- Added chest pistol placement
- Majorly refactored code to be cleaner
    - offsets are defined in their own files
    - offset overwrites are defined in each weapon family
    - adding to the file's main table is done through a function no matter what
        - before it would only use a function if adding to all weapons
        - then if it's specialized, it'd be done manually one by one
        - now it takes a table of weapons to add to, then does that

# some day idk
v1.0.0

- Generic locations for all weapons
- up butt and up butt (flipped)