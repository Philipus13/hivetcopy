import 'package:flutter/material.dart';

import 'loading_spin_kit_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.isLoading,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.textColor,
      this.size})
      : super(key: key);
  final bool isLoading;
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        primary: backgroundColor ?? themeData.colorScheme.primary,
        // onPrimary: Colors.white,
        // onSurface: Colors.grey,
      ),
      child: isLoading
          ? Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: size ?? 50,
              child: LoadingSpinKit(
                color: themeData.backgroundColor,
                ukuran: 20,
              ),
            )
          : Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: size ?? 50,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: themeData.textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor ?? Colors.white),
              ),
            ),
      onPressed: onPressed,
    );
  }
}
