import 'package:flutter/material.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/style/size_config.dart';

class CustomBottomSheet {
  static void showBottomSheet(
      {required BuildContext context,
      required Widget widget,
      int height = 30}) {
    ThemeData themeData = Theme.of(context);

    showModalBottomSheet(
        // useRootNavigator: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        context: context,
        builder: (context) {
          SizeConfig().init(context);

          return Padding(
            padding: EdgeInsets.only(
                // top: SizeConfig.blockSizeVertical! * 2,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              height: SizeConfig.blockSizeVertical! * height,
              child: Container(
                // padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical! * 2,
                          bottom: SizeConfig.blockSizeVertical! * 3),
                      child: Center(
                        child: Container(
                          color: themeData.colorScheme.background,
                          width: SizeConfig.blockSizeHorizontal! * 15,
                          height: 2,
                        ),
                      ),
                    ),
                    // SizedBox(height: SizeConfig.blockSizeHorizontal! * 1),
                    widget
                  ],
                ),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  border: Border.all(
                    color: Color.fromRGBO(226, 245, 252, 1),
                    width: 1,
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: CommonConstants.gradientColors),
                ),
              ),
            ),
          );
        });
  }

  static void showDialogAdminHelp({
    required BuildContext context,
  }) {
    ThemeData themeData = Theme.of(context);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/images/check_failed.png",
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allTranslations.text('title'),
                          style: TextStyle(
                            color: themeData.colorScheme.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            allTranslations.text('profile.help_center'),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/whatsapp.png",
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              allTranslations.text('profile.phone_admin'),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/emailicon.png",
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            allTranslations.text('profile.email_admin'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
