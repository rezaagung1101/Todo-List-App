import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/data/task.dart';
import 'package:todo_app/utils/helper.dart';
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
      if (await helper.internetAvailability()) {
        final title = _titleController.text;
        final description = _descriptionController.text;
        final dueDateMillis = _selectedDueDate?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch;

        final task = Task(
          id: "",
          title: title,
          description: description,
          dueDateMillis: dueDateMillis,
        );
        Provider.of<TaskViewModel>(context, listen: false).addTask(task);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No internet connection. Task not added.')),
        );
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
                    return 'Please enter a title';
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.calendar_month_outlined),
                    onPressed: _showDatePicker,
                  ),
                  Text(
                    _selectedDueDate != null
                        ? _selectedDueDate!.toLocal().toString().split(' ')[0]
                        : 'Due Date',
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
