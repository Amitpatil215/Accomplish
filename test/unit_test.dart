import 'package:test/test.dart';

import '../lib/logic.dart';
import '../lib/model.dart';

void main() {
  TodoLogic todoLogic;

// Runs before every test
  setUp(() {
    todoLogic = TodoLogic();
  });

//Run once all the test exicuted
  tearDown(() {
    todoLogic.dispose();
  });

  test("Checko todo List is empty", () {
    TodoLogic todoLogic = TodoLogic();
    expect(todoLogic.list, <Todo>[]);
  });

  test("Add one todo by body", () {
    todoLogic.addTodo("Test todo");
    expect(todoLogic.list.first.body, "Test todo");
    expect(todoLogic.list.length, 1);
  });

  test("Add todo by todo", () {
    todoLogic.addTodoItem(Todo(
      body: "Wanna drink cofee",
      finished: false,
    ));
    expect(
        todoLogic.list.first,
        Todo(
          body: "Wanna drink cofee",
          finished: false,
        ));
  });

  test("Look at todo logic stream controller", () {
    todoLogic.addTodo('test');
    todoLogic.addTodo('another todo');
    expect(
        todoLogic.streamController.stream,
        emitsInOrder([
          [
            Todo(body: "test", finished: false),
            Todo(body: "another todo", finished: false)
          ],
          [
            Todo(body: "test", finished: false),
            Todo(body: "another todo", finished: false)
          ]
        ]));
  });

  test("Remove todo by index", () {
    todoLogic.addTodo("Hello");
    todoLogic.addTodo("Amit");
    todoLogic.removeTodoByIndex(0);

    expect(todoLogic.list.length, 1);
    expect(
        todoLogic.list.first,
        Todo(
          body: "Amit",
          finished: false,
        ));
  });

  test("Remove Finished todos", () {
    todoLogic.addTodo('Hello');
    todoLogic.addTodo('Folks');
    todoLogic.markItemFinished(1, true);
    todoLogic.removeFinishedTodos();
    expect(
        todoLogic.list.first,
        Todo(
          body: "Hello",
          finished: false,
        ));
  });

  test("Clear Todos", () {
    todoLogic.addTodo("Eat eggs");
    todoLogic.clearTodos();
    expect(todoLogic.list, []);
  });
}
