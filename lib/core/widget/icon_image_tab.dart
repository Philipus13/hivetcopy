import 'package:flutter/material.dart';

class IconImageTab extends StatelessWidget {
  final String imageAsset;
  final Color? colors;
  final double? width;
  final double? height;
  const IconImageTab(
      {Key? key,
      required this.imageAsset,
      this.colors,
      this.width,
      this.height})
      : super(key: key);

  Widget iconImageTab(String imageAsset, Color? colors) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5, top: 5),
      child: new Image.asset(
        imageAsset,
        width: width ?? 22,
        height: height ?? 22,
        color: colors ?? Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return iconImageTab(imageAsset, colors);
  }
}
