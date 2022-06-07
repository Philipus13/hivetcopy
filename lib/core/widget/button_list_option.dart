import 'package:flutter/material.dart';

// widget to show profile card selection in the bottom
class ButtonListOption extends StatelessWidget {
  final String title;
  final String leftIcon;
  final VoidCallback? onPressed;

  const ButtonListOption(
      {Key? key, required this.title, required this.leftIcon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 5),
      child: GestureDetector(
        onTap: onPressed != null ? onPressed : null,
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
          decoration: new BoxDecoration(
            color: themeData.colorScheme.primary,
            border: new Border.all(
                color: themeData.colorScheme.primary,
                width: 0.0,
                style: BorderStyle.solid),
            borderRadius: new BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.asset(
                  leftIcon,
                  height: 25,
                  width: 25,
                  color: Colors.yellow,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16)),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.navigate_next,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
