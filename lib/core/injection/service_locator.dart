import 'package:get_it/get_it.dart';
import 'package:hivet/core/config/flavor.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/features/address/service/address_service.dart';
import 'package:hivet/features/album/service/album_service.dart';
import 'package:hivet/features/auth/register/service/register_service.dart';
import 'package:hivet/features/auth/session/service/session_service.dart';
import 'package:hivet/features/auth/sign_in/service/sign_in_service.dart';
import 'package:hivet/features/doctor_slot/service/doctor_slot_service.dart';
import 'package:hivet/features/forgot_pass/service/forgot_service.dart';
import 'package:hivet/features/home/service/home_service.dart';
import 'package:hivet/features/otp/service/otp_service.dart';
import 'package:hivet/features/profile/service/profile_service.dart';
import 'package:hivet/features/reservation/service/reservation_service.dart';

GetIt g = GetIt.instance;

void setupLocator(String env) async {
  g.registerLazySingleton(() => AlbumService());
  g.registerLazySingleton(() => SignInService());
  g.registerLazySingleton(() => RegisterService());
  g.registerLazySingleton(() => FlavorConfigs(env: env));
  g.registerLazySingleton(() => RoutingService());
  g.registerLazySingleton(() => SessionService());
  g.registerLazySingleton(() => ProfileService());
  g.registerLazySingleton(() => AddressService());
  g.registerLazySingleton(() => OTPService());
  g.registerLazySingleton(() => ForgotService());
  g.registerLazySingleton(() => HomeService());
  g.registerLazySingleton(() => ReservationService());
  g.registerLazySingleton(() => DoctorSlotService());
}
