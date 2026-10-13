class GlobalState {}

class GlobalInitial extends GlobalState {}

class LanguageChangeState extends GlobalState {}

class GlobalLoading extends GlobalState {}

class FaildToGetProfile extends GlobalState {}

class ChangeLanguageLoading extends GlobalState {}

class ChangeLanguageFailed extends GlobalState {
  final String error;
  ChangeLanguageFailed(this.error);
}

class ChangeLanguageSuccessfully extends GlobalState {}
