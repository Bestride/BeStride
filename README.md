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
Yay Mounts was a mount management Addon for World of Warcraft that has stopped being maintained since September 2016. The addon developers were Faldoncow and askander_kt.

Bestride is a continuation of the code, which will hopefully fix some of the bugs as well as repair some deficiencies in the previous code. Also included is the latest ACE3 versions of the libraries used.  Code will be gradually refactored up to the released, which will be v1.0

Special mounts are also usable:

* Flying Broom
* Oculus Mount
* Northrend Loaned Mount
* Abyssal Seahorse
* Subdued Seahorse
* Sea Turtle
* Water strider (prioritized)

Project Pages
-----------------

Curseforge Addon: https://www.curseforge.com/wow/addons/bestride-mm
Curseforge Project: https://wow.curseforge.com/projects/bestride-mm
Github Project: https://github.com/DanSheps/Bestride/projects/1

Usage
=================

Configuration
-----------------

Configuration is accomplished through the use of the /ym slash command.

This will open the Yay Mounts GUI.

Mounting
-----------------

Mounting is accomplished through either setting a keybind or the following "click" buttons:

* Standard Mount: /click BestrideButtonMount
* Force Ground Mount: /click BestrideButtonGround
* Force Passenger Mount: /click BestrideButtonPassenger
* Force Repair Mount: /click BestrideButtonRepair

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
  * Supports: Slow fall
  * Pressing a second time will cancel
* Monks
  * Supports: Roll & Zen Flight
* Rogues
  * Supports: Sprint
* Paladins
  * Supports: Divine Steed
* Death Knights
  * Supports: Wraith Walk

Changelog
=================
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
