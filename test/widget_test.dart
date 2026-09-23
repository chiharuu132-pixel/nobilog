import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobilog/main.dart';

void main() {
  testWidgets('のびログ 起動テスト', (WidgetTester tester) async {
    // ProviderScope でラップしてアプリを起動
    await tester.pumpWidget(
      const ProviderScope(
        child: NobilogApp(),
      ),
    );

    // アプリタイトルが表示されているか確認
    expect(find.text('のびログ (v1.1 Demo)'), findsOneWidget);
  });
}