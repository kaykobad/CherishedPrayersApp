import 'dart:async';

import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/shared_widgets/multiline_text_input.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'profile_and_feedback_bloc/profile_and_feedback_bloc.dart';
import 'profile_and_feedback_bloc/profile_and_feedback_event.dart';
import 'profile_and_feedback_bloc/profile_and_feedback_state.dart';

class FeedBackScreen extends StatefulWidget {
  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  TextEditingController _feedbackController;
  int _rating;
  ProfileAndFeedbackBloc _feedbackBloc;
  StreamSubscription<ProfileAndFeedbackState> _listenFeedbackState;
  String _authToken;

  @override
  void initState() {
    super.initState();
    _feedbackController = TextEditingController();
    _rating = 0;
    _authToken = RepositoryProvider.of<AppDataStorage>(context).authToken;
    _feedbackBloc = ProfileAndFeedbackBloc(ProfileAndFeedbackInitialState());
    _listenFeedbackBloc();
  }

  _listenFeedbackBloc() {
    _listenFeedbackState = _feedbackBloc.listen((state) async {
      if (state is ProfileAndFeedbackLoadingState) {
        EasyLoading.show(
          status: "Sending feedback...",
        );
      } else if (state is ProfileAndFeedbackErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
          state.error.error + '\n' + state.error.details.join(' '),
        );
      } else if (state is FeedbackSentState) {
        await EasyLoading.dismiss();
        EasyLoading.showSuccess(state.feedbackResponse.detail);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listenFeedbackState?.cancel();
    _feedbackBloc?.close();
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
        _rating = v.toInt();
      },
      starCount: 5,
      rating: _rating.toDouble(),
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
        child: RoundedCornerButton(StringConstants.SHARE_FEEDBACK, _sendFeedback),
      ),
    );
  }

  void _sendFeedback() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    String _feedback = _feedbackController.text;

    if (_feedback == "" || _feedback == null) {
      EasyLoading.showToast(
        "Please write something on feedback field",
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    } else if (_rating == 0) {
      EasyLoading.showToast(
        "Please provide a rating",
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    } else {
      FeedbackRequest feedbackRequest = FeedbackRequest(_feedback, _rating);
      _feedbackBloc.add(SendFeedbackEvent(feedbackRequest, _authToken));
    }
  }
}
