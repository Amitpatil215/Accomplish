import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';

void main() {
  testWidgets("The MaterialApp widget in the tree",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets("The FlatButton is there in the widget tree",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: MyHomePage()));
    expect(find.byType(FlatButton), findsNWidgets(3));
  });

//we could run set of tests bu grouping them
  group("Create to do simulating", () {
    testWidgets('Add a todo', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MyHomePage(),
        ),
      );
      final textFinder = find.byKey(Key('todo-field'));
      final addButtonFinder = find.byKey(Key('add-todo'));

      await tester.enterText(textFinder, "A sample Todo");
      await tester.tap(addButtonFinder);

      await tester.pump();

      expect(find.text('A sample Todo'), findsOneWidget);
      expect(find.byKey(ValueKey('0-todo')), findsOneWidget);
      expect(find.byKey(Key("empty-todo")), findsNothing);
    });

    testWidgets("Remove a todo", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: MyHomePage(),
      ));

      final textFinder = find.byKey(Key('todo-field'));
      final addButtonFinder = find.byKey(Key('add-todo'));
      final removeTodoFinder = find.byKey(Key('gd-0'));

      await tester.enterText(textFinder, "A sample todo");
      await tester.tap(addButtonFinder);
      await tester.pump();

      expect(find.text("A sample todo"), findsOneWidget);

      await tester.longPress(removeTodoFinder);
      await tester.pump();

      expect(find.byKey(Key("empty-todo")), findsOneWidget);
      expect(find.byType(CheckboxListTile), findsNothing);
    });

    testWidgets("Finish a todo by checking checkbox",
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: MyHomePage(),
      ));

      final textFinder = find.byKey(Key('todo-field'));
      final addButtonFinder = find.byKey(Key('add-todo'));
      final todoFinder = find.byKey(Key('0-false-checkbox'));

      await tester.enterText(textFinder, "A sample todo");
      await tester.tap(addButtonFinder);
      await tester.pump();

      await tester.enterText(textFinder, "A another sample todo");
      await tester.tap(addButtonFinder);
      await tester.pump();

      await tester.tap(todoFinder);
      await tester.pump();

      expect(find.text("A sample todo"), findsOneWidget);
      expect(find.text("A another sample todo"), findsOneWidget);
      expect(find.byKey(ValueKey('0-true-checkbox')), findsOneWidget);
      expect(find.byKey(Key("empty-todo")), findsNothing);
    });
  });
}
