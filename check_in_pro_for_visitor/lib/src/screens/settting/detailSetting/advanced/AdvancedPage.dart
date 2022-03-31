import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/model/Event.dart';
import 'package:check_in_pro_for_visitor/src/model/EventTicket.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/CustomSwitch.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AdvancedNotifier.dart';

class AdvancedPage extends MainScreen {
  final Function(bool) onLoading;
  static const String route_name = '/advancedPage';

  AdvancedPage(this.onLoading);

  @override
  AdvancedPageState createState() => AdvancedPageState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class AdvancedPageState extends MainScreenState<AdvancedNotifier> with TickerProviderStateMixin {
  bool status = false;
  bool isInit = false;
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!isInit) {
      isInit = true;
      tabController = TabController(length: 2, vsync: this);
    }
    var percentBox = isPortrait ? 56 : 56;
    var percentBoxHeight = isPortrait ? 60 : 80;
    return Container(
      height: heightScreen * percentBoxHeight,
      width: widthScreen * percentBox,
      alignment: Alignment.topCenter,
      child: FutureBuilder<List<ItemSwitch>>(
          future: provider.getSaveItems(),
          builder: (widget, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if (!provider.isHaveEvent) {
                return Container(
                  height: SizeConfig.blockSizeHorizontal * percentBoxHeight,
                  width: SizeConfig.blockSizeHorizontal * percentBox,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.event,
                        size: 128,
                        color: AppColor.HINT_TEXT_COLOR,
                      ),
                      Text(
                        AppLocalizations.of(context).noFunction,
                        style: TextStyle(fontSize: AppDestination.TEXT_NORMAL),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              }
              return loadingList(snapshot.data);
            }
            return Container(
              height: SizeConfig.blockSizeHorizontal * percentBoxHeight,
              width: SizeConfig.blockSizeHorizontal * percentBox,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget loadingList(List<ItemSwitch> items) {
    var percentChildren = isPortrait ? 50 : 20;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ListView.builder(
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
        ),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            child: _buildLocationList(context),
            removeBottom: true,
            removeTop: true,
          ),
        ),
        buttonSync(),
      ],
    );
  }

  Widget buttonSync() {
    var percentBox = isPortrait ? 50 : 20;
    return Selector<AdvancedNotifier, bool>(
      builder: (widget, data, child) => Visibility(
        visible: data,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          height: 50,
          width: SizeConfig.blockSizeHorizontal * percentBox,
          child: RaisedGradientButton(
            disable: false,
            btnText: appLocalizations.syncBtn,
            onPressed: () {
              if (provider.eventId != null) {
                provider.getEventDetails(context, (this.widget as AdvancedPage).onLoading);
              } else if (provider.eventTicketId != null) {
                provider.preferences.setBool(Constants.KEY_SYNC_EVENT, true);
                provider.utilities.showNoButtonDialog(context, true, DialogType.SUCCES, Constants.AUTO_HIDE_LITTLE,
                    appLocalizations.successTitle, appLocalizations.successTitle, null);
              } else {

              }
            },
          ),
        ),
      ),
      selector: (buildContext, provider) => provider.eventMode,
    );
  }

  Widget _buildLocationList(BuildContext context) {
    var percentSuggestHeight = isPortrait ? 40 : 30;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    var aspectRatio = itemWidth / itemHeight;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      aspectRatio = itemHeight / itemWidth;
    }
    Widget childEvent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.event,
          size: 128,
          color: AppColor.HINT_TEXT_COLOR,
        ),
        Text(AppLocalizations.of(context).noEvent,
            style: TextStyle(
              fontSize: AppDestination.TEXT_NORMAL,
            ),
            textAlign: TextAlign.center),
        SizedBox(
          height: 10,
        ),
      ],
    );
    if (provider.isEventTicket && provider?.listEventTicket?.isNotEmpty == true) {
      childEvent = buildEventTicket();
    } else if (!provider.isEventTicket && provider?.listEvent?.isNotEmpty == true) {
      childEvent = buildNormalEvent();
    }
    return Selector<AdvancedNotifier, bool>(
      builder: (context, visible, child) {
        return Visibility(
          visible: provider.eventMode,
          child: childEvent,
        );
      },
      selector: (buildContext, provider) => provider.eventMode,
    );
    return Selector<AdvancedNotifier, bool>(
      builder: (context, visible, child) {
        return Visibility(
          visible: provider.eventMode,
          child: childEvent,
        );
      },
      selector: (buildContext, provider) => provider.eventMode,
    );
  }

  Widget buildNormalEvent() {
    return Selector<AdvancedNotifier, bool>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: provider.listEvent.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  AppLocalizations.of(context).titleEvent,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: AppDestination.TEXT_MORE_BIG),
                ),
              );
            }
            var event = provider.listEvent[index - 1];
            return itemEvent(event);
          },
        );
      },
      selector: (buildContext, provider) => provider.isReload,
    );
  }

  Widget itemEvent(Event event) {
    var percentBox = isPortrait ? 40 : 40;
    return GestureDetector(
      onTap: () => provider.updateList(event),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  event.isSelect ? Icons.check_circle : Icons.language,
                  size: 32,
                  color: event.isSelect ? AppColor.MAIN_TEXT_COLOR : AppColor.HINT_TEXT_COLOR,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * percentBox,
                    child: Text(event.eventName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL)),
                  ),
                  SizedBox(
                      width: SizeConfig.blockSizeHorizontal * percentBox,
                      child:
                          Text(event?.siteAddress ?? "", style: TextStyle(fontSize: AppDestination.TEXT_NORMAL - 5))),
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

  Widget buildEventTicket() {
    return Selector<AdvancedNotifier, bool>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: provider.listEventTicket.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  AppLocalizations.of(context).titleEvent,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: AppDestination.TEXT_MORE_BIG),
                ),
              );
            }
            var event = provider.listEventTicket[index - 1];
            return itemEventTicket(event);
          },
        );
      },
      selector: (buildContext, provider) => provider.isReloadTicket,
    );
  }

  Widget itemEventTicket(EventTicket event) {
    var percentBox = isPortrait ? 40 : 40;
    return GestureDetector(
      onTap: () => provider.updateListTicket(event),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  event.isSelect ? Icons.check_circle : Icons.language,
                  size: 32,
                  color: event.isSelect ? AppColor.MAIN_TEXT_COLOR : AppColor.HINT_TEXT_COLOR,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * percentBox,
                    child: Text(event.eventName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL)),
                  ),
                  SizedBox(
                      width: SizeConfig.blockSizeHorizontal * percentBox,
                      child:
                      Text(event?.siteAddress ?? "", style: TextStyle(fontSize: AppDestination.TEXT_NORMAL - 5))),
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
