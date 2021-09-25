import 'package:flutter/material.dart';

class IconlyDetail extends Comparable {
  IconlyDetail({
    required this.title,
    required this.type,
    required this.iconData,
  });

  final String title;
  final String type;
  final IconData iconData;

  @override
  String toString() => 'IconlyDetail{iconData: $iconData, type: $type, title: $title}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconlyDetail &&
          runtimeType == other.runtimeType &&
          iconData == other.iconData &&
          title == other.title &&
          type == other.type;

  @override
  int get hashCode => iconData.hashCode ^ title.hashCode ^ type.hashCode;

  @override
  int compareTo(other) => title.compareTo(other.title);
}
