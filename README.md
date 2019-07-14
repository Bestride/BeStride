# Bestride
(verb: To stand astride)
A World of Warcraft Addon for managing and organizing mounts

Table of Contents
=================
* [Table of Contents](#table-of-contents)
* [Description](#description)
* [Usage](#usage)
  * [Configuration](#configuration)
  * [Mounting](#mounting)
  * [Class Specific Features](#class-specific-features)
* [Changelog](#changelog)

Description
=================

BeStride is a mount manager that has the following functionality

* All in one mount button
  * Allows additional keybinds for overriding functionality
* Randomly select mount, based on a customizable list
* Intelligently select between ground, flying, swimming, repair or passenger
* Intelligently select class specific spells & mounts depending on the situation (druid cat form in combat, priest levitate, paladin divine steed, warlock underwater breating, etc)

History
=================
Yay Mounts was a mount management Addon for World of Warcraft that has stopped being maintained since September 2016. The addon developers were Faldoncow and askander_kt.

Bestride is a continuation of the code, which will hopefully fix some of the bugs as well as repair some deficiencies in the previous code. Also included is the latest ACE3 versions of the libraries used.  Code will be gradually refactored up to the released, which will be v1.0

Special mounts are also usable:

* Flying Broom
* Oculus Mount
* Northrend Loaned Mount
* Abyssal Seahorse
* Subdued Seahorse
* Sea Turtle
* ~~Water strider (prioritized)~~

Project Pages
-----------------

Curseforge Addon: https://www.curseforge.com/wow/addons/bestride-mm

Curseforge Project: https://wow.curseforge.com/projects/bestride-mm

Github Project: https://github.com/DanSheps/Bestride/projects/1

Github Issues: https://github.com/Dansheps/Bestride/issues

Contributing Guidelines: https://github.com/DanSheps/Bestride/blob/develop/.github/ISSUE_TEMPLATE/CONTRIBUTING.md

Usage
=================

Configuration
-----------------

Configuration is accomplished through the use of the /br or /bestride slash command.

This will open the BeStride GUI.  The GUI will also appear in the Blizzard "Addons" area under Interface

Mounting
-----------------

Mounting is accomplished through either setting a keybind or the following "click" buttons:

* Standard Mount: /click BeStride_ABRegularMount
* Force Ground Mount: /click BeStride_ABGroundMount
* Force Passenger Mount: /click BeStride_ABPassengerMount
* Force Repair Mount: /click BeStride_ABRepairMount

Class Specific Features
-----------------

The following classes have special features:

* Druids
  * Supports: all flight forms, aquatic form, travel form
  * Flight form while swimming may be buggy and require jumping out of the water to activate
* Shamans
  * Supports: Ghost Wolf
* Priests
  * Supports: Levitate
  * Pressing a second time will cancel
* Mages
  * Supports: Slow fall, Blink
  * Pressing a second time will cancel
* Monks
  * Supports: Roll & Zen Flight
* Rogues
  * Supports: Sprint
* Paladins
  * Supports: Divine Steed
* Death Knights
  * Supports: Wraith Walk
* Demon Hunter
  * Supports: Fel Rush, Glide

Changelog
=================
v1.0.19
-----------------
* Add support for Pathfinder
* Add no Swimming
* Both thanks to Debuggernaut and Daeymien

v1.0.18
-----------------
* Fix Dismount while flying error
* Fix debug code error

v1.0.17
-----------------
* Added Debug Information.  Type "/br bug" to access.  Be aware, your game will freeze while debug information is compiled.
* Update Changelog

v1.0.16
-----------------
* Merged Pull #86 (mcc1/develop) - Check against class id instead of name
* Merged Pull #90 (mcc1/robot)
* Fixes #91 - Added Escape Keybind to close frame

v1.0.15
-----------------
* Version Bump

v1.0.14
-----------------
* Fixes #77 - Add Blacklist for Flying: Quel'Danas
* Fixes #78 - Add Blacklist for Flying: AzureMyst, BloodMyst, Eversong, Ghostlands
* Fixes #84 - Flight Form triggers when mounted
* Fixes #85 - New Mounts added even when not enabled
* Fixes #87 - spellID checked for null, however mountID used in final check
* Fixes #89 - Mage Blink Logic In Combat

v1.0.13
-----------------
* Fixes #81 - Added changed comparison for zone to zone.name


v1.0.12
-----------------
* Fixes #83 - Add check for nil continent and zone

v1.0.11
-----------------
* Fixes #82 - Put in check for empty continent

v1.0.10
-----------------
* Fixes #80 - Changed Function to DruidCanSwim()
* Fixes #68 - Implement check for nil parent in GetMapUntil()
* Fixes #72 - Restrict Vashj'ir mount to Vashj'ir only

v1.0.9
-----------------
* Merge pull #76 (Ragnar-F/develop) - Add German localization and other changes
* Fixes #74 - Added logic for blacklisting zones and continents
* Fixes #75 - Fixed Indoor/Outdoor Logic
* Fixes #72 - No Vashj'ir Mount Use In Addon!
* Fixes #73 - Remove garbage collection on click
* Merge pull (mcc1/develop) - add Taiwanese locale

v1.0.8
-----------------
* Fixes #71 - Corrected spelling mistaken on Demon Hunter Mount during Combat resulting in error being thrown

v1.0.7
-----------------
* Version Bump

v1.0.6
-----------------
* Fix ConfigRegistry Errors

v1.0.5
-----------------
* Version Bump
* Fixes #69 - Variable File Missing 

v1.0.4
-----------------
* Fixes #66 - Reorder TOC

v1.0.3
-----------------
* Fixes #65 - Added check for mounted or flight form

v1.0.2
-----------------
* Added Localization

v1.0.1
-----------------
* Fixes #61 - Corrected Variable Spelling
* Fix Readme

v1.0.0
-----------------
* Full Release
* Logic rewritten
* UI rewritten
* New Features:
  * New setting to force flying mounts when unable to fly (previously it would mix ground and flying)
  * Separate Mage Blink and Slowfall if to only trigger one
  * Added Death Knights Fel Rush and Gliding
* Special thanks goes out to Mindlessgalaxy for helping with beta testing and opening issues.

v0.5.0
-----------------
* Beta Version
* UI rewritten
* New Features:
  * New setting to force flying mounts when unable to fly (previously it would mix ground and flying)
  * Separate Mage Blink and Slowfall if to only trigger one
  * Added Death Knights Fel Rush and Gliding

v0.0.10
-----------------
* Added Mage Logic - Thanks to Daeymien for the pull request(s)

v0.0.10
-----------------
* Multiple fixes - Thanks to Daeymien for the pull request(s)

v0.0.6
-----------------
* Fixes mounting while swimming - Thanks to Daeymien for the pull request to resolve and to Malivil for helping

v0.0.5
-----------------
* Housekeeping and Version bump by Malivil

v0.0.4
-----------------
* Fixes logic for 8.0.1 - Thanks to Daeymien for the pull request to resolve

v0.0.3
-----------------
* Fix logic with passenger mount summoning - Thanks to Xsear for the pull request to resolve
* Adds Blizzcon Mounts

v0.0.2
-----------------

* Fixed issue with YayMounts Macros not working

v0.0.1
-----------------

* Fixed issue with mount failure after changing mounts
* Fixed issue with closing settings box
