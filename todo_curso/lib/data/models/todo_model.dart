import 'package:hive/hive.dart';
import 'package:todo_curso/data/models/type_id_hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: TypeIdHive.todo)
class TodoModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool check;

  TodoModel({
    required this.id,
    required this.title,
    required this.check,
  });
}
