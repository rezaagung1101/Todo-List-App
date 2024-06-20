import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:todo_app/model/services/task_service.dart';
import 'package:todo_app/model/api/app_exception.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late TaskService taskService;
  late MockHttpClient mockHttpClient;
  String baseUrl = "https://66718445e083e62ee43beaf3.mockapi.io/api/v1/tasks/";
  setUp(() {
    mockHttpClient = MockHttpClient();
    taskService = TaskService(
        // httpClient: mockHttpClient
    );
  });

  test('Get task by ID - Success', () async {
    final taskId = '1';
    final mockResponse = {'id': taskId, 'title': 'Task 1'};

    when(mockHttpClient.get(Uri.parse('https://mockapi.io/api/v1/tasks/$taskId')))
        .thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

    var response = await taskService.getTaskById(taskId);
    expect(response, equals(mockResponse));
  });

  test('Get task by ID - Network error', () async {
    final taskId = '1';

    when(mockHttpClient.get(Uri.parse('$baseUrl$taskId')))
        .thenThrow(SocketException('No Internet Connection'));

    expect(() => taskService.getTaskById(taskId), throwsA(isInstanceOf<FetchDataException>()));
  });

  test('Get all tasks - Success', () async {
    final mockResponse = [
      {'id': '1', 'title': 'Task 1'},
      {'id': '2', 'title': 'Task 2'}
    ];

    when(mockHttpClient.get(Uri.parse(baseUrl)))
        .thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

    var response = await taskService.getAllTasks();
    expect(response, equals(mockResponse));
  });

  test('Delete task by ID - Success', () async {
    final taskId = '1';

    when(mockHttpClient.delete(Uri.parse('$baseUrl$taskId')))
        .thenAnswer((_) async => http.Response('', 204));

    var response = await taskService.deleteTaskById(taskId);
    expect(response, isNull);
  });

  test('Create task - Success', () async {
    final task = {'title': 'New Task'};

    when(mockHttpClient.post(Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task)))
        .thenAnswer((_) async => http.Response('', 201));

    var response = await taskService.createTask(task);
    expect(response, isNull);
  });

  test('Update task - Success', () async {
    final taskId = '1';
    final updatedTask = {'title': 'Updated Task'};

    when(mockHttpClient.put(Uri.parse('$baseUrl$taskId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedTask)))
        .thenAnswer((_) async => http.Response('', 200));

    var response = await taskService.updateTask(taskId, updatedTask);
    expect(response, isNull);
  });

  test('Update task - Network error', () async {
    final taskId = '1';
    final updatedTask = {'title': 'Updated Task'};

    when(mockHttpClient.put(Uri.parse('$baseUrl$taskId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedTask)))
        .thenThrow(SocketException('No Internet Connection'));

    expect(() => taskService.updateTask(taskId, updatedTask),
        throwsA(isInstanceOf<FetchDataException>()));
  });
}
