import 'package:flutter/material.dart';
import 'package:todo_curso/data/datasource/todo_datasource.dart';
import 'package:todo_curso/data/models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _todoController = TextEditingController();

  List<TodoModel> _todoList = [];
  late TodoModel _lastRemoved;
  late int _lastRemovedPos;

  final TodoDataSource _todoDataSource = TodoDataSource();

  @override
  void initState() {
    super.initState();
    _getAll();
  }

  Future<void> _getAll() async {
    _todoList = await _todoDataSource.getAll();
    setState(() {});
  }

  void _addTodo() async {
    TodoModel newTodo = TodoModel(
      id: 0,
      title: _todoController.text,
      check: false,
    );
    _todoList.add(await _todoDataSource.insert(newTodo));
    setState(() {
      _todoController.clear();
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _todoList.sort((a, b) {
        if (a.check && !b.check) return 1;
        if (!a.check && b.check) return -1;
        return 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tarefas'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                        labelText: 'Nova tarefa',
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTodo,
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      textStyle: const TextStyle(color: Colors.white)),
                  child: const Text('ADD'),
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: _todoList.length,
                itemBuilder: _buildItem,
              ),
              onRefresh: _refresh,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(context, index) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      child: CheckboxListTile(
        title: Text(_todoList[index].title),
        value: _todoList[index].check,
        onChanged: (value) {
          setState(() {
            _todoList[index].check = value ?? false;
            _todoDataSource.update(_todoList[index]);
          });
        },
        secondary: CircleAvatar(
          child: Icon(_todoList[index].check ? Icons.check : Icons.error),
        ),
      ),
      onDismissed: (value) {
        _lastRemoved = _todoList[index];
        _lastRemovedPos = index;
        _todoList.removeAt(index);
        _todoDataSource.delete(_lastRemoved.id);

        final snack = SnackBar(
          content: Text("Tarefa \"${_lastRemoved.title}\" removida"),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () {
              setState(() {
                _todoList.insert(_lastRemovedPos, _lastRemoved);
                _todoDataSource.insert(_lastRemoved);
              });
            },
          ),
          duration: const Duration(seconds: 3),
        );

        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      },
    );
  }
}
