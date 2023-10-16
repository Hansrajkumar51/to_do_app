import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFuction,
  });

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFuction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFuction,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              //task checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: const Color.fromARGB(255, 69, 69, 69),
              ),

              //task name
              Text(
                taskName,
                style: TextStyle(
                    color: Colors.white,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
