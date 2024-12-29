import 'package:dio/dio.dart' as dio;
import 'package:mak_life_dairy_fresh/app/utils/alert_popup_utils.dart';

import '../../constants/api_constant.dart';

class ApiService {
  final dio.Dio _dio = dio.Dio();

  ApiService() {
    _dio.options = dio.BaseOptions(
      baseUrl: baseUrl, // Replace with your base URL
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Interceptor for error handling and logging
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response[${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (dio.DioException error, handler) {
          _handleDioError(error);
          return handler.next(error);
        },
      ),
    );
  }

  // GET Method
  Future<dio.Response?> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: query);
      return response;
    } catch (e) {
      return null;
    }
  }

  // POST Method
  Future<dio.Response?> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      return null;
    }
  }

  // PUT Method
  Future<dio.Response?> put(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      return null;
    }
  }

  // DELETE Method
  Future<dio.Response?> delete(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } catch (e) {
      return null;
    }
  }

  // Multipart Request
  Future<dio.Response?> postMultipart(
      String endpoint, Map<String, dynamic> data, List<dio.MultipartFile> files) async {
    try {
      final formData = dio.FormData.fromMap(data);
      for (var file in files) {
        formData.files.add(MapEntry('files', file));
      }
      final response = await _dio.post(endpoint, data: formData);
      return response;
    } catch (e) {
      return null;
    }
  }

  // Error Handler
  void _handleDioError(dio.DioException error) {
    String errorMessage = 'An unknown error occurred';

    switch (error.type) {
      case dio.DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timeout';
        break;
      case dio.DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout';
        break;
      case dio.DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout';
        break;
      case dio.DioExceptionType.badResponse:
        errorMessage =
        'Received invalid status code: ${error.response?.statusCode}';
        break;
      case dio.DioExceptionType.cancel:
        errorMessage = 'Request cancelled';
        break;
      case dio.DioExceptionType.unknown:
        errorMessage = 'Unknown error: ${error.message}';
        break;
      case dio.DioExceptionType.badCertificate:
        errorMessage = 'Bad Certificate error: ${error.message}';
        break;
      case dio.DioExceptionType.connectionError:
        errorMessage = 'Connection error: ${error.message}';
        break;
    }

    // Log the error
    // Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    showAlertMessage(errorMessage);
    print('DioError: $errorMessage');
  }
}
