import 'package:flutter/material.dart';

import '../models/todo.dart';

class UserInput extends StatelessWidget {
  UserInput({
    Key? key,
    required this.insertFunction,
  }) : super(key: key);

  final textControoler = TextEditingController();
  final Function insertFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      color: const Color(0xFFDAB5FF),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                controller: textControoler,
                decoration: const InputDecoration(
                  hintText: 'add new todo',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              var myTodo = Todo(
                title: textControoler.text,
                creationDate: DateTime.now(),
                isChecked: false,
              );

              insertFunction(myTodo);
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: const Text(
                'add',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
