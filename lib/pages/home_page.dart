import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _mybox = Hive.box('mybox');

  toDoDatabase db = toDoDatabase();

  @override
  void initState() {
    //if this is the first time opening this app , then load default data
    if (_mybox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      //they already opened the app and data already exist
      db.loadData();
      db.updateDatabase();
    }
    super.initState();
  }

  //making text editing controller

  final _controller = TextEditingController();

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];

      db.updateDatabase();
    });
    db.updateDatabase();
  }

// save new task
  /* void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  onCancelbutton() {
    setState(() {
      Navigator.of(context).pop();
    });
  }
*/
  //create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: () {
              setState(() {
                db.toDoList.add([_controller.text, false]);
                _controller.clear();
                db.updateDatabase();
              });
              Navigator.of(context).pop();
              db.updateDatabase();
            },
            onCancel: () {
              Navigator.of(context).pop();
              db.updateDatabase();
            },
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 64, 64, 64),
      appBar: AppBar(
        title: const Text(
          'TO DO',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFuction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
