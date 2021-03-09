import 'dart:async';

import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_bloc/settings_bloc.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_bloc/settings_event.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_bloc/settings_state.dart';
import 'package:cherished_prayers/ui/shared_widgets/banner_widget.dart';
import 'package:cherished_prayers/ui/shared_widgets/multiline_text_input.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ReportABugScreen extends StatefulWidget {
  @override
  _ReportABugScreenState createState() => _ReportABugScreenState();
}

class _ReportABugScreenState extends State<ReportABugScreen> {
  TextEditingController _reportBugController;
  AppDataStorage _appDataStorage;
  SettingsBloc _settingsBloc;
  StreamSubscription<SettingsState> _settingsBlocListener;

  @override
  void initState() {
    super.initState();
    _reportBugController = TextEditingController();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _settingsBloc = _appDataStorage.settingsBloc;
    _listenSettingsBloc();
  }

  _listenSettingsBloc() {
    _settingsBlocListener = _settingsBloc.listen((state) async {
      if (state is LoadingSettingsState) {
        EasyLoading.show(
          status: "Reporting bug...",
        );
      } else if (state is ErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
            state.error.error + '\n' + state.error.details.join(' ')
        );
      } else if (state is BugReportedState) {
        await EasyLoading.dismiss();
        setState(() {
          _reportBugController.clear();
        });
        EasyLoading.showSuccess("Bug reported. We will be fixing the issue very soon.");
      }
    });
  }

  @override
  void dispose() {
    _reportBugController?.dispose();
    _settingsBlocListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(height: 1.0, color: ColorConstants.gray),
              BannerWidget(text: "REPORT A BUG"),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Icon(Icons.bug_report, color: ColorConstants.lightPrimaryColor, size: 80.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Report a bug",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(height: 1.0, color: ColorConstants.gray),
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _getReportField(),
              ),
              SizedBox(height: 24.0),
              RoundedCornerButton("                    SUBMIT                    ", onReportBugPressed)
            ],
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Text("Settings", style: TextStyle(color: ColorConstants.black)),
      centerTitle: true,
      backgroundColor: ColorConstants.white,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
    );
  }

  Widget _getReportField() {
    return MultilineTextField(_reportBugController, "Write report here...");
  }

  void onReportBugPressed() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    String text = _reportBugController.text.trim();
    if (text == null || text == "") {
      EasyLoading.showToast(
        "Please write something.",
        dismissOnTap: true,
        toastPosition: EasyLoadingToastPosition.bottom,
      );
    } else {
      ReportBugRequest reportBugRequest = ReportBugRequest(text);
      _settingsBloc.add(ReportABugEvent(reportBugRequest, _appDataStorage.authToken));
    }
  }
}
