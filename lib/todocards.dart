import 'package:flutter/material.dart';
import 'package:loginapp/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todocards extends StatefulWidget {
  final String taskname;
  final bool taskcompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deletefunction;

  Todocards(
      {super.key,
      required this.taskname,
      required this.taskcompleted,
      required this.onChanged,
      required this.deletefunction});

  @override
  State<Todocards> createState() => _TodocardsState();
}

class _TodocardsState extends State<Todocards> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            children: [
              SlidableAction(
                onPressed: widget.deletefunction,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(12),
              )
            ],
            motion: StretchMotion(),
          ),
          child: Container(
            color: Colors.orange,
            width: 300,
            height: 50,
            child: Card(
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: widget.taskcompleted,
                      onChanged: widget.onChanged,
                      activeColor: Colors.green,
                    ),
                    Text(
                      widget.taskname,
                      style: TextStyle(
                        fontSize: 18,
                        decoration: widget.taskcompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
