# impeller_performance

Simple flutter project that demonstrates render time differences betweek skia and impeller when using flutter_svg and lottie libraries.

## Getting Started

Toggle the value of `FLTEnableImpeller` in `Info.plist` to control which rendering engine is used.

Change the value of `SvgChoice svgChoice` in `main.dart` to toggle which svgs are rendered (the project includes a few simple ones). 
