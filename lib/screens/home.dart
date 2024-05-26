import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example01/widgets/todo_item.dart';

import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Todo> todosList = Todo.TodoList();
  List<Todo>_foundToDo=[];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo=todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for(Todo todo in _foundToDo) // bastığında üstüne çiziyor veya kaldırıyor çizgiyi
                        TodoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.lightBlue,
                        offset: Offset(0.0,0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                    ),
                  ),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20
                ),
                child: ElevatedButton(
                  onPressed: () {
                    addToDoItem(_todoController.text);
                  },
                  child: Text(
                    '+',
                    style: TextStyle(
                        fontSize: 40
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(40, 60),
                    elevation: 10,
                  ),
                ),
              )
            ]),
          )],
      ),
    );
  }
  // bastığında üstüne çiziyor veya kaldırıyor çizgiyi
  void _handleToDoChange(Todo todo){
    setState(() {
      todo.isDone =! todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void addToDoItem(String toDo) {
   setState(() {
     todosList.add(Todo(
         id: DateTime.now().microsecondsSinceEpoch.toString(),
         todoText: toDo
     ));
   });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }
  
  Widget searchBox() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: Colors.grey,size: 20),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth:  25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRect(
              child: Image.asset('images/profilefoto.jpg'),
            ),
          )
        ],
      ),
    );
  }
}
