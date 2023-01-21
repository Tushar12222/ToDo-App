import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:elegant_notification/elegant_notification.dart';

import 'package:loginapp/todocards.dart';
import 'package:loginapp/dialogbox.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

final _task = TextEditingController();

List todoList = [];

// Future createTask(String task) async {
//   await FirebaseFirestore.instance.collection('Users').add(
//     {
//       'task': task,
//     },
//   );
// }

//List<String> docIds = [];

// Future getdocId() async {
//   await FirebaseFirestore.instance.collection('Users').get().then(
//         (snapshot) => snapshot.docs.forEach(
//           (document) {
//             docIds.add(document.reference.id);
//           },
//         ),
//       );
// }

//int len = docIds.length;

class _ToDoState extends State<ToDo> {
  final _myBox = Hive.box('Tasks');
  Showdialogfortodo obj = Showdialogfortodo(task: _task);
  void createInitialData() {
    todoList = [
      ['Add your first task!', false],
    ];
  }

  void loadData() {
    todoList = _myBox.get('TODOLIST');
  }

  void updateDataBase() {
    _myBox.put('TODOLIST', todoList);
  }

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      createInitialData();
    } else {
      loadData();
    }

    super.initState();
  }

  Future addtoList() async {
    await showDialog(
        context: context,
        builder: (context) => Showdialogfortodo(
              task: _task,
            ));
  }

  void checkboxchanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
    updateDataBase();
  }

  void deleteTask(int index) async {
    setState(() {
      todoList.removeAt(index);
    });
    ElegantNotification.success(
      title: Text('Task Deleted!'),
      description: Text('Task has been successfully removed.'),
      animationDuration: Duration(seconds: 1),
    ).show(context);
    updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            addtoList();
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Tasks',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 650,
                  width: 300,
                  child: RefreshIndicator(
                    child: ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        return Todocards(
                          taskname: todoList[index][0],
                          taskcompleted: todoList[index][1],
                          onChanged: (value) => checkboxchanged(value, index),
                          deletefunction: (context) => deleteTask(index),
                        );
                      },
                    ),
                    onRefresh: () {
                      return Future.delayed(Duration(seconds: 1), () {
                        setState(() {});

                        loadData();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
