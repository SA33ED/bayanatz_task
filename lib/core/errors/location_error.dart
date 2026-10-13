import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../utils/app_text_styles.dart';

class LocationError extends StatelessWidget {
  const LocationError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(Assets.imagesPngGps, width: 200.w, height: 200.h),
              Text(
                "Please enable location services and permissions to use the app.",
                style: CustomTextStyle.font700sized18Black,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.initialRoute);
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
