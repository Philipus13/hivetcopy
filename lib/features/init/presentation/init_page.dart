// first class that called after app.dart called
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/features/auth/session/session_bloc.dart';
import 'package:hivet/features/auth/session/session_state.dart';
import 'package:hivet/features/auth/sign_in/presentation/sigin_in_page.dart';
import 'package:hivet/features/init/presentation/tab_page.dart';
import 'package:hivet/features/splash/splash_screen.dart';

class InitPageClass extends StatelessWidget {
  const InitPageClass({Key? key}) : super(key: key);

  void goToHome(GlobalKey<NavigatorState> navigatorKey) {
    // navigatorKey.currentState.pushNamedAndRemoveUntil(
    //     CommonConstants.routeHome, (Route<dynamic> route) => false);
    // await navigatorKey.currentState.pushReplacementNamed('/home');
  }

  Widget loginPage() {
    return SignInPage();
  }

  Widget splashPage() {
    return SplashScreen();
  }

  Widget tabPage(String scopes) {
    return TabPage(
      scopes: scopes,
    );
  }

  @override
  Widget build(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.none) {
        Fluttertoast.showToast(
            // msg: allTranslations.text('no_internet_msg'),
            msg: "Tidak ada koneksi internet",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print('ini disconnected');
      } else {
        Fluttertoast.showToast(
            // msg: allTranslations.text('internet_connected_msg'),
            msg: "Internet terkoneksi",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });

    return BlocConsumer<SessionBloc, SessionState>(listener: (context, state) {
      // do stuff here based on BlocA's state
    }, builder: (context, state) {
      // return widget here based on BlocA's state
      if (state is SessionInitialState) {
        return splashPage();
      }
      if (state is SessionLoggedinUserState) {
        return tabPage(CommonConstants.pengguna);
        // return splashPage();
      }
      if (state is SessionLoggedInDoctorState) {
        return tabPage(CommonConstants.doctor);
      }
      if (state is SessionLoggedInStoreState) {
        return tabPage(CommonConstants.toko);
      }

      if (state is SessionNoToken) {
        return tabPage(CommonConstants.guest);
        // return splashPage();

        // return loginPage();
      }
      if (state is SessionLogout) {
        // return loginPage();
        return tabPage(CommonConstants.guest);
      }
      // return loginPage();
      return tabPage(CommonConstants.guest);
    });
  }
}
