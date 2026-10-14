import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

void main() {
  testWidgets('shows tooltip for an already laid out LayoutBuilder target', (
    tester,
  ) async {
    final controller = JustTheController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: JustTheTooltip(
              controller: controller,
              waitDuration: Duration.zero,
              fadeInDuration: Duration.zero,
              content: const Text('Credit information'),
              child: LayoutBuilder(
                builder: (context, constraints) =>
                    const SizedBox(width: 200, height: 100),
              ),
            ),
          ),
        ),
      ),
    );

    final shown = controller.showTooltip();
    await tester.pumpAndSettle();

    expect(await shown, isTrue);
    expect(find.text('Credit information'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
