import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todos_application/src/database/todo_adapter.dart';

class FloatingActionButtonCustom extends StatefulWidget {
  const FloatingActionButtonCustom({Key? key}) : super(key: key);

  @override
  _FloatingActionButtonCustomState createState() =>
      _FloatingActionButtonCustomState();
}

class _FloatingActionButtonCustomState
    extends State<FloatingActionButtonCustom> {
  bool errTexxt = false;
  //late String title, description;
  submitData(ToDo todo) async {
    final todosBox = Hive.box('todos');
    todosBox.add(todo);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: Key("floatingbutton"),
      onPressed: () {
        _ackAlert(context);
      },
      child: const Icon(
        Icons.add_outlined,
        size: 30,
      ),
      backgroundColor: Colors.blueAccent,
    );
  }

  Future _ackAlert(BuildContext context) {
    TextEditingController _task = new TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add task'),
          content: TextField(
            key: Key("Add_task_input"),
            decoration: InputDecoration(labelText: "Input new task here"),
            controller: _task,
          ),
          actions: [
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              key: Key("Add_task_button"),
              child: Text('SUBMIT'),
              onPressed: () {
                _submitOnClick(_task.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _submitOnClick(String task) {
    if (task.isNotEmpty) {
      final newToDo = ToDo(task, false);
      submitData(newToDo);
    }
  }
}
