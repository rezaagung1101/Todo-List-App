import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/data/task.dart';
import 'package:todo_app/utils/helper.dart';
import 'package:todo_app/view/widgets/button_date_picker.dart';
import 'package:todo_app/view/widgets/button_section.dart';
import 'package:todo_app/viewModel/task_view_model.dart';

class DetailTaskScreen extends StatefulWidget {
  final Task task;

  const DetailTaskScreen({super.key, required this.task});

  @override
  _DetailTaskScreenState createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDueDate;
  Helper helper = Helper();
  late String _id;

  @override
  void initState() {
    super.initState();
    _id = widget.task.id.toString();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _selectedDueDate =
        DateTime.fromMillisecondsSinceEpoch(widget.task.dueDateMillis);
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDueDate = pickedDate;
      });
    }
  }

  void _confirmUpdateTask() async {
    if (_formKey.currentState!.validate()) {
      if (await helper.internetAvailability()) {
        bool? result = await helper.showConfirmationDialog(
          context,
          'Confirm Update',
          'Are you sure you want to update this task?',
        );
        if (result == true) {
          _updateTask();
        }
      } else {
        helper.showSnackBar(
            context, 'No internet connection, task can\'t be updated');
      }
    }
  }

  void _updateTask() async {
    final updatedTask = Task(
      id: widget.task.id,
      title: _titleController.text,
      description: _descriptionController.text,
      dueDateMillis: _selectedDueDate?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
    );
    await Provider.of<TaskViewModel>(context, listen: false)
        .updateTask(updatedTask);
    helper.showSnackBar(context, "Update task success");
  }

  void _confirmDeleteTask() async {
    if (await helper.internetAvailability()) {
      bool? result = await helper.showConfirmationDialog(
        context,
        'Confirm Delete',
        'Are you sure you want to delete this task?',
      );
      if (result == true) {
        _deleteTask();
      }
    } else {
      helper.showSnackBar(
          context, 'No internet connection, task can\'t be deleted');
    }
  }

  void _deleteTask() async {
    await Provider.of<TaskViewModel>(context, listen: false).deleteTask(_id);
    Navigator.pop(context);
    helper.showSnackBar(context, "Delete task success");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text(
          "Task Details",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
          ),
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
                  labelStyle: TextStyle(fontFamily: 'poppins'),
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
                  labelText: 'Description',
                  labelStyle: TextStyle(fontFamily: 'poppins'),
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16.0),
              ButtonDatePicker(
                onTap: _showDatePicker,
                selectedDueDate: _selectedDueDate,
              ),
              const SizedBox(height: 16.0),
              ButtonSection(
                onTap: _confirmUpdateTask,
                text: 'Update Task',
                mainColor: Colors.blue,
              ),
              const SizedBox(height: 16.0),
              ButtonSection(
                  onTap: _confirmDeleteTask,
                  text: 'Delete Task',
                  mainColor: Colors.red)
            ],
          ),
        ),
      ),
    );
  }
}
