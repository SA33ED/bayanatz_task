import 'package:flutter_bloc/flutter_bloc.dart';

import '../databases/cache/cache_helper.dart';
import '../services/service_locator.dart';
import 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  //! Language
  String language = sl<CacheHelper>().getCachedLanguage();
}
