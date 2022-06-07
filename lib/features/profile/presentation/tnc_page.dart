import 'package:flutter/material.dart';
import 'package:hivet/core/config/global_translations.dart';

class TNCPage extends StatefulWidget {
  TNCPage();
  @override
  createState() => _TNCPageState();
}

class _TNCPageState extends State<TNCPage> {
  _TNCPageState();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.primary,
          centerTitle: false,
          title: Text(
            allTranslations.text("profile.tnc"),
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
          padding: const EdgeInsets.only(top: 18, left: 18),
          child: Column(
            children: [
              Text(
                allTranslations.text("profile.tnc"),
                textAlign: TextAlign.center,
                style: themeData.textTheme.headline3,
              ),
            ],
          ),
        ));
  }
}
