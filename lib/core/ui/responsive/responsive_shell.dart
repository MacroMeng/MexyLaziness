import 'package:material_ui/material_ui.dart';
import 'package:material_3_expressive/material_3_expressive.dart' as m3e;

import 'package:mexy_laziness/features/fragments/presentation/pages/fragments_page.dart';
import 'package:mexy_laziness/features/loops/presentation/pages/loops_page.dart';
import 'package:mexy_laziness/features/today/presentation/pages/today_page.dart';

/// 响应式外壳：负责「导航结构」，不负责页面内容。
///
/// - 窄屏（< 600）：NavigationBar + PageView
/// - 宽屏（>= 600）：NavigationRail + PageView
///
/// 页面切换由 [PageView] 驱动，导航栏只负责改 index。
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
  static const double IS_WIDE_BOUNDARY = 600;
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

  late final PageController _pageCtrl;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= IS_WIDE_BOUNDARY;

        return Scaffold(
          appBar: _buildAppBar(context),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (useRail) ...[
                _buildRail(context),
                const VerticalDivider(width: 1),
              ],
              Expanded(
                key: const ValueKey('shell-pages'),
                child: useRail ? _buildVerticalPages() : _buildHorizonalPages(),
              ),
            ],
          ),
          bottomNavigationBar: useRail ? null : _buildNavigationBar(),
        );
      },
    );
  }

  Widget _buildHorizonalPages() {
      return PageView(
        key: const PageStorageKey<String>('shell-pages'),
        controller: _pageCtrl,
        onPageChanged: _onPageChanged,
        children: [for (final dest in _destinations) dest.page],
      );
  }

  Widget _buildVerticalPages() {
    return Stack(
      fit: StackFit.expand,   // 让每页都拿到紧约束，否则 Center 之类的会缩成子组件大小
      children: [
        for (var i = 0; i < _destinations.length; i++)
          IgnorePointer(
            ignoring: i != _pageIndex,
            child: AnimatedOpacity(
              opacity: i == _pageIndex ? 1 : 0,
              duration: m3e.M3EMotion.medium2,
              curve: m3e.M3EMotion.standard,
              child: AnimatedScale(
                scale: i == _pageIndex ? 1 : 0.92,
                duration: m3e.M3EMotion.medium2,
                curve: m3e.M3EMotion.emphasizedDecelerate,
                child: TickerMode(
                  enabled: i == _pageIndex,
                  child: _destinations[i].page,
                ),
              ),
            ),
          ),
      ],
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
    if (index == _pageIndex) return;

    setState(() => _pageIndex = index);

    // 首帧之前 / 极端情况下 controller 还没 attach，直接调用会抛异常。
    if (_pageCtrl.hasClients) {
      _pageCtrl.animateToPage(
        index,
        duration: m3e.M3EMotion.medium2,              // 300ms
        curve: m3e.M3EMotion.emphasizedDecelerate,   // Cubic(0.05, 0.7, 0.1, 1)
      );
    }
  }

  /// 手指滑动：把 PageView 的当前页回写到导航栏高亮。
  void _onPageChanged(int index) {
    if (index == _pageIndex) return;
    setState(() => _pageIndex = index);
  }
}
