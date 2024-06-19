abstract class BaseService{
  final String baseURL = "https://66718445e083e62ee43beaf3.mockapi.io/api/v1/tasks/";

  Future<dynamic> getTaskById(String id);
  Future<dynamic> getAllTasks();
  Future<dynamic> deleteTaskById(String id);
  Future<dynamic> createTask(Map<String, dynamic> task);
  Future<dynamic> updateTask(String id, Map<String, dynamic> task);

}