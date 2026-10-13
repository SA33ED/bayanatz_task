import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../common/logs.dart';
import '../../constants/app_constants.dart';
import '../../services/service_locator.dart';
import '../cache/cache_helper.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = sl<CacheHelper>().getCachedLanguage();
    if (sl<CacheHelper>().getData(key: AppConstants.token) != null) {
      options.headers.addAll({
        'Authorization':
            'Bearer ${sl<CacheHelper>().getData(key: AppConstants.token)}',
      });

      if (kDebugMode) {
        Print.success(
          {
            'Authorization':
                'Bearer ${sl<CacheHelper>().getData(key: AppConstants.token)}',
          },
        );
      }
    }

    super.onRequest(options, handler);
  }
}
