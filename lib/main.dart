import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgrader/upgrader.dart';

import 'app/app.dart';
import 'core/cubit/global_cubit.dart';
import 'core/databases/cache/cache_helper.dart';
import 'core/notifications/local_notification_handler.dart';
import 'core/notifications/local_notification_service.dart';
import 'core/services/service_locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  //! Service Locator
  initServiceLocator();
  //! Cache Helper
  await sl<CacheHelper>().init();
  //! Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotificationService.init();
  await NotificationHandler.init();
  //! Orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //! Status Bar Settings
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await Upgrader.clearSavedSettings();

  //! Application Starts From here.
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<GlobalCubit>())],
      child: const MyApp(),
    ),
  );
}
