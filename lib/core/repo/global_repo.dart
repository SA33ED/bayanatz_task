import 'package:dartz/dartz.dart';

import '../databases/api/api_consumer.dart';
import '../databases/api/end_points.dart';
import '../errors/exceptions.dart';

class GlobalRepo {
  final ApiConsumer api;

  GlobalRepo(this.api);

  Future<Either<String, String>> postFcmToken(String fcmToken) async {
    try {
      final response = await api.post(
        EndPoints.postFcmToken,
        data: {
          'fcm_token': fcmToken,
        },
      );
      return Right(response['message'] ?? 'FCM Token Posted Successfully');
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> changeLanguageAtTheServer(String lang) async {
    try {
      await api.post(
        EndPoints.changeLanguage,
        data: {
          "lang": lang,
          "_method": "put",
        },
      );
      return const Right("Success");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
