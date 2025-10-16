# Visible Equipment - Uprooted with Umbrage
Addon for the Standalone Visible Equipment mod for *Warhammer 40,000: Darktide*.

Adds weapon placements that I think are cool. Mostly tactical and shitposty. 

## Requirements
- Darktide prepared for modding
    - DML/DMF (see linked guide in installation)
    - Not played through cloud gaming services
- Visible Equipment
    - Currently not on Nexus. WIP in the [Darktide Modders Discord](https://discord.gg/rKYWtaDx4D)

### Installation 

Install like any other mod. If you don't know how, here is a [guide for manual mod installation](https://dmf-docs.darkti.de/#/installing-mods)

Load order does not matter.

## Weapon Placements
Placements may have a descriptive tag that is *italicized*. Explanations for these are in the glossary below.
- Chest Pistol, `chest_pistol`
    - On the right side of the upper chest, pointing away from the right shoulder
    - *For pistols*
- Chest Pistol (Sinister), `chest_pistol_sinister`
    - On the upper chest, pointing away from the left shoulder
    - *For pistols*
    - *Sinister*
- Shoulder Holster, `under_left_arm`
    - Under the left armpit, pointing to the back
    - *For pistols*
- Shoulder Holster (Sinister), `under_right_arm`
    - Under the right armpit, pointing to the back
    - *For pistols*
    - *Sinister*
- Chest Middle, `chest_middle`
    - On the stomach, facing down and away from the right shoulder
    - Added to all weapons, but only really fits on ranged weapon (not staff)
- Prison Pocket, `butt`
    - Up the butt
    - only really fits on melee/staffs
    - *xd*
- Prison Pocket (Flipped), `butt_flip`
    - Up the butt (flipped)
    - only really fits on melee/staffs
    - *xd*

## Glossary
- *For pistols*: Placement is only added to weapons with "pistol" or "revolver" in the internal name
- *Sinister*: Placement is designed for the weapon to be drawn with the left hand
- *xd*: Placement requires "xd mode" to be enabled in the Mod Options to appear

## Known Issues
- Positions are not localized
    - think I just have to wait for the base mod to be updated, after `extended_weapon_customization` is done
    - they'll use the `<code_names>` for now
- Positions clip into body or float too far off
    - Positions are set regardless of cosmetics equipped, so thicker jackets and such would clip, while slimmer clothes may make the weapons float
    - Will likely make variants that stick out a bit more
- Weapon position doesn't make sense at all
    - mainly for the butt positions
    - needs me to apply the fix to every gun and i'm not doing that right now
    - also i didn't check anything for ogryn so lol
- Camera previews are inaccurate (just the head)
    - Yeah idk what's going on here atm