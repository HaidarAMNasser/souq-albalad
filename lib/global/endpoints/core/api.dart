import 'dart:async';
import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

abstract class BaseUrlHandler {
  final String baseUrl = '';
}

typedef ParseJson<T> = T Function(dynamic json);

class API implements BaseUrlHandler {
  final Dio dio = Dio();

  API() {
    dio.options.baseUrl =
        'https://phplaravel-1483035-5732108.cloudwaysapps.com/api/';
    dio.options.connectTimeout = Duration(milliseconds: 50000); //50s
    dio.options.receiveTimeout = Duration(milliseconds: 30000);
    //dio.interceptors.add(DioLoggingInterceptors(dio));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = CacheHelper.getData(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';
          options.headers['connection'] = 'keep-alive';
          handler.next(options);
        },
      ),
    );
  }

  Future<ResponseState<T>> apiMethod<T>(
    String apiUrl, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    dynamic dataMedia,
    ResponseType? responseType,
    required HttpEnum httpEnum,
    required ParseJson<T> parseJson,
    bool isCache = false,
  }) async {
    assert(T != dynamic);
    Options? cacheOptions;
    if (isCache) {
      final options = CacheOptions(
        store: HiveCacheStore(
          (await getApplicationDocumentsDirectory()).path,
        ), // Required.
        policy: CachePolicy.refresh,
        priority: CachePriority.normal,
        maxStale: const Duration(days: 365),
      );
      cacheOptions = options.toOptions()..headers = headers;
      dio.interceptors.add(DioCacheInterceptor(options: options));
    }
    switch (httpEnum) {
      case HttpEnum.get:
        return await dio
            .get(
              apiUrl,
              queryParameters: queryParameters,
              options:
                  isCache
                      ? cacheOptions
                      : Options(headers: headers ?? dio.options.headers),
            )
            .then((response) {
              return ResponseState<T>.success(parseJson(response.data));
            })
            .catchError((error, stacktrace) {
              return Model.catchError<T>(error, stacktrace);
            });

      case HttpEnum.post:
        return await dio
            .post(
              apiUrl,
              data: dataMedia ?? data,
              queryParameters: queryParameters,
              options: Options(
                headers: headers ?? dio.options.headers,
                responseType: responseType,
              ),
            )
            .then((response) {
              return ResponseState<T>.success(parseJson(response.data));
            })
            .catchError(
              (error, stacktrace) => Model.catchError<T>(error, stacktrace),
            );
      case HttpEnum.put:
        return await dio
            .put(
              apiUrl,
              data: dataMedia ?? data,
              options: Options(headers: headers ?? dio.options.headers),
            )
            .then((response) {
              return ResponseState<T>.success(parseJson(response.data));
            })
            .catchError(
              (error, stacktrace) => Model.catchError<T>(error, stacktrace),
            );
      case HttpEnum.patch:
        return await dio
            .patch(
              apiUrl,
              data: dataMedia ?? data,
              options: Options(headers: headers),
            )
            .then((response) {
              return ResponseState<T>.success(parseJson(response.data));
            })
            .catchError(
              (error, stacktrace) => Model.catchError<T>(error, stacktrace),
            );

      case HttpEnum.delete:
        return await dio
            .delete(apiUrl, data: data, options: Options(headers: headers))
            .then((response) {
              return ResponseState<T>.success(parseJson(response.data));
            })
            .catchError(
              (error, stacktrace) => Model.catchError<T>(error, stacktrace),
            );
    }
  }

  @override
  String get baseUrl => throw UnimplementedError();
}
