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
    } else if (event is ReportABugEvent) {
      yield LoadingSettingsState();
      DetailOnlyResponse _response = await apiProvider.reportBug(event.reportBugRequest, event.authToken);

      if (_response.detail.contains('Success')) {
        yield BugReportedState();
      } else {
        yield ErrorState(ErrorModel(_response.detail, [""]));
      }
    } else if (event is FetchBlockedUsersEvent) {
      yield LoadingSettingsState();
      Either<DetailOnlyResponse, GetAllBlockedUsersResponse> _response = await apiProvider.getBlockedUsers(event.authToken);

      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => BlockedUsersFetchedState(success),
      );
    }
  }

}