import 'package:bloc/bloc.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/theme/app_config.dart';
import 'package:dartz/dartz.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(SettingsState initialState) : super(initialState);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is ChangePasswordEvent) {
      yield LoadingSettingsState();
      Either<ErrorModel, DetailOnlyResponse> _response = await apiProvider.changePassword(event.changePasswordRequest, event.authToken);

      yield _response.fold(
          (failure) => ErrorState(failure),
          (success) => PasswordChangedState(),
      );
    }
  }

}