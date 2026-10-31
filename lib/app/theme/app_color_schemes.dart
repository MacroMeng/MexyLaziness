import 'package:material_ui/material_ui.dart';
import 'package:m3e_core/m3e_core.dart' as m3ec;

/// 配色来源配置：换主题只需要改这里。
const colorSchemeConfig = (
  seedColor: Colors.pink,
  variant: m3ec.M3EColorVariant.vibrant,
);

/// 明暗两套配色。
///
/// 注意：这是顶层 `final`，修改后热重载不会生效，需要热重启（R）。
final appColorSchemes = (
  light: m3ec.M3EColorScheme.light(
    seedColor: colorSchemeConfig.seedColor,
    variant: colorSchemeConfig.variant,
  ),
  dark: m3ec.M3EColorScheme.dark(
    seedColor: colorSchemeConfig.seedColor,
    variant: colorSchemeConfig.variant,
  ),
);
