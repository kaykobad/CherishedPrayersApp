import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/ui/auth_pages/login_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/custom_text_fileld.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _passwordController;
  TextEditingController _passwordController2;
  String _passwordErrorText;
  bool _obscureText;
  bool _obscureText2;


  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordController2 = TextEditingController();
    _passwordErrorText = "";
    _obscureText = true;
    _obscureText2 = true;
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController?.dispose();
    _passwordController2?.dispose();
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
                  _getLogo(),
                  _getTitle(),
                  SizedBox(height: 30.0),
                  _getPasswordField(),
                  SizedBox(height: 15.0),
                  _getPasswordField2(),
                  SizedBox(height: 40.0),
                  _getResetPasswordButton(context),
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
      padding: const EdgeInsets.only(bottom: 40.0),
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
      StringConstants.RESET_PASSWORD,
      style: TextStyle(
        color: ColorConstants.black,
        fontSize: 36,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getPasswordField() {
    return CustomTextField(_passwordController, StringConstants.NEW_PASSWORD_HINT, _obscureText, suffixWidget: _getSuffixWidget());
  }

  Widget _getPasswordField2() {
    return CustomTextField(_passwordController2, StringConstants.NEW_PASSWORD_2_HINT, _obscureText2, suffixWidget: _getSuffixWidget2());
  }

  Widget _getResetPasswordButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: RoundedCornerButton(StringConstants.RESET_PASSWORD_BUTTON, (){
          NavigationHelper.push(context, LoginScreen());
        }),
      ),
    );
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

  Widget _getSuffixWidget2() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
      child: GestureDetector(
        child: Text(
          _obscureText2 ? StringConstants.SHOW : StringConstants.HIDE,
          style: TextStyle(
            fontSize: 16,
            color: ColorConstants.lightPrimaryColor,
          ),
        ),
        onTap: () {
          setState(() {
            _obscureText2 = !_obscureText2;
          });
        },
      ),
    );
  }
}