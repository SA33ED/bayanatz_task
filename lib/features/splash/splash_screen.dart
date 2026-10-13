import 'dart:async';

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

import '../../core/common/common.dart';
import '../../core/utils/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Upgrader? _upgrader;
  @override
  void initState() {
    super.initState();

    //! Initialize Upgrader
    _upgrader = Upgrader(
      countryCode: "EG",
      debugDisplayAlways: false,
      debugDisplayOnce: false,
      debugLogging: true,
    );

    //! Check for updates
    _checkUpdateAndNavigate();
  }

  Future<void> _checkUpdateAndNavigate() async {
    try {
      //! Check Network Connectivity First
      if (!await checkNetworkConnectivity()) {
        // //! If No Network Connectivity, Navigate to Home Screen
        return;
      }
      await _upgrader?.initialize();

      final bool isUpdateAvailable = _upgrader?.isUpdateAvailable() ?? false;

      //! If No Update Available
      if (!isUpdateAvailable) {
        checkingBeforeNavigation();
      }
    } catch (e) {
      checkingBeforeNavigation();
    }
  }

  void checkingBeforeNavigation() async {
    //! Wait for 2 Seconds Before Navigation
    await Future.delayed(const Duration(seconds: 2));

    //! Navigate to Home Screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        upgrader: _upgrader,
        shouldPopScope: () => false,
        showIgnore: false,
        showLater: false,
        dialogStyle: Theme.of(context).platform == TargetPlatform.iOS
            ? UpgradeDialogStyle.cupertino
            : UpgradeDialogStyle.material,
        barrierDismissible: false,
        showReleaseNotes: false,
        child: Center(
          child: Text(
            "Bayanatz Task",
            style: CustomTextStyle.font400sized20Black,
          ),
        ),
      ),
    );
  }
}
