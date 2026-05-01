import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/main.dart';

void main() {
  testWidgets('Recipe App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RecipeApp());

    // Verify that the title is present in the AppBar
    expect(find.text('Meal Categories'), findsOneWidget);
    
    // Verify that we are not showing the default counter text
    expect(find.text('0'), findsNothing);
  });
}
