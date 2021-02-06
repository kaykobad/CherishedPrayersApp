import 'dart:async';

import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/auth_pages/reset_password_screen.dart';
import 'package:cherished_prayers/ui/home_pages/home_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/logo.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'auth_bloc/auth_bloc.dart';
import 'auth_bloc/auth_event.dart';
import 'auth_bloc/auth_state.dart';

class OTPScreen extends StatefulWidget {
  final bool isRegistration;
  final String status;

  const OTPScreen({Key key, this.isRegistration=true, this.status=""}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _otpController;
  AppDataStorage _appDataStorage;
  AuthBloc _authBloc;
  StreamSubscription<AuthState> _authBlocListener;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _authBloc = _appDataStorage.authBloc;
    _listenAuthBloc();
    if (widget.status != "") {
      EasyLoading.showToast(
        widget.status,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    }
  }

  _listenAuthBloc() {
    _authBlocListener = _authBloc.listen((state) async {
      if (state is LoadingState) {
        EasyLoading.show(
          status: "Email verification in progress...",
        );
      } else if (state is ErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
            state.error.error + '\n' + state.error.details.join(' ')
        );
      } else if (state is EmailSentState) {
        await EasyLoading.dismiss();
        EasyLoading.showSuccess(
          "Email sent. Check your inbox for a verification code.", dismissOnTap: true,
        );
      } else if (state is EmailVerifiedState) {
        await EasyLoading.dismiss();
        EasyLoading.show(
          status: "Registration in progress...",
        );
        _authBloc.add(RegistrationEvent(_appDataStorage.registerRequest));
      } else if (state is RegistrationSuccessfulState) {
        await EasyLoading.dismiss();
        _appDataStorage.userData = state.authUserData;
        NavigationHelper.pushAndRemoveAll(context, HomeScreen());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authBlocListener?.cancel();
    _otpController?.dispose();
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
                  SizedBox(height: 20.0),
                  _getVerificationHint(),
                  SizedBox(height: 30.0),
                  _getOTPField(),
                  SizedBox(height: 40.0),
                  _getVerifyButton(context),
                  SizedBox(height: 40.0),
                  _getResendOTPLink(),
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
      StringConstants.EMAIL_VERIFICATION,
      style: TextStyle(
        color: ColorConstants.black,
        fontSize: 32,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getVerificationHint() {
    return Text(
      StringConstants.EMAIL_VERIFICATION_HINT,
      style: TextStyle(
        color: ColorConstants.gray,
        fontSize: 16,
      ),
    );
  }

  Widget _getOTPField() {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: TextStyle(
        color: ColorConstants.black,
        fontWeight: FontWeight.w400,
      ),
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.underline,
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: ColorConstants.backGroundGray,
        inactiveColor: ColorConstants.backGroundGray,
        inactiveFillColor: ColorConstants.backGroundGray,
        activeColor: ColorConstants.backGroundGray,
        selectedColor: ColorConstants.lightPrimaryColor,
        selectedFillColor: ColorConstants.backGroundGray,
      ),
      cursorColor: Colors.black,
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: _otpController,
      keyboardType: TextInputType.text,
      onChanged: (v) {
        print(v);
      },
    );
  }

  Widget _getVerifyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: RoundedCornerButton(StringConstants.VERIFY, _verifyAndRegister),
      ),
    );
  }

  Widget _getResendOTPLink() {
    return GestureDetector(
      child: Align(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: StringConstants.NOT_SENT_CODE,
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: StringConstants.RESEND,
                style: TextStyle(
                  color: ColorConstants.lightPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: _resendOTP,
    );
  }

  void _resendOTP() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (widget.isRegistration) {
      String _email = _appDataStorage.registerRequest.email;
      VerifyEmailRequest verifyEmailRequest = VerifyEmailRequest(_email);
      _authBloc.add(VerifyEmailEvent(verifyEmailRequest));
    } else {
      String _email = _appDataStorage.passwordResetEmail;
      ResetPasswordRequest resetPasswordRequest = ResetPasswordRequest(_email);
      _authBloc.add(ResetPasswordEvent(resetPasswordRequest));
    }
  }

  void _verifyAndRegister() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (widget.isRegistration) {
      String _otp = _otpController.text;
      ConfirmVerifyEmailRequest confirmVerifyEmailRequest = ConfirmVerifyEmailRequest(_appDataStorage.registerRequest.email, _otp);
      _authBloc.add(ConfirmEmailVerificationEvent(confirmVerifyEmailRequest));
    } else {
      _appDataStorage.passwordResetOTP = _otpController.text;
      NavigationHelper.push(context, ResetPasswordScreen());
    }
  }
}
