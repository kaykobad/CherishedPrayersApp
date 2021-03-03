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
    } else if (event is VerifyEmailEvent) {
      yield LoadingState();
      Either<ErrorModel, EmailVerificationResponse> _response = await apiProvider.verifyEmail(event.verifyEmailRequest);

      yield _response.fold(
          (failure) => ErrorState(failure),
          (success) => EmailSentState(success),
      );
    } else if (event is ConfirmEmailVerificationEvent) {
      yield LoadingState();
      Either<ErrorModel, DetailOnlyResponse> _response = await apiProvider.confirmEmailVerification(event.confirmVerifyEmailRequest);

      yield _response.fold(
          (failure) => ErrorState(failure),
          (success) => EmailVerifiedState(success),
      );
    } else if (event is RegistrationEvent) {
      yield LoadingState();
      Either<ErrorModel, AuthUserResponse> _response = await apiProvider.register(event.registerRequest);

      yield _response.fold(
          (failure) => ErrorState(failure),
          (success) => RegistrationSuccessfulState(success),
      );
    } else if (event is ResetPasswordEvent) {
      yield LoadingState();
      Either<ErrorModel, DetailOnlyResponse> _response = await apiProvider.resetPassword(event.resetPasswordRequest);

      yield _response.fold(
          (failure) => ErrorState(failure),
          (success) => PasswordResetInitiatedState(success),
      );
    } else if (event is ConfirmResetPasswordEvent) {
      yield LoadingState();
      Either<ErrorModel, DetailOnlyResponse> _response = await apiProvider.confirmPasswordReset(event.confirmPasswordResetRequest);

      yield _response.fold(
          (failure) => ErrorState(failure),
          (success) => PasswordResetConfirmedState(success),
      );
    }
  }

}