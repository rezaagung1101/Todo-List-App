import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/model/services/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/model/api/app_exception.dart';

class TaskService extends BaseService{

  @override
  Future? getTaskById(String id) async {
    dynamic responseJson;
    try {
      final response = await http.get(
          Uri.parse(baseURL+id));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future? getAllTasks() async {
    dynamic responseJson;
    try {
      final response = await http.get(
          Uri.parse(baseURL));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future? deleteTaskById(String id) async {
    dynamic responseJson;
    try {
      final response = await http.delete(
          Uri.parse(baseURL+id));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future? createTask(Map<String, dynamic>? task) async {
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(baseURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(task),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future? updateTask(String id, Map<String, dynamic>? task) async {
    dynamic responseJson;
    try {
      final response = await http.put(
        Uri.parse(baseURL + id),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(task),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }


}