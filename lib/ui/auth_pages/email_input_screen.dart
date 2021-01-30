import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/ui/auth_pages/otp_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/custom_text_fileld.dart';
import 'package:cherished_prayers/ui/shared_widgets/logo.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';

class EmailInputScreen extends StatefulWidget {
  @override
  _EmailInputScreenState createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  TextEditingController _emailController;
  String _emailErrorText;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailErrorText = "";
  }

  @override
  void dispose() {
    super.dispose();
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
        child: RoundedCornerButton(StringConstants.SEND_OTP, (){
          NavigationHelper.push(context, OTPScreen());
        }),
      ),
    );
  }
}
