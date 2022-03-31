import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/model/BranchInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/UserInfor.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/settting/SettingScreen.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Validator.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'LocationPageNotifier.dart';

class LocationPage extends MainScreen {

  @override
  LocationPageState createState() => LocationPageState();

  @override
  String getNameScreen() {
    return "LocationPage";
  }
}

class LocationPageState extends MainScreenState<LocationPageNotifier> with TickerProviderStateMixin {
  TextEditingController _deviceNameController = new TextEditingController();
  GlobalKey<FormState> _deviceNameKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Background.of(context).updateReload(false);
    SettingScreen.of(context).updateReload(false);
    var percentBox = isPortrait ? 56 : 56;
    var percentChildren = isPortrait ? 50 : 20;
    var percentTextName = isPortrait ? 60 : 30;
    var percentBoxHeight = isPortrait ? 60 : 80;
    return Container(
      height: SizeConfig.blockSizeVertical * percentBoxHeight,
      width: SizeConfig.blockSizeHorizontal * percentBox,
      child: FutureBuilder<UserInfor>(
          future: provider.getCurrentInfor(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (_deviceNameController.text.isEmpty) {
                _deviceNameController.text = snapshot.data.deviceInfo.name;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "${AppLocalizations.of(context).deviceLabel}:",
                          style: TextStyle(color: Colors.black, fontSize: AppDestination.TEXT_NORMAL),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                              width: SizeConfig.blockSizeHorizontal * percentTextName,
                              child: Form(
                                key: _deviceNameKey,
                                child: TextFormField(
                                  validator: Validator(context).validateDeviceName,
                                  controller: _deviceNameController,
                                  textCapitalization: TextCapitalization.sentences,
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(30),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context).translate(AppString.HINT_IPAD_NAME),
                                    contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15, top: 3),
                              child: Text(
                                AppLocalizations.of(context).translate(AppString.ENTER_IPAD_NAME),
                                style: Styles.gpText,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      child: _buildLocationList(context),
                      removeBottom: true,
                      removeTop: true,
                    ),
                  ),
                  Selector<LocationPageNotifier, bool>(
                    builder: (context, data, child) {
                      return Container(
                        padding: EdgeInsets.only(top: 15),
                        height: 50,
                        width: SizeConfig.blockSizeHorizontal * percentChildren,
                        child: RaisedGradientButton(
                          disable: provider.isLoading,
                          height: 50,
                          isLoading: true,
                          btnController: provider.btnController,
                          btnText: AppLocalizations.of(context).btnSave,
                          onPressed: () {
                            if (_deviceNameKey.currentState.validate()) {
                              Utilities().hideKeyBoard(context);
                              Utilities().showTwoButtonDialog(
                                  context,
                                  DialogType.WARNING,
                                  null,
                                  AppLocalizations.of(context).translate(AppString.TITLE_NOTIFICATION),
                                  AppLocalizations.of(context).updateDevice,
                                  AppLocalizations.of(context).translate(AppString.BUTTON_NO),
                                  AppLocalizations.of(context).translate(AppString.BUTTON_YES), () {
                                provider.btnController.stop();
                              }, () {
                                provider.requestApiUpdate(context, _deviceNameController.text);
                              });
                            } else {
                              provider.btnController.stop();
                            }
                          },
                        ),
                      );
                    },
                    selector: (buildContext, provider) => provider.isLoading,
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget _buildLocationList(BuildContext context) {
    var provider = Provider.of<LocationPageNotifier>(context, listen: false);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentSuggestHeight = isPortrait ? 40 : 30;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    var aspectRatio = itemWidth / itemHeight;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      aspectRatio = itemHeight / itemWidth;
    }
    return FutureBuilder<List<BranchInfor>>(
      builder: (context, data) {
        if (data.connectionState == ConnectionState.none || !data.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Selector<LocationPageNotifier, bool>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: data.data.length,
              itemBuilder: (context, index) {
                var branchInfor = data.data[index];
                return itemLocation(branchInfor);
              },
            );
          },
          selector: (buildContext, provider) => provider.isReload,
        );
      },
      future: provider.getLocation(this.context),
    );
  }

  Widget itemLocation(BranchInfor locationInfor) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentBox = isPortrait ? 40 : 40;
    var provider = Provider.of<LocationPageNotifier>(context, listen: false);
    return GestureDetector(
      onTap: () => provider.updateBranch(locationInfor),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  locationInfor.isSelect ? Icons.check_circle : Icons.language,
                  size: 32,
                  color: locationInfor.isSelect ? AppColor.MAIN_TEXT_COLOR : AppColor.HINT_TEXT_COLOR,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * percentBox,
                    child: Text(locationInfor.branchName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL)),
                  ),
                  SizedBox(
                      width: SizeConfig.blockSizeHorizontal * percentBox,
                      child: Text(locationInfor?.branchAddress ?? "",
                          style: TextStyle(fontSize: AppDestination.TEXT_NORMAL - 5))),
                ],
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(height: 2, thickness: 1, color: AppColor.LINE_COLOR)
        ],
      ),
    );
  }
}
