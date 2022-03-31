import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/settting/detailSetting/camera/CameraNotifier.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/CustomSwitch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPage extends MainScreen {

  @override
  CameraPageState createState() => CameraPageState();

  @override
  String getNameScreen() {
    return "CameraPage";
  }
}

class CameraPageState extends MainScreenState<CameraNotifier> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var percentBox = isPortrait ? 56 : 56;
    var percentBoxHeight = isPortrait ? 60 : 80;
    return Container(
      height: SizeConfig.blockSizeHorizontal * percentBoxHeight,
      width: SizeConfig.blockSizeHorizontal * percentBox,
      alignment: Alignment.topCenter,
      child: FutureBuilder<List<ItemSwitch>>(
          future: provider.getSaveItems(context),
          builder: (widget, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return MediaQuery.removePadding(
                context: context,
                child: layoutSettingCameraCapture(snapshot.data, SizeConfig.blockSizeHorizontal * percentBox),
                removeBottom: true,
                removeTop: true,
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }

  Widget layoutSettingCameraCapture(List<ItemSwitch> items, double widthBox) {
    return ListView.builder(
      padding: EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  items[index].icon,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        items[index].title ?? "",
                        style: TextStyle(fontSize: AppDestination.TEXT_NORMAL, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        width: widthBox,
                        child: Text(items[index].subtitle ?? ""),
                      )
                    ],
                  ),
                )),
                CustomSwitch(
                  activeColor: Colors.blueAccent,
                  value: items[index].isSelect,
                  onChanged: (value) {
                    provider.switchItem(context, value, items[index]);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(height: 2, thickness: 1, color: AppColor.LINE_COLOR)
          ],
        );
      },
    );
  }
}
