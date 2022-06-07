import 'package:flutter/material.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/notification/notification.dart';
import 'package:hivet/features/doctor_slot/presentation/doctor_slot_page.dart';
import 'package:hivet/features/history/history_guest_page.dart';
import 'package:hivet/features/history/history_page.dart';
import 'package:hivet/features/home/presentation/home_page.dart';
import 'package:hivet/features/home_doctor/presentation/home_doctor_page.dart';
import 'package:hivet/features/init/presentation/tab_navigation_builder.dart';
import 'package:hivet/features/album/presentation/album_page.dart';
import 'package:hivet/features/profile/presentation/profile_page.dart';

class TabPage extends StatefulWidget {
  final String scopes;

  TabPage({Key? key, required this.scopes}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    NotificationHelper().firebaseCloudMessagingListeners(context);
    NotificationHelper().getterFCMToken();
    return TabNavigationBuilder(
      scopes: widget.scopes,
      builder: (context, tabItem) {
        if (tabItem == TabItem.one) {
          if (widget.scopes == CommonConstants.doctor) {
            return HomeDoctorPage(widget.scopes);
          }

          return HomePage(widget.scopes);
        } else if (tabItem == TabItem.two) {
          if (widget.scopes == CommonConstants.pengguna) {
            return HistoryPage();
          }
          return HistoryGuestPage();
        } else if (tabItem == TabItem.three) {
          if (widget.scopes == CommonConstants.pengguna) {
            return AlbumPage(mode: 1);
          } else if (widget.scopes == CommonConstants.doctor) {
            return DoctorSlotWPage();
          } else if (widget.scopes == CommonConstants.toko) {
            return AlbumPage(mode: 1);
          } else {
            return AlbumPage(mode: 1);
          }
        } else {
          return ProfilePage(scopes: widget.scopes);
        }
      },
    );
  }
}
