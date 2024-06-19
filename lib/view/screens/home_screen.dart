import 'package:flutter/material.dart';
import 'package:todo_app/model/data/task.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/view/widgets/task_card_item.dart';
import 'package:todo_app/view/widgets/title_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> taskList = [
    Task(id: 0, title: 'Title1', description: 'adadadada', dueDateMillis: 24),
    Task(id: 0, title: 'Title2', description: 'asd', dueDateMillis: 24),
    Task(id: 0, title: 'Title3', description: 'a', dueDateMillis: 24),
    Task(id: 0, title: 'Title4', description: 'sdsds', dueDateMillis: 24),
    Task(id: 0, title: 'Title5', description: 'hh', dueDateMillis: 24),
    Task(id: 0, title: 'Title6', description: 'vvvcx', dueDateMillis: 24),
    Task(id: 0, title: 'Title7', description: 'hh', dueDateMillis: 24),
    Task(id: 0, title: 'Title8', description: 'vvvcx', dueDateMillis: 24),
    Task(id: 0, title: 'Title9', description: 'hh', dueDateMillis: 24),
    Task(id: 0, title: 'Title10', description: 'vvvcx', dueDateMillis: 24),
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
      body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
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
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: TaskCardItem(
                            taskTitle: task.title,
                            dueDate: task.dueDateMillis.toString(),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             DetailCityScreen(cityName: city.name)));
                            }
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add task action
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
