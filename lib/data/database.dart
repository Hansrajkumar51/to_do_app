import 'package:hive_flutter/hive_flutter.dart';

class toDoDatabase {
  List toDoList = [];

  //reference the box
  final _myBox = Hive.box('mybox');

  //run this method if this is the first time opening this app
  void createInitialData() {
    toDoList = [
      [' tap on "+" Button', false],
      [' delete Tasks by swipe  Left ', false]
    ];
  }

  //load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
