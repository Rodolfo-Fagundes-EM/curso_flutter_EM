import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:todo_curso/data/models/todo_model.dart';

class TodoDataSource {
  static const _boxName = 'todo';

  Future<Box<TodoModel>> _getBox() async {
    try {
      if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
        Hive.registerAdapter(TodoModelAdapter());
      }

      if (Hive.isBoxOpen(_boxName)) {
        return Hive.box(_boxName);
      }

      return await Hive.openBox<TodoModel>(_boxName);
    } catch (e, stackTrace) {
      log(
        e.toString(),
        name: 'TodoDataSource._getBox',
        time: DateTime.now(),
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<TodoModel> insert(TodoModel model) async {
    final _box = await _getBox();
    model.id = await _box.add(model);
    return await update(model);
  }

  Future<TodoModel> update(TodoModel model) async {
    final _box = await _getBox();
    await _box.put(model.id, model);
    return model;
  }

  Future<List<TodoModel>> getAll() async {
    final _box = await _getBox();
    return _box.values.toList();
  }

  Future<bool> delete(int id) async {
    final _box = await _getBox();
    try {
      _box.delete(id);
      return true;
    } catch (e) {
      log(
        e.toString(),
        name: 'TodoDataSource.delete',
        time: DateTime.now(),
      );
      return false;
    }
  }
}
