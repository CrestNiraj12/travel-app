import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/states/auth/auth.provider.dart';

class HttpClient {
  HttpClient(this.ref, {String baseURL = "http://10.0.2.2:8000/api"}) {
    _init(baseURL);
  }

  final Ref ref;
  late final Dio httpClient;

  static final BaseOptions options = BaseOptions(
    connectTimeout: Duration(minutes: 60),
    receiveTimeout: Duration(minutes: 60),
    // default cache settings
    extra: <String, dynamic>{
      'dio_cache_try_cache': true,
      'dio_cache_max_age': const Duration(days: 7),
    },
  );

  void _init(String baseUrl) {
    options.baseUrl = baseUrl;
    httpClient = Dio(options);

    httpClient.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: _requestInterceptor,
        onResponse: (
          Response<dynamic> response,
          ResponseInterceptorHandler handler,
        ) async {
          handler.next(response);
        },
      ),
    ]);
    httpClient.interceptors.add(LogInterceptor());
  }

  void _requestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = ref.read(authProvider).token;
    options.headers['Accept'] = 'application/json';
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
