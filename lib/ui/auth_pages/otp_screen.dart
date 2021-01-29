import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/ui/auth_pages/reset_password_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _otpController;
  String _otpErrorText;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _otpErrorText = "";
  }

  @override
  void dispose() {
    super.dispose();
    _otpController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                SizedBox(height: 20.0),
                _getVerificationHint(),
                SizedBox(height: 30.0),
                _getOTPField(),
                SizedBox(height: 40.0),
                _getVerifyButton(context),
                SizedBox(height: 40.0),
                _getResendOTPLink(),
              ],
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
        child: RoundedCornerButton(StringConstants.VERIFY, (){
          NavigationHelper.push(context, ResetPasswordScreen());
        }),
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
      onTap: () => print("resend"),
    );
  }
}
