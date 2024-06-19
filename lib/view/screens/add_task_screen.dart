import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/data/task.dart';
import 'package:todo_app/utils/helper.dart';
import 'package:todo_app/view/widgets/button_section.dart';
import 'package:todo_app/view/widgets/title_text.dart';
import 'package:todo_app/viewModel/task_view_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDueDate;
  Helper helper = Helper();

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDueDate = pickedDate;
      });
    }
  }

  void _addTask() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDueDate != null) {
        if (await helper.internetAvailability()) {
          final title = _titleController.text;
          final description = _descriptionController.text;
          final dueDateMillis = _selectedDueDate?.millisecondsSinceEpoch ??
              DateTime.now().millisecondsSinceEpoch;

          final task = Task(
            title: title,
            description: description,
            dueDateMillis: dueDateMillis,
          );
          Provider.of<TaskViewModel>(context, listen: false).addTask(task);
          Navigator.pop(context);
        } else {
          helper.showSnackBar(context, 'No internet connection, task not added.');
        }
      } else {
        helper.showSnackBar(context, 'Due date required!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const TitleText(
          text: "Add Task",
          size: 20,
          color: Colors.black87,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title can be empty!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Enter your description here',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16.0),
              InkWell(
                splashColor: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
                onTap: _showDatePicker,
                child: SizedBox(
                  height: 50,
                  child: Card.outlined(
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 16,
                        ),
                        const Icon(Icons.calendar_month_outlined),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          _selectedDueDate != null
                              ? _selectedDueDate!
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0]
                              : 'Due Date',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ButtonSection(
                  onTap: _addTask,
                  text: 'Add Task',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
