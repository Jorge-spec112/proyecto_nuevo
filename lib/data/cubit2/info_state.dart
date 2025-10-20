import 'package:flutter_application_1/modelo/info_model.dart';

abstract class InfoState {}

class InfoInitial extends InfoState {}

class InfoLoading extends InfoState {}

class InfoLoaded extends InfoState {
  final Info info;
  InfoLoaded(this.info);
}

class InfoError extends InfoState {
  final String message;
  InfoError(this.message);
}
