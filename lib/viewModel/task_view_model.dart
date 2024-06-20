import 'package:flutter/material.dart';
import 'package:todo_app/model/data/task.dart';
import 'package:todo_app/model/repository/task_repository.dart';
import 'package:todo_app/utils/helper.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository = TaskRepository();
  List<Task> _tasks = [];
  bool _isLoading = false;
  Helper helper = Helper();

  List<Task> get tasks => _tasks;

  bool get isLoading => _isLoading;

  TaskViewModel() {
    initializeTasks();
  }

  Future<void> initializeTasks() async {
    if (await helper.internetAvailability()) {
      await _fetchTasksFromAPI();
    } else {
      await _fetchTasksFromLocalDB();
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> _fetchTasksFromLocalDB() async {
    _tasks = await _taskRepository.fetchAllTasksFromLocalDB();
    notifyListeners();
  }

  Future<void> _fetchTasksFromAPI() async {
    setLoading(true);
    try {
      _tasks = await _taskRepository.fetchAllTasks();
      notifyListeners();
      // Update local database with the fetched tasks
      for (var task in _tasks) {
        await _taskRepository.insertTaskToLocalDB(task);
      }
      setLoading(false);
    } catch (e) {
      print('Error fetching tasks from API: $e');
      setLoading(false);
    }
  }

  Future<void> addTask(Task task) async {
    setLoading(true);
    try {
      await _taskRepository.insertTaskToLocalDB(task);
      await _taskRepository.createTask(task);
      notifyListeners();
      setLoading(false);
    } catch (e) {
      print('Error add task: $e');
      setLoading(false);
    }
    initializeTasks();
  }

  Future<void> updateTask(Task task) async {
    setLoading(true);
    try {
      await _taskRepository.updateTask(task);
      await _taskRepository.updateTaskInLocalDB(task);
      notifyListeners();
      setLoading(false);
    } catch (e) {
      print('Error update task: $e');
      setLoading(false);
    }
    initializeTasks();
  }

  Future<void> deleteTask(String id) async {
    setLoading(true);
    try {
      await _taskRepository.deleteTaskById(id);
      await _taskRepository.deleteTaskFromLocalDB(id);
      notifyListeners();
      setLoading(false);
    } catch (e) {
      print('Error delete task: $e');
      setLoading(false);
    }
    initializeTasks();
  }

}
