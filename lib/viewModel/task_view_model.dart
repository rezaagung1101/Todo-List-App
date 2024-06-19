import 'package:flutter/material.dart';
import 'package:todo_app/model/data/task.dart';
import 'package:todo_app/model/repository/task_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository = TaskRepository();
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;

  bool get isLoading => _isLoading;

  TaskViewModel() {
    _initializeTasks();
  }

  Future<void> _initializeTasks() async {
    if (await _isConnected()) {
      await _fetchTasksFromAPI();
      await _syncLocalTasksToAPI();
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
      setLoading(false);
      notifyListeners();
      // Update local database with the fetched tasks
      for (var task in _tasks) {
        await _taskRepository.insertTaskToLocalDB(task);
      }
    } catch (e) {
      print('Error fetching tasks from API: $e');
      setLoading(false);
    }
  }

  Future<void> _syncLocalTasksToAPI() async {
      // Fetch tasks from local DB that are not synced with the API
      List<Task> localTasks = await _taskRepository.fetchAllTasksFromLocalDB();
      for (var task in localTasks) {
        if (!task.isSynced) {
          try {
            setLoading(true);
            await _taskRepository.createTask(task);
            // Update task in local DB to mark it as synced
            task.isSynced = true;
            await _taskRepository.updateTaskInLocalDB(task);
            setLoading(false);
          } catch (e) {
            print('Error syncing local tasks to API: $e');
            setLoading(false);
          }
        }
      }
  }

  Future<void> addTask(Task task) async {
    await _taskRepository.insertTaskToLocalDB(task);
    _tasks.add(task);
    notifyListeners();
    await _syncLocalTasksToAPI();
  }

  Future<void> updateTask(Task task) async {
    await _taskRepository.updateTaskInLocalDB(task);
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
    await _syncLocalTasksToAPI();
  }

  Future<void> deleteTask(int id) async {
    await _taskRepository.deleteTaskFromLocalDB(id);
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    if (await _isConnected()) {
      await _taskRepository.deleteTaskById(id.toString());
    }
  }

  Future<bool> _isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}
