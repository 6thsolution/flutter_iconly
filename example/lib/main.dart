import 'package:example/src/icon_detail.dart';
import 'package:example/src/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';

const childAnimationDuration = Duration(milliseconds: 350);

void main() {
  runApp(const IconlyExampleApp());
}

class IconlyExampleApp extends StatelessWidget {
  const IconlyExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iconly Example',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xff4e54c8),
          primaryVariant: Color(0xff8f94fb),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IconlyDetail? _selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_selectedIcon == null) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text('Select an Icon first. then you can copy it to clipboard'),
                ),
              );
          } else {
            final clipboardValue = '${_selectedIcon!.type}.${_selectedIcon!.title}';
            Clipboard.setData(
              ClipboardData(text: clipboardValue),
            );
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text('Icon Has been copied to clipboard: $clipboardValue'),
                ),
              );
          }
        },
        label: Row(
          children: [
            Icon(IconlyBroken.paper_plus),
            SizedBox(width: 4),
            Text('Copy'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverPadding(
              padding: const EdgeInsets.only(top: 12.0),
              sliver: SliverToBoxAdapter(child: SectionTitle(title: 'Light')),
            ),
            IconSliverGrid(
              iconDetails: lightIcons,
              selectedIcon: _selectedIcon,
              onTap: (tappedIcon) {
                print('selected: $tappedIcon');
                setState(() {
                  if (_selectedIcon == tappedIcon) {
                    _selectedIcon = null;
                  } else {
                    _selectedIcon = tappedIcon;
                  }
                });
              },
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 12.0),
              sliver: SliverToBoxAdapter(child: SectionTitle(title: 'Bold')),
            ),
            IconSliverGrid(
              iconDetails: boldIcons,
              selectedIcon: _selectedIcon,
              onTap: (tappedIcon) {
                print('selected: $tappedIcon');
                setState(() {
                  if (_selectedIcon == tappedIcon) {
                    _selectedIcon = null;
                  } else {
                    _selectedIcon = tappedIcon;
                  }
                });
              },
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 12.0),
              sliver: SliverToBoxAdapter(child: SectionTitle(title: 'Bulk')),
            ),
            IconSliverGrid(
              iconDetails: brokenIcons,
              selectedIcon: _selectedIcon,
              onTap: (tappedIcon) {
                print('selected: $tappedIcon');
                setState(() {
                  if (_selectedIcon == tappedIcon) {
                    _selectedIcon = null;
                  } else {
                    _selectedIcon = tappedIcon;
                  }
                });
              },
            ),
            SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}

class IconSliverGrid extends SliverGrid {
  IconSliverGrid({
    Key? key,
    required List<IconlyDetail> iconDetails,
    IconlyDetail? selectedIcon,
    ValueChanged<IconlyDetail>? onTap,
  }) : super(
          key: key,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 75,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final icon = iconDetails[index];
              return GestureDetector(
                onTap: onTap == null
                    ? null
                    : () {
                        onTap(icon);
                      },
                child: IconItem(
                  key: ValueKey(icon),
                  icon: icon,
                  selected: selectedIcon == icon,
                ),
              );
            },
            childCount: iconDetails.length,
          ),
        );
}

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

  EdgeInsets get margin => isHovered ? const EdgeInsets.all(4) : EdgeInsets.all(8);

  @override
  void didUpdateWidget(covariant IconItem oldWidget) {
    if (widget.icon != oldWidget.icon) {
      isHovered = false;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = Theme.of(context).colorScheme;

    final decoration = widget.selected
        ? BoxDecoration(
            gradient: LinearGradient(colors: [scheme.primary, scheme.primaryVariant]),
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
            gradient: LinearGradient(colors: [scheme.onPrimary, Colors.grey[200]!]),
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

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
