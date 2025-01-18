# Triksheim AutoClicker v2

## Overview
Customizable AutoHotkey-based autoclicker with a user-friendly GUI.\
Adjustable click delay, random offset between clicks, and fixed or dynamic click positions.\
Fixed click mode features snap back to previous mouse position which makes it possible to\
run the AC while still being in control of the mouse on a different part of the screen.

## How to Use

### Paramters
* `Click Delay (ms)`: Time interval between clicks in milliseconds (min=10)
* `Rnd offset (ms)`: Random +/- interval offset in milliseconds (max=ClickDelay-1)
* `Fixed position?`: Toggle between fixed or dynamic mode. If no previous fixed click posision is saved the AC will click on the posision when activated.

### Hotkeys:
* `F12`: Toggle the autoclicker on or off.
* `Ctrl + F12`: Update the fixed mode click position to the current mouse position.
* `F11`: Show the GUI.
* `Escape`: Hide the GUI.

### Requirements
* AutoHotkey Version: v2.0 or higher.