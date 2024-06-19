import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/widgets/body_text.dart';
import 'package:todo_app/view/widgets/title_text.dart';

class TaskCardItem extends StatelessWidget {
  const TaskCardItem(
      {super.key,
      required this.taskTitle,
      required this.dueDate,
      required this.onTap});

  final String taskTitle;
  final String dueDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.blue[100],
      borderRadius: BorderRadius.circular(10),
      child: Card.filled(
        color: Colors.white,
        elevation: 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TitleText(
                  text: taskTitle,
                  size: 16,
                  color: Colors.black87,
                ),
              ),
              BodyText(
                text: dueDate,
                size: 14,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
