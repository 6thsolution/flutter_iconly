import 'package:example/src/data/icon_detail.dart';
import 'package:example/src/data/icons.dart';
import 'package:example/widget/icon_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';

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
        colorScheme: const ColorScheme.light(
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

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final lightData = _filterIcons(lightIcons);
    final boldData = _filterIcons(boldIcons);
    final brokenData = _filterIcons(brokenIcons);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_selectedIcon == null) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                const SnackBar(
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
          children: const [
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
            SliverAppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              expandedHeight: 230,
              pinned: false,
              automaticallyImplyLeading: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                titlePadding: const EdgeInsets.all(16),
                background: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/image/banner.png'),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: CupertinoSearchTextField(
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                ),
              ),
            ),
            if (lightData.isNotEmpty) ...[
              const SliverPadding(
                padding: EdgeInsets.only(top: 24.0),
                sliver: SliverToBoxAdapter(child: SectionTitle(title: 'Light')),
              ),
              IconSliverGrid(
                iconDetails: lightData,
                selectedIcon: _selectedIcon,
                onTap: (tappedIcon) {
                  setState(() {
                    if (_selectedIcon == tappedIcon) {
                      _selectedIcon = null;
                    } else {
                      _selectedIcon = tappedIcon;
                    }
                  });
                },
              ),
            ],
            if (boldData.isNotEmpty) ...[
              const SliverPadding(
                padding: EdgeInsets.only(top: 12.0),
                sliver: SliverToBoxAdapter(child: SectionTitle(title: 'Bold')),
              ),
              IconSliverGrid(
                iconDetails: boldData,
                selectedIcon: _selectedIcon,
                onTap: (tappedIcon) {
                  setState(() {
                    if (_selectedIcon == tappedIcon) {
                      _selectedIcon = null;
                    } else {
                      _selectedIcon = tappedIcon;
                    }
                  });
                },
              ),
            ],
            if (brokenData.isNotEmpty) ...[
              const SliverPadding(
                padding: EdgeInsets.only(top: 12.0),
                sliver: SliverToBoxAdapter(child: SectionTitle(title: 'Bulk')),
              ),
              IconSliverGrid(
                iconDetails: brokenData,
                selectedIcon: _selectedIcon,
                onTap: (tappedIcon) {
                  setState(() {
                    if (_selectedIcon == tappedIcon) {
                      _selectedIcon = null;
                    } else {
                      _selectedIcon = tappedIcon;
                    }
                  });
                },
              ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  List<IconlyDetail> _filterIcons(List<IconlyDetail> baseData) {
    return baseData
        .where((icon) => _searchText.isEmpty || icon.title.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
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
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
        const Divider(),
      ],
    );
  }
}
