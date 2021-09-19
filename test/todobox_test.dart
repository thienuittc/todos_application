import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:todos_application/src/database/todo_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox('todos');

  test("Todo box test", () async {
    Box todosBox = Hive.box("todos");

    /// add task
    var lenghtBox = todosBox.length;
    await todosBox.add(ToDo("NewTask", false));
    expect(todosBox.length, lenghtBox + 1);

    /// edit status task

    await todosBox.putAt(0, ToDo("NewTask", true));
    var todo = todosBox.getAt(0) as ToDo;
    expect(todo.title, "NewTask");
    expect(todo.status, true);

    await todosBox.putAt(0, ToDo("NewTask", false));
    todo = todosBox.getAt(0) as ToDo;
    expect(todo.title, "NewTask");
    expect(todo.status, false);

    /// delete task
    await todosBox.add(ToDo("NewTask", false));
    lenghtBox = todosBox.length;
    todosBox.deleteAt(0);
    expect(todosBox.length, lenghtBox - 1);
  });
}
