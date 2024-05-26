class Todo {
  String? id;
  String? todoText;
  late bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> TodoList() {
    return [
      Todo(id: '01', todoText: 'morning exercise', isDone: true),
      Todo(id: '01', todoText: 'check mails'),
      Todo(id: '01', todoText: 'working', isDone: true),
      Todo(id: '01', todoText: 'dinner time'),
    ];
  }
}