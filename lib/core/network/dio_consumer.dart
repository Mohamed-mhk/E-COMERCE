import 'package:dio/dio.dart';

abstract class DioConsumer {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Response> post(String path, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters});
  Future<Response> put(String path, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters});
  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters});
}

class DioConsumerImpl implements DioConsumer {
  final Dio client;

  DioConsumerImpl({required this.client}) {
    // Optionally add global interceptors, baseOptions, etc.
    client.options
      ..baseUrl = 'https://api.example.com' // Replace with actual base URL or inject it
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10);
      
    client.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await client.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> post(String path, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    return await client.post(path, data: body, queryParameters: queryParameters);
  }

  @override
  Future<Response> put(String path, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    return await client.put(path, data: body, queryParameters: queryParameters);
  }

  @override
  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters}) async {
    return await client.delete(path, queryParameters: queryParameters);
  }
}
