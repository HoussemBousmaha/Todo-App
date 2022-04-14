import 'package:flutter/material.dart';
import 'package:todo/models/db.dart';
import '../models/todo.dart';
import '../widgets/user_input.dart';
import '../widgets/todo_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var db = DatabaseConnect();

  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  void deleteItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBFF),
      appBar: AppBar(
        title: const Text('Simple todo app'),
      ),
      body: Column(
        children: [
          TodoList(insertFunction: addItem, deleteFunction: deleteItem),
          // const TodoCard(),
          UserInput(insertFunction: addItem),
        ],
      ),
    );
  }
}
