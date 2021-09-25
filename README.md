## Iconly
<div align="center">
<img width="80%" src="https://raw.githubusercontent.com/6thsolution/flutter_iconly/main/assets/image/transparent_banner.png" />
</div>
Flutter package for using [Iconly Icons](https://iconly.pro/ "Iconly Website"). Iconly is totally free, and you can use this package to bring these awesome icons to your Flutter project. 

This package has made from Iconly v2.3 version. following sets are currently available in  this package:

- Light
- Bold
- Broken

**note:** since Flutter does not support multicolor Icons, we can not support **Bulk** Icon set. but we are going to implement that in the future.

## installation:
Add the following line to your `pubspec.yaml` file, under the `dependencies:` section:

``` yaml
dependencies:
  font_awesome_flutter: <latest_version>
```

## Usage 
``` dart
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconlyWidget extends StatelessWidget {

  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(IconlyLight.search), 
      onPressed: () { print("Pressed"); }
     );
  }
  
}
```
