GIGABYTE Ambient LED control scripts for Linux
==============================================

These scripts allow you to configure the Ambient LEDs found on some GIGABYTE motherboards.

---

Included scripts:
- `rear_panel_led.sh`
  - configures the rear panel LEDs
- `audio_led_mode.sh`
  - controls the Audio LED mode
  - only works when using the on-board sound chip

These scripts have to be executed as root!\\
Your kernel must be able to configure the gpio-it87 chip (CONFIG_GPIO_IT87 has to be enabled and gpio-it87 has to be loaded), otherwise these scripts won't work.

---

These scripts assume that the LEDs are connected to an ITE Super IO chipset.  
Support for the ITE 8620 / 8628 GPIO controller is available with Linux 4.7.  
An out-of-tree version (for older kernels) with the patch applied can be found here: [https://github.com/xdarklight/gpio-it87](xdarklight/gpio-it87).


**Motherboard support:**

| Model                        | Color configuration | Rear Panel LEDs (on/off) | Audio LEDs (on/off) | Beat/Pulse mode              |
| ---------------------------- | ------------------- | ------------------------ | ------------------- | ---------------------------- |
| GA-Z170X-Gaming 7 (rev. 1.0) | :x:                 | :white_check_mark:       | :white_check_mark:  | untested (most probably: no) |
| GA-Z170X-UD5 TH (rev 1.0)    | :heavy_minus_sign:  | :white_check_mark:       | :white_check_mark:  | untested (most probably: no) |
| GA-H170-Gaming 3 (rev. 1.0)  | :heavy_minus_sign:  | :white_check_mark:       | :white_check_mark:  | untested (most probably: no) |
| GA-H170M-D3H (rev. 1.0)      | :heavy_minus_sign:  | :heavy_minus_sign:       | :white_check_mark:  | :heavy_minus_sign:           |

icon meanings:
:x: = not supported by this script (but support by the hardware) 
:white_check_mark: = supported by this script 
:heavy_minus_sign: = not supported by the hardware 

:information_source: please create a ticket if your board is not yet supported or you want to report that it is supported but not listed here.

License
-------

May be freely distributed under the MIT license

See `LICENSE` file.

Copyright (c) 2016-2017 Martin Blumenstingl
