import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hivet/app.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivet/core/style/theme.dart';
import 'package:hivet/features/address/presentation/bloc/address_bloc.dart';
import 'package:hivet/features/album/presentation/bloc/album_bloc.dart';
import 'package:hivet/features/auth/register/presentation/bloc/register_bloc.dart';
import 'package:hivet/features/auth/session/session_bloc.dart';
import 'package:hivet/features/auth/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:hivet/features/doctor_slot/presentation/bloc/doctor_slot_bloc.dart';
import 'package:hivet/features/forgot_pass/presentation/bloc/forgot_bloc.dart';
import 'package:hivet/features/home/presentation/bloc/home_bloc.dart';
import 'package:hivet/features/language/language_bloc.dart';
import 'package:hivet/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:hivet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:hivet/features/profile/update_profile/bloc/update_profile_bloc.dart';
import 'package:hivet/features/reservation/presentation/bloc/reservation_bloc.dart';
import 'package:hivet/features/reservation_detail/presentation/bloc/reservation_detail_bloc.dart';
import 'package:hivet/features/theme/theme_bloc.dart';
import 'package:hivet/features/theme/theme_event.dart';
import 'package:hivet/features/theme/theme_state.dart';

import 'core/bloc_delegate/simple_bloc_delegate.dart';
import 'features/album/model/hive/album_model.dart';
import 'features/auth/session/session_event.dart';

//This is for override ssl because issue on flutter http client
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) {
        final isValidHost = host == "hivet.id";
        return isValidHost;
      });
  }
}

Future<void> main(env) async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = new MyHttpOverrides();

  setupLocator(env.toString());

  Hive
    ..initFlutter()
    ..registerAdapter(AlbumHiveModelAdapter());

  BlocOverrides.runZoned(
    () => runApp(MainApplication()),
    blocObserver: SimpleBlocDelegate(),
  );
  Firebase.initializeApp();
  allTranslations.init();
  // runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>(
      create: (contexts) => LanguageBloc()..add(LanguageEvent.id),
      child: BlocBuilder<LanguageBloc, String>(builder: (context, language) {
        return BlocProvider<ThemesBloc>(
          create: (contexts) => ThemesBloc()..add(ThemeChanged(AppTheme.Light)),
          child: BlocBuilder<ThemesBloc, ThemeState>(builder: (context, state) {
            ThemeData? themeData;
            // ThemeData? themeData = appThemeData[AppTheme.Dark];
            if (state is ThemeLoaded) {
              themeData = state.themeData;
            }
            return MultiBlocProvider(
                providers: [
                  BlocProvider<AlbumBloc>(create: (context) => AlbumBloc()),
                  BlocProvider<SignInBloc>(create: (context) => SignInBloc()),
                  BlocProvider<RegisterBloc>(
                      create: (context) => RegisterBloc()),
                  BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
                  BlocProvider<UpdateProfileBloc>(
                      create: (context) => UpdateProfileBloc()),
                  BlocProvider<OtpBloc>(create: (context) => OtpBloc()),
                  BlocProvider<ForgotBloc>(create: (context) => ForgotBloc()),
                  BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
                  BlocProvider<SessionBloc>(
                      create: (context) =>
                          SessionBloc()..add(SessionInitEvent())),
                  BlocProvider<AddressBloc>(create: (context) => AddressBloc()),
                  BlocProvider<ReservationDetailBloc>(
                      create: (context) => ReservationDetailBloc()),
                  BlocProvider<ReservationBloc>(
                      create: (context) => ReservationBloc()),
                  BlocProvider<DoctorSlotWBloc>(
                      create: (context) => DoctorSlotWBloc()),
                ],
                child: App(
                  language: language,
                  themeData: themeData,
                ));
          }),
        );
      }),
    );
  }
}
