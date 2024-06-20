import 'package:todo_app/model/data/task.dart';
import 'package:todo_app/model/database/database_helper.dart';
import 'package:todo_app/model/services/base_service.dart';

class TaskRepository{
  final BaseService taskService;

  TaskRepository({required this.taskService});
  final DatabaseHelper _dbHelper = DatabaseHelper();

  //mockAPI Fetch
  Future<Task> fetchTaskById(String id) async {
    dynamic response = await taskService.getTaskById(id);
    return Task.fromJson(response);
  }

  Future<List<Task>> fetchAllTasks() async {
    dynamic response = await taskService.getAllTasks();
    List<Task> tasks = (response as List).map((task) => Task.fromJson(task)).toList();
    return tasks;
  }

  Future<Task> createTask(Task task) async {
    Map<String, dynamic> taskData = task.toMap();
    dynamic response = await taskService.createTask(taskData);
    return Task.fromJson(response);
  }

  Future<Task> updateTask(Task task) async {
    Map<String, dynamic> taskData = task.toMap();
    dynamic response = await taskService.updateTask(task.id.toString(), taskData);
    return Task.fromJson(response);
  }

  Future<void> deleteTaskById(String id) async {
    await taskService.deleteTaskById(id);
  }

  // Local Database Methods (SQLite)

  Future<void> insertTaskToLocalDB(Task task) async {
    await _dbHelper.saveTask(task);
  }

  Future<void> updateTaskInLocalDB(Task task) async {
    await _dbHelper.updateTask(task);
  }

  Future<void> deleteTaskFromLocalDB(String id) async {
    await _dbHelper.deleteTask(id);
  }

  Future<List<Task>> fetchAllTasksFromLocalDB() async {
    return await _dbHelper.getAllTasks();
  }
}