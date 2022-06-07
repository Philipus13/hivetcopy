import 'package:flutter/material.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/style/custom_colors.dart';
import 'package:hivet/core/widget/icon_image_tab.dart';

enum TabItem { one, two, three, four }

class TabNavigationBuilder extends StatefulWidget {
  const TabNavigationBuilder(
      {Key? key, required this.builder, required this.scopes})
      : super(key: key);
  final Widget Function(BuildContext, TabItem) builder;
  final String scopes;

  @override
  _TabNavigationBuilderState createState() => _TabNavigationBuilderState();
}

class _TabNavigationBuilderState extends State<TabNavigationBuilder> {
  TabItem _currentTab = TabItem.one;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: widget.builder(context, _currentTab),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 20),
        child: Material(
          color: themeData.colorScheme.primary,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          child: BottomNavigation(
            currentTab: _currentTab,
            scopes: widget.scopes,
            onSelectTab: (tab) => setState(() => _currentTab = tab),
          ),
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {required this.currentTab,
      required this.scopes,
      required this.onSelectTab});
  final TabItem currentTab;
  final String scopes;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // var test = {
    //   "test": "password",
    // };
    Widget icon;
    Widget activeIcon;
    String labels;
    if (scopes == CommonConstants.toko) {
      icon = IconImageTab(
        imageAsset: 'assets/images/bottom_store_icon.png',
        colors: themeData.colorScheme.background,
      );
      activeIcon = IconImageTab(
          imageAsset: 'assets/images/bottom_store_icon.png',
          colors: ApplicationColors.statusYellow);
      labels = 'tab.toko';
    } else if (scopes == CommonConstants.doctor) {
      icon = IconImageTab(
          imageAsset: 'assets/images/bottom_emr_icon.png',
          colors: themeData.colorScheme.background);
      activeIcon = IconImageTab(
          imageAsset: 'assets/images/bottom_emr_icon.png',
          colors: ApplicationColors.statusYellow);
      labels = 'tab.jadwal';
    } else {
      icon = IconImageTab(
          imageAsset: 'assets/images/bottom_shop_icon.png',
          colors: themeData.colorScheme.background);
      activeIcon = IconImageTab(
          imageAsset: 'assets/images/bottom_shop_icon.png',
          colors: ApplicationColors.statusYellow);
      labels = 'tab.belanja';
    }
    return Padding(
      padding: const EdgeInsets.all(4),
      child: BottomNavigationBar(
        iconSize: 25,
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab.index,
        selectedItemColor: ApplicationColors.statusYellow,
        unselectedItemColor: themeData.colorScheme.background,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: IconImageTab(
                imageAsset: 'assets/images/bottom_home_icon.png',
                colors: themeData.colorScheme.background),
            activeIcon: IconImageTab(
                imageAsset: 'assets/images/bottom_home_icon.png',
                colors: ApplicationColors.statusYellow),
            label: allTranslations.text(
              "tab.beranda",
            ),
          ),
          BottomNavigationBarItem(
            icon: IconImageTab(
                imageAsset: 'assets/images/bottom_history_icon.png',
                colors: themeData.colorScheme.background),
            activeIcon: IconImageTab(
                imageAsset: 'assets/images/bottom_history_icon.png',
                colors: ApplicationColors.statusYellow),
            label: allTranslations.text(
              "tab.riwayat",
            ),
            // label: allTranslations.text("title", values: test),
          ),
          BottomNavigationBarItem(
            icon: icon,
            activeIcon: activeIcon,
            label: allTranslations.text(
              labels,
            ),
          ),
          BottomNavigationBarItem(
            icon: IconImageTab(
                imageAsset: 'assets/images/bottom_profile_icon.png',
                colors: themeData.colorScheme.background),
            activeIcon: IconImageTab(
                imageAsset: 'assets/images/bottom_profile_icon.png',
                colors: ApplicationColors.statusYellow),
            label: allTranslations.text(
              "tab.profile",
            ),
          ),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
    );
  }
}
