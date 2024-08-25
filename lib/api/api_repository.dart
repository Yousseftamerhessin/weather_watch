import 'package:dio/dio.dart';

class ApiRepository {
  final String? url;
  final Map<String, dynamic>? payload;

  ApiRepository({this.url, this.payload});

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> get() async {
    try {
      final response = await _dio.get(url!, queryParameters: payload);
      return response.data as Map<String, dynamic>;
    } catch (error) {
      print('API request error: $error');
      throw Exception('Failed to fetch data from API');
    }
  }
}
