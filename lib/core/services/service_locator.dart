import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/data/repo/home_repo.dart';
import '../connection/network_info.dart';
import '../cubit/global_cubit.dart';
import '../databases/api/dio_consumer.dart';
import '../databases/cache/cache_helper.dart';
import '../repo/global_repo.dart';

final sl = GetIt.instance;
void initServiceLocator() {
  sl.registerLazySingleton(() => CacheHelper());
  sl.registerLazySingleton(() => GlobalCubit());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => NetworkInfoImpl(sl<DataConnectionChecker>()));
  sl.registerLazySingleton(() => DioConsumer(sl<Dio>(), sl<NetworkInfoImpl>()));
  sl.registerLazySingleton(() => GlobalRepo(sl<DioConsumer>()));
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(
    () => HomeRepo(sl<FirebaseFirestore>(), sl<FirebaseAuth>()),
  );
}
