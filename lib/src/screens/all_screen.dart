import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos_application/src/database/todo_adapter.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box("todos").listenable(),
        builder: (context, box, _) {
          Box todosBox = Hive.box("todos");
          return ListView.builder(
              padding: const EdgeInsets.only(
                  bottom: kFloatingActionButtonMargin + 48),
              itemCount: todosBox.length,
              itemBuilder: (context, index) {
                final todo = todosBox.getAt(index) as ToDo;
                return Card(
                  color: (todo.status) ? Colors.transparent : Color(0xfdf1f1fc),
                  child: ListTile(
                    title: Text(
                      todo.title,
                      style: TextStyle(
                          decoration: (todo.status)
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                    trailing: Checkbox(
                        value: todo.status,
                        onChanged: (value) {
                          Hive.box("todos")
                              .putAt(index, ToDo(todo.title, !todo.status));
                        }),
                    onLongPress: () {
                      _ackAlert(context, index, todosBox);
                    },
                  ),
                );
              });
        });
  }

  Future _ackAlert(BuildContext context, int index, Box<dynamic> contactsBox) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete task ?"),
          actions: [
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('DELETE'),
              onPressed: () {
                contactsBox.deleteAt(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
