import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/ui/auth_pages/email_input_screen.dart';
import 'package:cherished_prayers/ui/auth_pages/registration_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/custom_text_fileld.dart';
import 'package:cherished_prayers/ui/shared_widgets/logo.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  String _emailErrorText;
  String _passwordErrorText;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailErrorText = "";
    _passwordErrorText = "";
  }

  @override
  void dispose() {
    super.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
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
        child: RoundedCornerButton(StringConstants.SIGN_IN, (){
          // NavigationHelper.push(context, LoginScreen());
        }),
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
}
