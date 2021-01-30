import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/ui/shared_widgets/multiline_text_input.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FeedBackScreen extends StatefulWidget {
  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  TextEditingController _feedbackController;
  double _rating;

  @override
  void initState() {
    super.initState();
    _feedbackController = TextEditingController();
    _rating = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _feedbackController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _getLogo(),
                  _getSubTitle(),
                  SizedBox(height: 30.0),
                  _getFeedbackField(),
                  SizedBox(height: 30.0),
                  _getRatingTitle(),
                  SizedBox(height: 10.0),
                  _getFeedbackStar(),
                  SizedBox(height: 30.0),
                  _getSendFeedbackButton(context),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: ColorConstants.white,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
      title: Text(
        StringConstants.FEEDBACK_TITLE,
        style: TextStyle(color: ColorConstants.black),
      ),
    );
  }

  Widget _getLogo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Center(
        child: Image.asset(
          AssetConstants.FEEDBACK,
          width: 84,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _getSubTitle() {
    return Text(
      StringConstants.FEEDBACK_SUB_TITLE,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ColorConstants.gray,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _getFeedbackField() {
    return MultilineTextField(_feedbackController, StringConstants.FEEDBACK_HINT);
  }

  Widget _getRatingTitle() {
    return Text(
      StringConstants.RATE_EXPERIENCE,
      style: TextStyle(
        color: ColorConstants.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _getFeedbackStar() {
    return SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {
          _rating = v;
          print(_rating);
        },
        starCount: 5,
        rating: _rating,
        size: 40.0,
        isReadOnly: false,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star,
        color: ColorConstants.lightPrimaryColor,
        borderColor: ColorConstants.lightPrimaryColor,
        spacing:0.0
    );
  }

  Widget _getSendFeedbackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: RoundedCornerButton(StringConstants.SHARE_FEEDBACK, (){
          // NavigationHelper.push(context, OTPScreen());
          print("Feedback");
        }),
      ),
    );
  }
}
