import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  TodoItem({super.key, required this.todo, this.onToDoChanged, this.onDeleteItem});
  final Todo todo;
  final onToDoChanged;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white70,
        leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank_outlined,
            color: Colors.lightBlue),
        title: Text(
            todo.todoText!,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: todo.isDone? TextDecoration.lineThrough : null,
            ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin:EdgeInsets.symmetric(vertical: 12),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete_forever),
            onPressed: () {
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
