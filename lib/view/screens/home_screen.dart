import 'package:flutter/material.dart';
import 'package:todo_app/model/data/task.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/helper.dart';
import 'package:todo_app/view/screens/add_task_screen.dart';
import 'package:todo_app/view/screens/detail_task_screen.dart';
import 'package:todo_app/view/widgets/body_text.dart';
import 'package:todo_app/view/widgets/loading_item.dart';
import 'package:todo_app/view/widgets/task_card_item.dart';
import 'package:todo_app/view/widgets/title_text.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewModel/task_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> taskList = [];
  Helper helper = Helper();

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
      body: Consumer<TaskViewModel>(
        builder: (context, taskViewModel, child) {
          return Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: taskViewModel.tasks.isNotEmpty
                    ? _buildListContent(taskViewModel.tasks)
                    : const TitleText(
                        text: "You don't have any task",
                        color: Colors.black87,
                        size: 20,
                      ),
              ),
            ),
            if (taskViewModel.isLoading) const LoadingItem()
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListContent(List<Task> tasks) {
    return Column(
      children: [
        const BodyText(
          text: 'Your To-Do List',
          size: 20,
          color: Colors.black87,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: TaskCardItem(
                      taskTitle: task.title,
                      dueDate: helper.formatMillis(task.dueDateMillis),
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
