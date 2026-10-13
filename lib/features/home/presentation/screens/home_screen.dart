import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/cubit/global_cubit.dart';
import '../../../../core/cubit/global_state.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (globalContext, globalState) {
          return ModalProgressHUD(
            inAsyncCall: false,
            progressIndicator: const CustomLoadingIndicator(),
            child: SafeArea(
              top: false,
              bottom: Platform.isAndroid,
              child: Scaffold(),
            ),
          );
        },
      ),
    );
  }
}
