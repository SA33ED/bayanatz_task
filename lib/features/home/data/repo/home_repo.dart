import '../../../../core/databases/api/api_consumer.dart';

class HomeRepo {
  final ApiConsumer api;

  HomeRepo(this.api);

  // //! Get User Sessions
  // Future<Either<String, List<UserSessionModel>>> getUserSessions() async {
  //   try {
  //     final response = await api.get(
  //       EndPoints.getUserSessions,
  //     );
  //     final sessions = (response['data']['sessions'] as List? ?? [])
  //         .map((e) => UserSessionModel.fromJson(e))
  //         .toList();
  //     return Right(sessions);
  //   } on ServerException catch (e) {
  //     return Left(e.errorModel.detail);
  //   } on NoInternetException catch (e) {
  //     return Left(e.errorModel.detail);
  //   } on Exception catch (e) {
  //     return Left(e.toString());
  //   }
  // }
}
