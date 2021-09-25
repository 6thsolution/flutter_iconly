
import 'package:example/src/data/icon_detail.dart';
import 'package:flutter/material.dart';

const childAnimationDuration = Duration(milliseconds: 350);


class IconItem extends StatefulWidget {
  const IconItem({
    Key? key,
    required this.icon,
    this.selected = false,
  }) : super(key: key);

  final IconlyDetail icon;
  final bool selected;

  @override
  _IconItemState createState() => _IconItemState();
}

class _IconItemState extends State<IconItem> {
  bool isHovered = false;

  EdgeInsets get margin =>
      isHovered ? const EdgeInsets.all(4) : const EdgeInsets.all(8);

  @override
  void didUpdateWidget(covariant IconItem oldWidget) {
    if (widget.icon != oldWidget.icon) {
      isHovered = false;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final decoration = widget.selected
        ? BoxDecoration(
            gradient:
                LinearGradient(colors: [scheme.primary, scheme.primaryVariant]),
            boxShadow: [
              BoxShadow(
                color: scheme.primaryVariant,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(18),
          )
        : BoxDecoration(
            gradient:
                LinearGradient(colors: [scheme.onPrimary, Colors.grey[200]!]),
            border: Border.all(
              color: scheme.primaryVariant.withOpacity(.3),
              width: 1.8,
            ),
            borderRadius: BorderRadius.circular(18),
          );

    return MouseRegion(
      onEnter: (_) => entered(true),
      onExit: (_) => entered(false),
      child: AnimatedContainer(
        duration: childAnimationDuration,
        curve: Curves.ease,
        margin: margin,
        decoration: decoration,
        child: Icon(
          widget.icon.iconData,
          color: widget.selected ? scheme.onPrimary : scheme.primary,
        ),
      ),
    );
  }

  void entered(bool isEntered) {
    if (isHovered != isEntered) {
      setState(() {
        isHovered = isEntered;
      });
    }
  }
}