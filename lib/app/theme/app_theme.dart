import 'package:material_ui/material_ui.dart';

import 'package:mexy_laziness/app/theme/app_color_schemes.dart';

/// 全局主题：字体、配色、组件默认值都集中在这里。
abstract final class AppTheme {
  static const String fontFamily = 'Google Sans Flex';

  static const List<String> fontFamilyFallback = [
    'MiSans',
    'Noto Sans SC',
    'Noto Sans CJK SC',
    'Microsoft YaHei UI',
  ];

  static final ThemeData light = _build(appColorSchemes.light);
  static final ThemeData dark = _build(appColorSchemes.dark);

  static ThemeData _build(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }
}
