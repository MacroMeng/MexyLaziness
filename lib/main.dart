import 'package:material_ui/material_ui.dart';
import 'package:material_3_expressive/material_3_expressive.dart' as m3e;
import 'package:m3e_core/m3e_core.dart' as m3ec;

void main() {
  runApp(const MyApp());
}

final colorSchemeConfig = (
  seedColor: Colors.pink,
  variant: m3ec.M3EColorVariant.vibrant
);
final colorSchemes = (
  light: m3ec.M3EColorScheme.light(
    seedColor: colorSchemeConfig.seedColor, variant: colorSchemeConfig.variant
  ),
  dark: m3ec.M3EColorScheme.dark(
    seedColor: colorSchemeConfig.seedColor, variant: colorSchemeConfig.variant
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ValueChanged<int> get onDestinationSelected => (_){};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MexyLaziness',
      theme: ThemeData(
        colorScheme: colorSchemes.light,
        fontFamily: 'Google Sans Flex',
        fontFamilyFallback: ['MiSans', 'Noto Sans SC', 'Noto Sans CJK SC', 'Microsoft YaHei UI']
      ),
      darkTheme: ThemeData(
        colorScheme: colorSchemes.dark,
        fontFamily: 'Google Sans Flex',
        fontFamilyFallback: ['MiSans', 'Noto Sans SC', 'Noto Sans CJK SC', 'Microsoft YaHei UI']
      ),
      home: const ResponsiveShell(),
    );
  }
}

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _pageIndex = 0;

  static const List<({IconData icon, IconData selectedIcon, String label})> _destinations = [
    (icon: Icons.calendar_month_outlined, selectedIcon: Icons.calendar_month, label: 'Today'),
    (icon: Icons.widgets_outlined, selectedIcon: Icons.widgets, label: '碎片'),
    (icon: Icons.refresh, selectedIcon: Icons.refresh, label: '循环'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final colorScheme = m3e.M3ETheme.of(context).colorScheme;
        final useRail = constraints.maxWidth >= 600;
        final appbar = m3e.M3EAppBar.top(
          title: Text('MexyLaziness'),
          centerTitle: true,
          backgroundColor: colorScheme.surfaceContainer,
        );

        if (useRail) {
          return Scaffold(
            appBar: appbar,
            body: Row(
              children: [
                m3e.M3ENavigationRail(
                  sections: [m3e.M3ENavigationRailSection(
                    destinations: _destinations.map( (dest) {
                        return m3e.M3ENavigationRailDestination(
                          icon: Icon(dest.icon),
                          selectedIcon: Icon(dest.selectedIcon),
                          label: dest.label
                        );
                      }
                    ).toList()
                  )],
                  selectedIndex: _pageIndex,
                  onDestinationSelected: (i) {
                    setState(() {
                      _pageIndex = i;
                    });
                  },
                  background: colorScheme.surfaceContainer,
                ),
                const VerticalDivider(width: 1),
                Expanded(child: _buildPage(context))
              ]
            )
          );
        } else {
          return Scaffold(
            appBar: appbar,
            body: _buildPage(context),
            bottomNavigationBar: m3e.M3ENavigationBar(
              selectedIndex: _pageIndex,
              onDestinationSelected: (i) => setState(() => _pageIndex = i),
              destinations: _destinations.map((dest) {
                return m3e.M3ENavigationBarDestination(
                  icon: Icon(dest.icon),
                  selectedIcon: Icon(dest.selectedIcon),
                  label: dest.label
                );
              }).toList(),
            ),
          );
        }
      }
    );
  }

  Widget _buildPage(BuildContext context) {
    final colorScheme = m3e.M3ETheme.of(context).colorScheme;
    return Center(child:
      Text(
        "You're on #$_pageIndex called ${_destinations[_pageIndex].label}",
      )
    );
  }
}

