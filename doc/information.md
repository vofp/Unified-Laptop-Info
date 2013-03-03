# Information

In this file, we will show the types of information that will be parsed and displayed.

## Focus
Currently we want to focus on parsing the information that can be compared
* Screen Size
* Resolution
* HDD Size
* Memory Size
* CPU Speed


## CPU

### Speed
The speed of the CPU displayed as a value measured in GHz.  At this moment, we will not allow anything else for simplicity.

#### Example
* 1 ghz
* 2ghz
* 1.6GHz
* 3.5 Ghz
* 2.33Ghz

#### Regex 
`(\d+\.\d*)\s*ghz`

#### Details names
* Newegg
    + CPU Type
    + CPU Speed
    + CPU Support

### Type

<!-- #### Example -->

<!-- #### Regex -->

#### Details names
* Newegg
    + CPU Type

### Cache

<!-- #### Example -->

<!-- #### Regex -->

#### Details names
* Newegg
    + CPU Support

<!-- CPU L2 Cache -->



## Display
### Size
#### Example
* 15.6"
* 11.6" IPS 
* 10.1" 
#### Regex
`(\d+\.?\d*)"`
#### Details names
* Newegg
    + Screen Size
    + Screen
### Wide Screen
<!-- Wide Screen Support -->
### Resolution
#### Example
* 1366 x 768
#### Regex
`(\d+\s*x\s*\d+)`
#### Details names
* Newegg
    + Resolution
### Features
<!-- LCD Features -->





## Operating Systems
### Operating System
<!-- Operating System -->

## Graphics
### Name
<!-- Graphics Card -->
<!-- GPU/VPU -->
### Memory
<!-- Video Memory -->
### Type
<!-- Graphic Type -->
### Spec
<!-- Memory Spec -->
### Total Slots
<!-- Memory Slot (Total) -->
### Available Slots
<!-- Memory Slot (Available) -->

## Hard Drive
### Size
#### Example
* 320GB
* 500GB
* 64GB SSD
* 500GB
* 1TB
#### Regex
`(\d+)(gb|tb)`
#### Details name
<!-- Hard Disk -->
<!-- HDD -->
### RPM
<!-- HDD RPM -->
### Interface
<!-- HDD Interface -->

## Memory
### Size
#### Example
2GB
4GB
2GB DDR3
6GB
8GB
#### Regex
`(\d+)(gb)`
#### Details names
* Newegg
    + Memory Size
    + Memory
### Speed
<!-- Memory Speed -->
### Type
<!-- Memory Type -->
### Max Supported
<!-- Max Memory Supported -->

## Communications
### Type
<!-- Communication -->
### WLAN
<!-- WLAN -->
### LAN
<!-- LAN -->

## Ports
### HDMI
<!-- HDMI -->
### USB
<!-- USB -->
### Video Port
<!-- Video Port -->
### Audio Ports
<!-- Audio Ports -->
### Card Reader
<!-- Card Reader -->

## Supplemental Drive
### Webcam
<!-- Webcam -->

## Power
### Battery
<!-- Battery -->
### Life
<!-- Battery Life -->
### AC Adapter
<!-- AC Adapter -->

## Warranty
### Accidental
<!-- Accidental Damage Warranty -->

## Model
### Brand
<!-- Brand -->
### Model
<!-- Model# -->
### Series
<!-- Series -->
### Part
<!-- Part# -->
### Item
<!-- Item# -->

## General
### Color
<!-- Color -->
### Weight
<!-- Weight -->
### Style
<!-- Style -->
### Type
<!-- Type -->
### Usage
<!-- Usage -->
### Other
<!-- Other Features -->
### Bluetooth
<!-- Bluetooth -->
### Dimensions
<!-- Dimensions -->
### Chipset
<!-- Chipset -->
### Audio
<!-- Audio -->
### Speaker
<!-- Speaker -->
### Touchpad
<!-- Touchpad -->
### Keyboard
<!-- Keyboard -->


## Optical Drive
### Type
<!-- Optical Drive -->
<!-- Optical Drive Type -->
<!-- Optical Drive Spec -->






<!-- ###

#### Example

#### Regex

#### Details names -->