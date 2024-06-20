import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_app/model/data/task.dart';
import 'package:todo_app/model/repository/task_repository.dart';
import 'package:todo_app/model/services/task_service.dart';
import 'package:todo_app/viewModel/task_view_model.dart';

// Mock the TaskService
class MockTaskService extends Mock implements TaskService {}

void initializeDatabaseFactory() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  initializeDatabaseFactory();

  const MethodChannel('dev.fluttercommunity.plus/connectivity')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'check') {
      return 'wifi'; // Mocked connectivity status
    }
    return null;
  });

  late TaskViewModel taskViewModel;
  late MockTaskService mockTaskService;
  late TaskRepository taskRepository;

  setUp(() {
    mockTaskService = MockTaskService();
    taskRepository = TaskRepository(taskService: mockTaskService);
    taskViewModel = TaskViewModel(taskRepository: taskRepository);
  });

  test('Initialize tasks', () async {
    // Mocking getAllTasks() to return a list of tasks
    when(mockTaskService.getAllTasks()).thenAnswer((_) async => [
      {
        'id': '1',
        'title': 'Task 1',
        'description': 'Description 1',
        'dueDateMillis': DateTime.now().millisecondsSinceEpoch
      }
    ]);

    await taskViewModel.initializeTasks();
    expect(taskViewModel.tasks.isNotEmpty, true);
  });

  test('Add task', () async {
    final task = Task(
      id: '1',
      title: 'Test Task',
      description: 'Test Description',
      dueDateMillis: DateTime.now().millisecondsSinceEpoch,
    );

    // Mocking createTask() to return a non-null value
    when(mockTaskService.createTask(any)).thenAnswer((_) async => {
      'id': '1',
      'title': 'Test Task',
      'description': 'Test Description',
      'dueDateMillis': task.dueDateMillis,
    });

    await taskViewModel.addTask(task);
    expect(taskViewModel.tasks.contains(task), true);
  });

  test('Update task', () async {
    final task = Task(
      id: '1',
      title: 'Test Task',
      description: 'Test Description',
      dueDateMillis: DateTime.now().millisecondsSinceEpoch,
    );

    // Mocking updateTask() to return a non-null value
    when(mockTaskService.updateTask(task.id!, any)).thenAnswer((_) async => {
      'id': '1',
      'title': 'Updated Task',
      'description': 'Updated Description',
      'dueDateMillis': task.dueDateMillis,
    });

    await taskViewModel.addTask(task);

    final updatedTask = Task(
      id: '1',
      title: 'Updated Task',
      description: 'Updated Description',
      dueDateMillis: DateTime.now().millisecondsSinceEpoch,
    );

    await taskViewModel.updateTask(updatedTask);
    expect(taskViewModel.tasks.contains(updatedTask), true);
    expect(taskViewModel.tasks.contains(task), false);
  });

  test('Delete task', () async {
    final task = Task(
      id: '1',
      title: 'Test Task',
      description: 'Test Description',
      dueDateMillis: DateTime.now().millisecondsSinceEpoch,
    );

    // Mocking deleteTaskById() to return null (or any appropriate value)
    when(mockTaskService.deleteTaskById(task.id!)).thenAnswer((_) async => null);

    await taskViewModel.addTask(task);
    await taskViewModel.deleteTask(task.id!);

    expect(taskViewModel.tasks.contains(task), false);
  });
}
