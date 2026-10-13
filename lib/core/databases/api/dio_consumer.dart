import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../connection/network_info.dart';
import '../../errors/error_model.dart';
import '../../errors/exceptions.dart';
import 'api_consumer.dart';
import 'api_interceptors.dart';
import 'end_points.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  final NetworkInfo networkInfo;
  DioConsumer(this.dio, this.networkInfo) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.contentType = Headers.jsonContentType;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          return true;
        },
      ),
    );
  }
  @override
  Future delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final res = await dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
        );
        return res.data;
      } on DioException catch (e) {
        handleDioException(e);
      }
    } else {
      throw NoInternetException(ErrorModel(detail: "No Internet Connection"));
    }
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final res = await dio.get(
          path,
          data: data,
          queryParameters: queryParameters,
        );
        return res.data;
      } on DioException catch (e) {
        handleDioException(e);
      }
    } else {
      throw NoInternetException(ErrorModel(detail: "No Internet Connection"));
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final res = await dio.patch(
          path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters,
        );
        return res.data;
      } on DioException catch (e) {
        handleDioException(e);
      }
    } else {
      throw NoInternetException(ErrorModel(detail: "No Internet Connection"));
    }
  }

  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final res = await dio.put(
          path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters,
        );
        return res.data;
      } on DioException catch (e) {
        handleDioException(e);
      }
    } else {
      throw NoInternetException(ErrorModel(detail: "No Internet Connection"));
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final res = await dio.post(
          path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken,
        );
        return res.data;
      } on DioException catch (e) {
        handleDioException(e);
      }
    } else {
      throw NoInternetException(ErrorModel(detail: "No Internet Connection"));
    }
  }
}
