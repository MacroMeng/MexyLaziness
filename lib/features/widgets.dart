import 'package:material_ui/material_ui.dart';
import 'package:material_3_expressive/material_3_expressive.dart';


class WIPIndicator extends StatelessWidget {
  const WIPIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return M3EShapeContainer.cookie4Sided(
      color: M3ETheme.of(context).colorScheme.surfaceContainer,
      width: 300,
      height: 300,
      child: Column(
        spacing: 8,
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          M3ELoadingIndicator(variant: .contained),
          Text("WIP | 稍安勿躁", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontVariations: [FontVariation("ROND", 100)])),
          Text("功能仍在制作中。\n及时更新，获取最新功能。", textAlign: .center,)
        ],
      ),
    );
  }
}

