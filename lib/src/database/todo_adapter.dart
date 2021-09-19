import 'package:hive/hive.dart';

part 'todo_adapter.g.dart';

@HiveType(typeId: 0)
class ToDo {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final bool status;

  ToDo(this.title, this.status);
}
