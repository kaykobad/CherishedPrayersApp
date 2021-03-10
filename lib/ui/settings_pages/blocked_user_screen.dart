import 'dart:async';

import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_bloc/settings_bloc.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_bloc/settings_event.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_bloc/settings_state.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:cherished_prayers/ui/shared_widgets/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BlockedUsersScreen extends StatefulWidget {
  @override
  _BlockedUsersScreenState createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  AppDataStorage _appDataStorage;
  SettingsBloc _settingsBloc;
  StreamSubscription<SettingsState> _settingsBlocListener;
  List<GenericUserResponse> _blockedUsers = [];

  @override
  void initState() {
    super.initState();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _settingsBloc = _appDataStorage.settingsBloc;
    _settingsBloc.add(FetchBlockedUsersEvent(_appDataStorage.authToken));
    _listenSettingsBloc();
  }

  _listenSettingsBloc() {
    _settingsBlocListener = _settingsBloc.listen((state) async {
      if (state is LoadingSettingsState) {
        EasyLoading.show(
          status: "Unblocking user...",
        );
      } else if (state is ErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
            state.error.error + '\n' + state.error.details.join(' ')
        );
      } else if (state is BlockedUsersFetchedState) {
        await EasyLoading.dismiss();
        setState(() {
          _blockedUsers = state.blockedUsersResponse.blockedUsers;
        });
      }
    });
  }

  @override
  void dispose() {
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
              BannerWidget(text: "BLOCKED ACCOUNTS"),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Icon(Icons.block_rounded, color: ColorConstants.lightPrimaryColor, size: 80.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Accounts blocked by you",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              _getDividerWithPadding(),
              SizedBox(height: 12.0),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => buildItem(_blockedUsers[index]),
                itemCount: _blockedUsers.length,
              ),
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

  Widget _getDividerWithPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Divider(height: 1.0, color: Colors.grey[400]),
    );
  }

  Widget buildItem(user) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAvatar(url: (user.avatar == "" || user.avatar == null) ? null : ApiEndpoints.URL_ROOT + user.avatar, size: 60.0),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          user.firstName,
                          style: TextStyle(
                            color: ColorConstants.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          user.religion,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: ColorConstants.gray),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 10.0),
                ),
              ),
              SizedBox(width: 8.0),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  print('Unblock user');
                },
                child: Container(
                  child: Text(
                    "Unblock",
                    style: TextStyle(
                      color: ColorConstants.lightPrimaryColor,
                      fontSize: 11,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    border: Border.all(color:ColorConstants.lightPrimaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(4))
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        _getDividerWithPadding(),
        SizedBox(height: 12.0),
      ],
    );
  }
}
