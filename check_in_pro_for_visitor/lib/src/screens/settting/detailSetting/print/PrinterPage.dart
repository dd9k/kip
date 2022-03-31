import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/CustomSwitch.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PrinterNotifier.dart';

class PrinterPage extends MainScreen {

  @override
  MainScreenState createState() => PrinterPageState();

  @override
  String getNameScreen() {
    return "PrinterPage";
  }
}

class PrinterPageState extends MainScreenState<PrintNotifier> {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var percentBox = isPortrait ? 56 : 56;
    var percentBoxHeight = isPortrait ? 60 : 80;
    var percentChildren = isPortrait ? 50 : 20;
    return FutureBuilder<List<ItemSwitch>>(
      future: provider.getSaveItems(),
      builder: (context, dataItem) {
        if (dataItem.connectionState == ConnectionState.done) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildSwitch(dataItem.data),
              Expanded(
                child: Selector<PrintNotifier, bool>(
                  builder: (context, data, child) {
                    return FutureBuilder<List<PrinterModel>>(
                      builder: (context, data) {
                        if (data.connectionState == ConnectionState.waiting || !data.hasData || data.data.isEmpty) {
                          if (data.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(AppLocalizations.of(context).searchPrinter,
                                      style: TextStyle(
                                        fontSize: AppDestination.TEXT_NORMAL,
                                      ))
                                ],
                              ),
                            );
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.print,
                                  size: 128,
                                  color: AppColor.HINT_TEXT_COLOR,
                                ),
                                Text(AppLocalizations.of(context).noPrinter,
                                    style: TextStyle(
                                      fontSize: AppDestination.TEXT_NORMAL,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        }
                        return Container(
                          height: double.infinity,
                          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Selector<PrintNotifier, bool>(
                            builder: (widget, data, child) => Container(
                              height: SizeConfig.blockSizeHorizontal * percentBoxHeight,
                              width: SizeConfig.blockSizeHorizontal * percentBox,
                              alignment: Alignment.topCenter,
                              child: layoutSettingPrint(),
                            ),
                            selector: (buildContext, provider) => provider.isReload,
                          ),
                        );
                      },
                      future: provider.findAllPrinter(context),
                    );
                  },
                  selector: (buildContext, provider) => provider.isLoading,
                ),
              ),
              Selector<PrintNotifier, bool>(
                builder: (context, data, child) {
                  return Container(
                    padding: EdgeInsets.only(top: 15),
                    height: 50,
                    width: SizeConfig.blockSizeHorizontal * percentChildren,
                    child: RaisedGradientButton(
                      disable: provider.isLoading,
                      height: 50,
                      isLoading: false,
                      btnText: AppLocalizations.of(context).refresh,
                      onPressed: () {
                        provider.devices.clear();
                        provider.memCache = AsyncMemoizer();
                        provider.reload();
                      },
                    ),
                  );
                },
                selector: (buildContext, provider) => provider.isLoading,
              )
            ],
          );
        }
        return Center(
          child: Container(),
        );
      },
    );
  }

  Widget buildSwitch(List<ItemSwitch> items) {
    return ListView.builder(
      padding: EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                          Text(items[index].subtitle ?? "")
                        ],
                      ),
                    )),
                CustomSwitch(
                  activeColor: Colors.blueAccent,
                  value: items[index].isSelect,
                  onChanged: (value) {
                    provider.switchItem(value, items[index]);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(height: 2, thickness: 1, color: AppColor.LINE_COLOR)
          ],
        );
      },
    );
  }

  Widget layoutSettingPrint() {
    var provider = Provider.of<PrintNotifier>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            shrinkWrap: true,
            itemCount: provider.devices.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    AppLocalizations.of(context).titlePrinter,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: AppDestination.TEXT_MORE_BIG),
                  ),
                );
              }
              var devices = provider.devices[index - 1];
              return Column(
                children: <Widget>[
                  Container(
                    height: 70,
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.print,
                            size: 32,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${devices.model}',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${devices.ipAddress}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: 7,
                                                height: 7,
                                                margin: const EdgeInsets.symmetric(vertical: 2),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                  color: devices.isConnect ? Colors.green : Colors.red,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    devices.isConnect
                                                        ? AppLocalizations.of(context).connected
                                                        : AppLocalizations.of(context).disconnected,
                                                    style: TextStyle(color: Colors.grey[700])),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              devices.isConnect
                                  ? SizedBox(
                                      width: 100,
                                      height: 30,
                                      child: RaisedButton(
                                        onPressed: () {
                                          if (devices.isConnect) {
                                            provider.printTest(context, devices);
                                          }
                                        },
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                                        padding: const EdgeInsets.all(0.0),
                                        child: Ink(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: const [Color(0xff0359D4), Color(0xff0294B4)],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                          ),
                                          child: Container(
                                            constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                                            // min sizes for Material buttons
                                            alignment: Alignment.center,
                                            child: Text(
                                              AppLocalizations.of(context).printTest,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 100,
                                height: 30,
                                child: RaisedButton(
                                  onPressed: () {
                                    provider.connectPrinter(context, devices);
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                                  padding: const EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: !devices.isConnect
                                          ? LinearGradient(
                                              colors: [Color(0xff0359D4), Color(0xff0294B4)],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            )
                                          : LinearGradient(
                                              colors: [Color(0xFFC32B2B), Color(0xFFC11B2B)],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                                      // min sizes for Material buttons
                                      alignment: Alignment.center,
                                      child: Text(
                                        devices.isConnect
                                            ? AppLocalizations.of(context).disconnect
                                            : AppLocalizations.of(context).connect,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
