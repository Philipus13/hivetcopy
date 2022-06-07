import 'package:flutter/material.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/style/size_config.dart';
import 'package:hivet/core/widget/custom_button.dart';

class HistoryGuestPage extends StatefulWidget {
  HistoryGuestPage();
  @override
  createState() => _HistoryGuestPageState();
}

class _HistoryGuestPageState extends State<HistoryGuestPage> {
  _HistoryGuestPageState();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    final RoutingService _routingService = g<RoutingService>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.primary,
          centerTitle: false,
          title: Text(
            allTranslations.text("history.title"),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.white),
          //   onPressed: () {
          //     _routingService.goBackPopStack(true);
          //     _clearController();
          //   },
          // ),
          elevation: 0.0,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/notfound.png",
                  height: SizeConfig.blockSizeVertical! * 40,
                  width: SizeConfig.blockSizeHorizontal! * 100,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CustomButton(
                  isLoading: false,
                  text: allTranslations.text('auth.title_login'),
                  onPressed: () async {
                    await _routingService
                        .navigateTo(CommonConstants.routeSignIn);
                  }),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 5,
              ),
              Text(
                allTranslations.text("history.history_not_found_sub1"),
                textAlign: TextAlign.center,
                style: themeData.textTheme.headline3,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              Text(
                allTranslations.text("history.history_not_found_sub2"),
                textAlign: TextAlign.center,
                style: themeData.textTheme.headline5?.copyWith(
                    color: themeData.colorScheme.primary,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}
