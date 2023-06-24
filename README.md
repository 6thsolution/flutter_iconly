## Iconly
[![pub](https://img.shields.io/pub/v/iconly.svg?color=blue&label=iconly)](https://pub.dev/packages/iconly)
<div align="center">
<img width="80%" src="https://raw.githubusercontent.com/6thsolution/flutter_iconly/main/assets/image/transparent_banner.png" />
</div>


Flutter package for using [Iconly](https://iconly.pro)  Icons. Iconly is totally free, and you can use this package to bring these awesome icons to your Flutter project. 

This package has made from Iconly v2.3 version. following sets are currently available in  this package:

- Light
- Bold
- Broken

**note:** since Flutter does not support multicolor Icons, we can not support **Bulk** Icon set. but we are going to implement that in the future.

## installation:
Add the following line to your `pubspec.yaml` file, under the `dependencies:` section:

``` yaml
dependencies:
  iconly: <latest_version>
```

## Usage 
``` dart
import 'package:iconly/iconly.dart';

class IconlyWidget extends StatelessWidget {

  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(IconlyLight.search), 
      onPressed: () { print("Pressed"); }
     );
  }
  
}
```
## Check the Example and find your Icon
We have created a sample project where you can find the icon you want and add it to your project. you can also run the example folder on mobile platforms and web. [Checkout This Link for more info.](https://6thsolution.github.io/flutter_iconly)
