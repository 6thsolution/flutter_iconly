import 'package:flutter/cupertino.dart';

class IconlyDetail extends Comparable {
 IconlyDetail({
    required this.title,
    required this.iconData,
  });

  final String title;
  final IconData iconData;

  @override
  String toString() => 'IconlyDetail{iconData: $iconData, title: $title}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconlyDetail &&
          runtimeType == other.runtimeType &&
          iconData == other.iconData &&
          title == other.title;

  @override
  int get hashCode => iconData.hashCode ^ title.hashCode;

  @override
  int compareTo(other) => title.compareTo(other.title);
}
