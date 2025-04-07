import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  Future<Response> get(String path) async => await dio.get(path);
  Future<Response> post(String path, {dynamic data}) async => await dio.post(path, data: data);
  Future<Response> put(String path, {dynamic data}) async => await dio.put(path, data: data);
  Future<Response> delete(String path) async => await dio.delete(path);
}
