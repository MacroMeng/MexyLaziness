import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:mexy_laziness/app/app.dart';
import 'package:mexy_laziness/core/ui/responsive/responsive_shell.dart';
import 'package:mexy_laziness/features/fragments/presentation/pages/fragments_page.dart';
import 'package:mexy_laziness/features/loops/presentation/pages/loops_page.dart';
import 'package:mexy_laziness/features/today/presentation/pages/today_page.dart';

void main() {
  testWidgets('ResponsiveShell 默认展示 Today，并可切换到其他页面', (tester) async {
    // 窄屏：使用 NavigationBar 分支
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(ResponsiveShell), findsOneWidget);
    expect(find.byType(TodayPage), findsOneWidget);
    expect(find.text('MexyLaziness'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.widgets_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(FragmentsPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pumpAndSettle();
    expect(find.byType(LoopsPage), findsOneWidget);
  });
}
