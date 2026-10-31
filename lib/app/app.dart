import 'package:material_ui/material_ui.dart';

import 'package:mexy_laziness/app/theme/app_theme.dart';
import 'package:mexy_laziness/core/ui/responsive/responsive_shell.dart';

/// 应用根组件：只做「装配」——主题、壳、路由。
///
/// 业务页面不要从这里直接引用，页面由 [ResponsiveShell] 及各 feature 负责。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MexyLaziness',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const ResponsiveShell(),
    );
  }
}
