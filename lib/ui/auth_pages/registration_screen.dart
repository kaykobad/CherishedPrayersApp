import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/ui/auth_pages/login_screen.dart';
import 'package:cherished_prayers/ui/auth_pages/otp_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/custom_text_fileld.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  String _nameErrorText;
  String _emailErrorText;
  String _passwordErrorText;
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameErrorText = "";
    _emailErrorText = "";
    _passwordErrorText = "";
    _obscureText = true;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController?.dispose();
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  _getLogo(),
                  _getTitle(),
                  SizedBox(height: 20.0),
                  _getNameField(),
                  SizedBox(height: 15.0),
                  _getEmailField(),
                  SizedBox(height: 15.0),
                  _getPasswordField(),
                  SizedBox(height: 30.0),
                  _getSignUpButton(context),
                  SizedBox(height: 30.0),
                  _getSignInLink(),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLogo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Center(
        child: Image.asset(
          AssetConstants.APP_LOGO,
          width: 84,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Text(
      StringConstants.SIGN_UP_TITLE,
      style: TextStyle(
        color: ColorConstants.black,
        fontSize: 36,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getNameField() {
    return CustomTextField(_nameController, StringConstants.NAME_HINT, false);
  }

  Widget _getEmailField() {
    return CustomTextField(_emailController, StringConstants.EMAIL_HINT, false);
  }

  Widget _getPasswordField() {
    return CustomTextField(_passwordController, StringConstants.PASSWORD_HINT, _obscureText, suffixWidget: _getSuffixWidget());
  }

  Widget _getSuffixWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
      child: GestureDetector(
        child: Text(
          _obscureText ? StringConstants.SHOW : StringConstants.HIDE,
          style: TextStyle(
            fontSize: 16,
            color: ColorConstants.lightPrimaryColor,
          ),
        ),
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }

  Widget _getSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: RoundedCornerButton(StringConstants.SIGN_UP, (){
          NavigationHelper.push(context, OTPScreen());
        }),
      ),
    );
  }

  Widget _getSignInLink() {
    return GestureDetector(
      child: Align(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: StringConstants.HAVE_ACCOUNT,
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: StringConstants.SIGN_IN_LINK,
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
      onTap: () => NavigationHelper.push(context, LoginScreen()),
    );
  }
}
