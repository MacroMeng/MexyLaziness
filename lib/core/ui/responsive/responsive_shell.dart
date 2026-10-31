import 'package:material_ui/material_ui.dart';
import 'package:material_3_expressive/material_3_expressive.dart' as m3e;

import 'package:mexy_laziness/features/fragments/presentation/pages/fragments_page.dart';
import 'package:mexy_laziness/features/loops/presentation/pages/loops_page.dart';
import 'package:mexy_laziness/features/today/presentation/pages/today_page.dart';

/// 响应式外壳：负责「导航结构」，不负责页面内容。
///
/// - 窄屏（< 600）：NavigationBar + 单页
/// - 宽屏（>= 600）：NavigationRail + 单页
///
/// 页面本身只返回 body 内容，Scaffold / AppBar 由这里提供。
class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

typedef _Destination = ({
  IconData icon,
  IconData selectedIcon,
  String label,
  Widget page,
});

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _pageIndex = 0;

  static const List<_Destination> _destinations = [
    (
      icon: Icons.calendar_month_outlined,
      selectedIcon: Icons.calendar_month,
      label: 'Today',
      page: TodayPage(),
    ),
    (
      icon: Icons.widgets_outlined,
      selectedIcon: Icons.widgets,
      label: '碎片',
      page: FragmentsPage(),
    ),
    (
      icon: Icons.refresh,
      selectedIcon: Icons.refresh,
      label: '循环',
      page: LoopsPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 600;
        final body = _destinations[_pageIndex].page;

        return Scaffold(
          appBar: _buildAppBar(context),
          body: useRail
              ? Row(
                  children: [
                    _buildRail(context),
                    const VerticalDivider(width: 1),
                    Expanded(child: body),
                  ],
                )
              : body,
          bottomNavigationBar: useRail ? null : _buildNavigationBar(),
        );
      },
    );
  }

  m3e.M3EAppBar _buildAppBar(BuildContext context) {
    final colorScheme = m3e.M3ETheme.of(context).colorScheme;
    return m3e.M3EAppBar.top(
      title: const Text('MexyLaziness'),
      centerTitle: true,
      backgroundColor: colorScheme.surfaceContainer,
    );
  }

  m3e.M3ENavigationRail _buildRail(BuildContext context) {
    final colorScheme = m3e.M3ETheme.of(context).colorScheme;
    return m3e.M3ENavigationRail(
      sections: [
        m3e.M3ENavigationRailSection(
          destinations: [
            for (final dest in _destinations)
              m3e.M3ENavigationRailDestination(
                icon: Icon(dest.icon),
                selectedIcon: Icon(dest.selectedIcon),
                label: dest.label,
              ),
          ],
        ),
      ],
      selectedIndex: _pageIndex,
      onDestinationSelected: _onDestinationSelected,
      background: colorScheme.surfaceContainer,
    );
  }

  m3e.M3ENavigationBar _buildNavigationBar() {
    return m3e.M3ENavigationBar(
      selectedIndex: _pageIndex,
      onDestinationSelected: _onDestinationSelected,
      destinations: [
        for (final dest in _destinations)
          m3e.M3ENavigationBarDestination(
            icon: Icon(dest.icon),
            selectedIcon: Icon(dest.selectedIcon),
            label: dest.label,
          ),
      ],
    );
  }

  void _onDestinationSelected(int index) {
    setState(() => _pageIndex = index);
  }
}
