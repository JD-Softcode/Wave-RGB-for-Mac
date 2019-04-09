# WaveRGB_Mac

This is the macOS version of my Wave RGB app. It creates waves of light that ripple away from each key as you type. The size and color of each ring is user configurable. In the Windows app, those settings are controlled by LGS' Applet Configuration interface, however the API is not working in the beta macOS SDK for RGB LED so a separate interface is implemented in this code.

Download the executable from www.jdsoftcode.net

This archive does not include the LGS dynamic library (framework). It's available on request from Logitech developer support.

## Version 1.3
* Reduced CPU usage while idle by 65%
* Modified drawing code to make ring size and thickness work intuitively
* Expanded legal range of ring delay and lifetime up to 300 cycles
