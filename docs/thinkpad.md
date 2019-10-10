## Running on a ThinkPad P43s

My laptop is a [ThinkPad P43s](https://www.lenovo.com/us/en/laptops/thinkpad/thinkpad-p/P43s/p/22WS2WPP43S).

The hardware specific configuration [lives here](../nixos/machines/nixpad.nix).

The following features are working great with no special setup:

* Wireless
* Backlight
* Trackpad
* Bluetooth
* Microphone
* Camera

### Issues

The main issue I have faced is poor thermal/battery performance. Things are at an acceptable level after:

* Installing thermald
* Installing throttled
* Installing tlp
* Disabling the NVIDIA GPU

I get about 4-5 hours of active wireless web use with Firefox which is ok but could definately be improved.

## Potential Improvements

### High priority

* Debugging battery consumption.
* CPU undervolting.

### Medium priority

* Allow enabling NVIDIA GPU for applications that need it.

### Low priorioty

* Fingerprint Scanner
