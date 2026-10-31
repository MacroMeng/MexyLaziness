import 'package:material_ui/material_ui.dart';

/// 循环页。
///
/// 约定：page 只返回内容，不带 Scaffold / AppBar（由 ResponsiveShell 提供）。
class LoopsPage extends StatelessWidget {
  const LoopsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('循环'));
  }
}
