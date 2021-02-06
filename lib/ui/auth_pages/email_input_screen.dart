import 'dart:async';

import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/helpers/input_validator.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/auth_pages/auth_bloc/auth_event.dart';
import 'package:cherished_prayers/ui/auth_pages/otp_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/custom_text_fileld.dart';
import 'package:cherished_prayers/ui/shared_widgets/logo.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'auth_bloc/auth_bloc.dart';
import 'auth_bloc/auth_state.dart';

class EmailInputScreen extends StatefulWidget {
  @override
  _EmailInputScreenState createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  TextEditingController _emailController;
  AppDataStorage _appDataStorage;
  AuthBloc _authBloc;
  StreamSubscription<AuthState> _authBlocListener;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _authBloc = _appDataStorage.authBloc;
    _listenAuthBloc();
  }

  _listenAuthBloc() {
    _authBlocListener = _authBloc.listen((state) async {
      if (state is LoadingState) {
        EasyLoading.show(
          status: "Sending email...",
        );
      } else if (state is ErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
            state.error.error + '\n' + state.error.details.join(' ')
        );
      } else if (state is PasswordResetInitiatedState) {
        await EasyLoading.dismiss();
        NavigationHelper.push(context, OTPScreen(isRegistration: false));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authBlocListener?.cancel();
    _emailController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomLogo(AssetConstants.APP_LOGO, 84.0),
                  _getTitle(),
                  SizedBox(height: 40.0),
                  _getEmailField(),
                  SizedBox(height: 50.0),
                  _getSendCodeButton(context),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Text(
      StringConstants.FORGOT_PASSWORD_TITLE,
      style: TextStyle(
        color: ColorConstants.black,
        fontSize: 36,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getEmailField() {
    return CustomTextField(_emailController, StringConstants.EMAIL_HINT, false);
  }

  Widget _getSendCodeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: RoundedCornerButton(StringConstants.SEND_OTP, _sendOTP),
      ),
    );
  }

  void _sendOTP() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    String _email = _emailController.text;

    if (!validateEmail(_email)) {
      EasyLoading.showToast(
        StringConstants.EMAIL_ERROR,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    } else {
      _appDataStorage.passwordResetEmail = _email;
      ResetPasswordRequest resetPasswordRequest = ResetPasswordRequest(_email);
      _authBloc.add(ResetPasswordEvent(resetPasswordRequest));
    }
  }
}
