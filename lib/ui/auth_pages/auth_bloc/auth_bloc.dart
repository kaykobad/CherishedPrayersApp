import 'package:bloc/bloc.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/theme/app_config.dart';
import 'package:dartz/dartz.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield LoadingState();
      Either<ErrorModel, AuthUserResponse> _response = await apiProvider.login(event.loginRequest);

      yield _response.fold(
          (failure) => ErrorState(failure),
          (success) => LoginSuccessfulState(success),
      );
    }
  }

}