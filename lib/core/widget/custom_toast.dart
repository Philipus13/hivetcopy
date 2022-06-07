import 'package:flutter/material.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/style/custom_colors.dart';
import 'package:hivet/core/style/size_config.dart';

enum StatusToast {
  success,
  fail,
  warning,
  info,
}
IconData? icons;

class CustomToast {
  static void showToast(
      {required String msg,
      required BuildContext context,
      StatusToast statusToast = StatusToast.success,
      bool isAutoClosed = false,
      int? second = 1}) async {
    Color textColor = Colors.white;
    Color? backgroundColor;
    String? title;

    switch (statusToast) {
      case StatusToast.success:
        backgroundColor = ApplicationColors.statusGreen;
        title = allTranslations.text('success');
        icons = Icons.check;
        break;
      case StatusToast.fail:
        backgroundColor = ApplicationColors.statusRed;
        title = allTranslations.text('failed');
        icons = Icons.close;

        break;
      case StatusToast.warning:
        backgroundColor = ApplicationColors.statusYellow;
        title = allTranslations.text('warning');
        icons = Icons.warning;

        break;
      default:
    }
    CustomToast._createView(msg, context, backgroundColor, textColor, title);

    if (isAutoClosed) {
      await Future.delayed(Duration(seconds: second!), () {
        dismiss();
      });
    }
  }

  static OverlayEntry? _overlayEntry;
  static bool isVisible = false;

  static void _createView(String msg, BuildContext context, Color? background,
      Color textColor, String? title) async {
    var overlayState = Overlay.of(context);
    SizeConfig().init(context);

    // final themeData = Theme.of(context);

    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => _ToastAnimatedWidget(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(8),
              ),
              // margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          icons,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title!,
                              // softWrap: true,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal! * 75,
                              child: Text(
                                msg,
                                // softWrap: true,
                                // maxLines: 5,

                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: dismiss,
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    isVisible = true;
    overlayState?.insert(_overlayEntry!);
  }

  static dismiss() async {
    if (!isVisible) {
      return;
    }
    isVisible = false;
    _overlayEntry?.remove();
  }
}

class _ToastAnimatedWidget extends StatefulWidget {
  _ToastAnimatedWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastAnimatedWidget>
    with SingleTickerProviderStateMixin {
  bool get _isVisible => true; //update this value later

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        // bottom: 50,
        top: 20,
        left: 0,
        child: AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: _isVisible ? 1.0 : 0.0,
          child: widget.child,
        ));
  }
}
