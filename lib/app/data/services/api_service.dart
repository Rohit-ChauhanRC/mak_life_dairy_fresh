import 'dart:async';

import 'package:dio/dio.dart' as dio;

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
          print(
              'Request[${options.method}] => QUERY PARAMETERS: ${options.queryParameters}');
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
  Future<dio.Response?> get(String endpoint,
      {Map<String, dynamic>? query}) async {
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
  Future<dio.Response?> postMultipart(String endpoint,
      Map<String, dynamic> data, List<dio.MultipartFile> files) async {
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
    // showAlertMessage(errorMessage);
    print('DioError: $errorMessage');
  }

  // Stream Function
  // Generic Stream Function
  // Stream<List<T>> fetchNewOrderStream<T>({
  //   required String endpoint,
  //   required T Function(Map<String, dynamic>) fromJson,
  //   Map<String, dynamic>? query,
  //   Duration interval = const Duration(seconds: 5),
  // }) async* {

  //   final controller = StreamController<List<T>>();
  //   while (true) {
  //     try {
  //       final response = await get(endpoint,
  //           query: query); // Using the `get` method from `ApiService`
  //       if (response != null && response.statusCode == 200) {
  //         final data = response.data;
  //         if (data is List) {
  //           // Emit the list of models by mapping the data through fromJson
  //           yield data.map((item) => fromJson(item)).toList();
  //         } else {
  //           // Emit an empty list if the response data is not a list
  //           yield [];
  //         }
  //       } else {
  //         // Emit an empty list for non-200 responses
  //         yield [];
  //       }
  //     } catch (e) {
  //       // Handle errors by emitting an empty list
  //       print('Error fetching data: $e');
  //       yield [];
  //     }

  //     // Wait for the specified interval before fetching again
  //     await Future.delayed(interval);
  //   }
  // }

  Stream<List<T>> fetchNewOrderStream<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? query,
    Duration interval = const Duration(seconds: 5),
  }) {
    final controller = StreamController<List<T>>();
    Timer? timer;

    void fetchData() async {
      try {
        final response = await get(endpoint, query: query);
        if (response != null && response.statusCode == 200) {
          final data = response.data;
          if (data is List) {
            controller.add(data.map((item) => fromJson(item)).toList());
          } else {
            controller.add([]);
          }
        } else {
          controller.add([]);
        }
      } catch (e) {
        print('Error fetching data: $e');
        controller.addError(e);
      }
    }

    // Start polling
    timer = Timer.periodic(interval, (_) {
      if (controller.isClosed) {
        timer?.cancel(); // Stop polling when the stream is closed
      } else {
        fetchData();
      }
    });

    // Close the timer and controller when the stream is closed
    controller.onCancel = () {
      timer?.cancel();
      controller.close();
    };

    return controller.stream;
  }

  Future<T?> getMethod<T>({
    required String endpoint,
    Map<String, dynamic>? query,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: query);
      if (response.statusCode == 200) {
        return fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('GET Error: $e');
      return null;
    }
  }

  Future<List<T>?> fetchList<T>({
    required String endpoint,
    Map<String, dynamic>? query,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: query);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          // Return the list of models by mapping through the fromJson function
          return data.map((item) => fromJson(item)).toList();
        }
        return [];
      }
      return [];
    } catch (e) {
      print('GET List Error: $e');
      return null;
    }
  }
}
