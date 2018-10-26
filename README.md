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
