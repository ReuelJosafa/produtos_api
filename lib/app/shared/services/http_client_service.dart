import 'package:dio/dio.dart';

import '../interfaces/http_client_interface.dart';

class DioSevice implements IHttpClient {
  final Dio dio;
  final String baseUrl;

  DioSevice(this.dio, this.baseUrl);

  @override
  Future get(String endPoint) async {
    try {
      final response = await dio.get('$baseUrl$endPoint');
      return response.data;
    } on DioError catch (e) {
      throw e.response?.statusCode ?? 404;
    }
  }

  @override
  Future post(String endPoint, dynamic data) async {
    try {
      final response = await dio.post('$baseUrl$endPoint', data: data);
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      throw e.response?.statusCode ?? 404;
    }
  }

  @override
  Future uptade(String endPoint,
      {required String id, required dynamic data}) async {
    try {
      final response = await dio.put('$baseUrl$endPoint/$id', data: data);
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      throw e.response?.statusCode ?? 404;
    }
  }

  @override
  Future delete(String endPoint, {required String id}) async {
    try {
      final response = await dio.delete('$baseUrl$endPoint/$id');
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      throw e.response?.statusCode ?? 404;
    }
  }
}
