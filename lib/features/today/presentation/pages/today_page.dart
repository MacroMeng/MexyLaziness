import 'package:material_ui/material_ui.dart';

/// Today 页。
///
/// 约定：page 只返回内容，不带 Scaffold / AppBar（由 ResponsiveShell 提供）。
class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Today'));
  }
}
