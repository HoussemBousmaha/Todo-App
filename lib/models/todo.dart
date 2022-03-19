class Todo {
  Todo({
    this.id,
    required this.title,
    required this.creationDate,
    required this.isChecked,
  });

  int? id; // optional id.
  final String title;
  final DateTime creationDate;
  bool isChecked;

  /*
   * to save the data to a db we must convert it into a Map
   * let's create a function for that
   */

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'creationDate': creationDate.toString(), // sqflite does not support string!
      'isChecked': isChecked ? 1 : 0, // sqflite does not support boolean!
    };
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, creationDate: $creationDate, isChecked: $isChecked';
  }
}
