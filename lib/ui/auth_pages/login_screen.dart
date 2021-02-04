import 'dart:async';

import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/helpers/input_validator.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/home_pages/home_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/custom_text_fileld.dart';
import 'package:cherished_prayers/ui/shared_widgets/logo.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'auth_bloc/auth_bloc.dart';
import 'auth_bloc/auth_event.dart';
import 'auth_bloc/auth_state.dart';
import 'email_input_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  AppDataStorage _appDataStorage;
  AuthBloc _authBloc;
  StreamSubscription<AuthState> _authBlocListener;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _authBloc = _appDataStorage.authBloc;
    _listenAuthBloc();
  }

  _listenAuthBloc() {
    _authBlocListener = _authBloc.listen((state) async {
      if (state is LoadingState) {
        EasyLoading.show(
          status: "Login in progress...",
        );
      } else if (state is ErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
          state.error.error + '\n' + state.error.details.join(' ')
        );
      } else if (state is LoginSuccessfulState) {
        await EasyLoading.dismiss();
        _appDataStorage.userData = state.authUserData;
        NavigationHelper.pushAndRemoveAll(context, HomeScreen());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    _authBlocListener?.cancel();
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
                  SizedBox(height: 30.0),
                  _getEmailField(),
                  SizedBox(height: 15.0),
                  _getPasswordField(),
                  SizedBox(height: 5.0),
                  _getForgotPasswordLink(),
                  SizedBox(height: 40.0),
                  _getSignInButton(context),
                  SizedBox(height: 40.0),
                  _getSignUpLink(),
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
      StringConstants.SIGN_IN_TITLE,
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

  Widget _getPasswordField() {
    return CustomTextField(_passwordController, StringConstants.PASSWORD_HINT, true);
  }

  Widget _getForgotPasswordLink() {
    return GestureDetector(
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          StringConstants.FORGOT_PASSWORD,
          style: TextStyle(
            color: ColorConstants.lightPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onTap: () {
        NavigationHelper.push(context, EmailInputScreen());
      },
    );
  }

  Widget _getSignInButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: RoundedCornerButton(StringConstants.SIGN_IN, _login),
      ),
    );
  }

  Widget _getSignUpLink() {
    return GestureDetector(
      child: Align(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: StringConstants.NO_ACCOUNT,
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: StringConstants.SIGN_UP_LINK,
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
      onTap: () => NavigationHelper.push(context, RegisterScreen()),
    );
  }

  void _login() {
    String _email = _emailController.text;
    String _password = _passwordController.text;

    if (!validateEmail(_email)) {
      EasyLoading.showToast(
        StringConstants.EMAIL_ERROR,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    }
    else if (!validatePassword(_password)) {
      EasyLoading.showToast(
        StringConstants.PASSWORD_ERROR,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    }
    else {
      LoginRequest loginRequest = LoginRequest(_email, _password);
      _authBloc.add(LoginEvent(loginRequest));
    }
  }
}
