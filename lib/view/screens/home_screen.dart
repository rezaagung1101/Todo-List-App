import 'package:flutter/material.dart';
import 'package:todo_app/model/data/task.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/view/screens/add_task_screen.dart';
import 'package:todo_app/view/screens/detail_task_screen.dart';
import 'package:todo_app/view/widgets/task_card_item.dart';
import 'package:todo_app/view/widgets/title_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> taskList = [
    // Task(id: 0, title: "title1", description: "description", dueDateMillis: 01),
    // Task(id: 1, title: "title2", description: "description", dueDateMillis: 01),
    Task(id: 2, title: "title3", description: "description", dueDateMillis: 01),
    // Task(id: 3, title: "title4", description: "description", dueDateMillis: 01),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const TitleText(
          text: Constants.appName,
          size: 20,
          color: Colors.black87,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: taskList.isNotEmpty
              ? _buildListContent(taskList)
              : const TitleText(
                  text: "You don't have any task",
                  color: Colors.black87,
                  size: 20,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListContent(List<Task> taskList) {
    return Column(
      children: [
        const TitleText(
          text: 'Your To-do List',
          size: 20,
          color: Colors.black87,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: TaskCardItem(
                      taskTitle: task.title,
                      dueDate: task.dueDateMillis.toString(),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailTaskScreen(task: task)));
                      }),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
