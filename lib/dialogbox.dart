import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:loginapp/todo.dart';

import 'package:another_flushbar/flushbar.dart';

import 'package:elegant_notification/elegant_notification.dart';

class Showdialogfortodo extends StatefulWidget {
  TextEditingController task = TextEditingController();
  Showdialogfortodo({super.key, required this.task});

  @override
  State<Showdialogfortodo> createState() => _ShowdialogfortodoState();
}

class _ShowdialogfortodoState extends State<Showdialogfortodo> {
  final task = TextEditingController();
  final _myBox = Hive.box('Tasks');

  void savetask() {
    setState(() {
      todoList.add([task.text.trim(), false]);
    });
    _myBox.put('TODOLIST', todoList);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber,
      title: Text(
        'Add your task',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: TextField(
        controller: task,
        decoration: InputDecoration(hintText: 'Enter the task'),
      ),
      actions: [
        SizedBox(width: 10),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        SizedBox(width: 100),
        TextButton(
          onPressed: () async {
            //await createTask(_task.text.trim());
            if (task.text != '') {
              setState(() {
                savetask();
              });
              
              Navigator.pop(context);
              ElegantNotification.success(
                title: Text('Task Created!'),
                description: Text('Task has been successfully saved'),
                animationDuration: Duration(seconds: 1),
              ).show(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(milliseconds: 2000),
                  content: Text('Task created! Pull down to load your tasks.'),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              Flushbar(
                backgroundColor: Colors.red,
                title: 'Invalid task',
                message: 'Please enter the task and then try adding it!',
                duration: Duration(seconds: 3),
              )..show(context);
            }
          },
          child: Text('Add'),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
