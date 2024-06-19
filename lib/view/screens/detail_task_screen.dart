import 'package:flutter/material.dart';
import 'package:todo_app/model/data/task.dart';

class DetailTaskScreen extends StatefulWidget {
  const DetailTaskScreen({super.key, required this.task});

  final Task task;

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Detail ${widget.task.id}, ${widget.task.title}"),
      ),
    );
  }
}
