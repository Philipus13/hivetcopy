import 'package:flutter/material.dart';
import 'package:hivet/core/widget/loading_spin_kit_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo_background_white.png',
            height: 235,
            width: 400,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: LoadingSpinKit(color: Colors.white, ukuran: 35),
          )
        ],
      )),
    );
  }
}
