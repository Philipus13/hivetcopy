import 'package:flutter/material.dart';
// import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/style/size_config.dart';
// import 'package:hivet/core/widget/custom_button.dart';
import 'package:hivet/features/home_doctor/presentation/home_doctor_page.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage();
  @override
  createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  _HistoryPageState();
  List<String> sliderHeaders = ['Konsultasi', 'Transaksi Toko'];
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    // final RoutingService _routingService = g<RoutingService>();

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
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              TabBar(
                indicatorColor: themeData.colorScheme.primary,
                // themeData.colorScheme.primary.withOpacity(0.6),
                tabs: sliderHeaders
                    .map((e) => Tab(
                          child: Text(
                            e,
                            style: TextStyle(
                              fontSize: 16,
                              color: themeData.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                    .toList(),
                controller: tabController,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    HomeDoctorPage('pengguna'),
                    HomeDoctorPage('pengguna'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
