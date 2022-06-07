import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// widget to show default loading page in apps
class LoadingSpinKit extends StatelessWidget {
  final Color color;
  final double ukuran;

  LoadingSpinKit({Key? key, required this.color, required this.ukuran})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(5),
        child: SpinKitWave(
          color: color,
          size: ukuran,
        ),
      ),
    );
  }
}
