import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './todo.dart';

class DatabaseConnect {
  Database? _database;

  // create a getter and open a connection to database
  Future<Database> get database async {
    // this is the location of our database in device.
    final dbpath = await getDatabasesPath();
    // this is the name of the database.
    const dbname = 'todo.db';

    // this joins the dbpath and dbname and creates a full path for database.
    final path = join(dbpath, dbname);

    // open the connection
    _database = await openDatabase(path, version: 1, onCreate: _createDb);

    // we will create the createDb function separatly.

    return _database!;
  }

  // the _create db function
  // this creates Tables in our database.

  Future<void> _createDb(Database db, int version) async {
    // make sure the columns we create in our table match the todo model fields.
    await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        creationDate TEXT,
        isChecked INTEGER
        )
    ''');
  }

  // function to add data into our database.
  Future<void> insertTodo(Todo todo) async {
    // get the connection to database.
    final db = await database;
    // insert the todo
    await db.insert(
      'todo', // the name of our table.
      todo.toMap(), // the function we created in our todo model
      conflictAlgorithm:
          ConflictAlgorithm.replace, // this will replace duplicate entries
    );
  }

  // function to delete a todo from our database.
  Future<void> deleteTodo(Todo todo) async {
    final db = await database;

    // delete the todo from our database.
    await db.delete(
      'todo', // name of our table.
      where: 'id == ?', // this checks for id in todo list
      whereArgs: [todo.id],
    );
  }

  // function to fetch all the todo data from our database
  Future<List<Todo>> getTodo() async {
    final db = await database;

    // query the database and save the todo as list of maps.
    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy: 'id DESC',
    );
    // this will order the list by id in descending order
    // so the latest todo will be displayed on top.

    // convert items from list of maps to list of todo.

    return List.generate(
      items.length,
      (index) => Todo(
        id: items[index]['id'],
        title: items[index]['title'],
        creationDate: DateTime.parse(items[index][
            'creationDate']), // this is a String, let's convert it into a DataTime object.
        isChecked:
            items[index]['isChecked'] == 1 ? true : false, // integer to bool
      ),
    );
  }
}
