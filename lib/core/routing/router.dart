import 'package:flutter/material.dart';

import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/features/address/presentation/add_address_page.dart';
import 'package:hivet/features/address/presentation/address_page.dart';
import 'package:hivet/features/album/presentation/album_page.dart';
import 'package:hivet/features/album/presentation/album_page_copy.dart';
import 'package:hivet/features/auth/register/presentation/register_page.dart';
import 'package:hivet/features/auth/sign_in/presentation/sigin_in_page.dart';
import 'package:hivet/features/forgot_pass/presentation/forgot_page.dart';
import 'package:hivet/features/init/presentation/init_page.dart';
import 'package:hivet/features/otp/presentation/otp_page.dart';
import 'package:hivet/features/profile/presentation/tnc_page.dart';
import 'package:hivet/features/profile/update_profile/update_profile_page.dart';
import 'package:hivet/features/profile/model/profile_model.dart'
    as profileModel;
import 'package:hivet/features/address/model/address_model.dart'
    as addressModel;
import 'package:hivet/features/reservation/presentation/reservation_page.dart';
import 'package:hivet/features/reservation/model/slot_model.dart' as slotModel;

import 'package:hivet/features/reservation_detail/presentation/reservation_detail_page.dart';
import 'package:hivet/features/reservation_detail/presentation/reservation_detail_agreement_page.dart';
import 'package:hivet/features/reservation_detail/presentation/reservation_detail_page_summary.dart';
import 'package:hivet/features/reservation_detail/presentation/reservation_detail_success_page.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings settings;

  SlideRightRoute({
    required this.widget,
    required this.settings,
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          settings: settings,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => InitPageClass());

    case CommonConstants.routeSignIn:
      return MaterialPageRoute(
          settings: settings, builder: (context) => SignInPage());
    case CommonConstants.routeRegister:
      return MaterialPageRoute(
          settings: settings, builder: (context) => RegisterPage());

    case CommonConstants.routeHome:
      // final dynamic args = settings.arguments;

      return MaterialPageRoute(
          settings: settings,
          builder: (context) => AlbumPage(
                mode: 0,
              ));

    case CommonConstants.routeComingSoon:
      final dynamic args = settings.arguments;
      print(args.toString() + "    " + args['value'].toString());

      return MaterialPageRoute(
          settings: settings, builder: (context) => AlbumPageCopy(mode: 0));

    case CommonConstants.routeUpdateProfil:
      final dynamic args = settings.arguments;
      profileModel.Data profileModelSend = args as profileModel.Data;
      // print(args.toString() + "    " + args['value'].toString());

      return MaterialPageRoute(
          settings: settings,
          builder: (context) => UpdateProfilePage(
                profileModel: profileModelSend,
              ));

    case CommonConstants.routeReservation:
      return SlideRightRoute(settings: settings, widget: ReservationPage());
    case CommonConstants.routeAdress:
      return SlideRightRoute(settings: settings, widget: AddressPage());
    case CommonConstants.routeForgot:
      return SlideRightRoute(settings: settings, widget: ForgotPage());

    case CommonConstants.routeAddAdress:
      addressModel.Data? addressModelSend;
      if (settings.arguments != null) {
        final dynamic args = settings.arguments;
        addressModelSend = args as addressModel.Data;
      }

      return SlideRightRoute(
          settings: settings,
          widget: AddAddressPage(
            addressModel: addressModelSend,
          ));

    case CommonConstants.routetnc:
      return SlideRightRoute(settings: settings, widget: TNCPage());
    case CommonConstants.routeOTP:
      final dynamic args = settings.arguments;

      return SlideRightRoute(
          settings: settings,
          widget: OtpPage(
            countryCode: args['countryCode'].toString(),
            phoneNum: args['phone'].toString(),
          ));
    case CommonConstants.routeReservationDetail:
      slotModel.Data? slotModelSend;

      if (settings.arguments != null) {
        final dynamic args = settings.arguments;
        slotModelSend = args['slotList'] as slotModel.Data;
      }

      return SlideRightRoute(
          settings: settings,
          widget: ReservationDetailPage(
            slotData: slotModelSend,
          ));
    case CommonConstants.routeReservationDetailSummary:
      slotModel.Data? slotModelSend;
      String? slotChoosen;
      String? serviceFee;
      String? pet;
      String? complaint;
      String? custName;
      String? phone;
      String? consultDate;
      String? orderDate;

      if (settings.arguments != null) {
        final dynamic args = settings.arguments;
        slotModelSend = args['slotModelSend'] as slotModel.Data;
        slotChoosen = args['slotChoosen'];
        serviceFee = args['serviceFee'];
        pet = args['pet'];
        complaint = args['complaint'];
        custName = args['custName'];
        phone = args['phone'];
        consultDate = args['consultDate'];
        orderDate = args['orderDate'];
      }

      return SlideRightRoute(
          settings: settings,
          widget: ReservationDetailSummaryPage(
            slotData: slotModelSend,
            slotChoosen: slotChoosen!,
            serviceFee: serviceFee!,
            pet: pet!,
            complaint: complaint!,
            custName: custName!,
            phone: phone!,
            consultDate: consultDate!,
            orderDate: orderDate!,
          ));
    case CommonConstants.routeReservationDetailAgreement:
      slotModel.Data? slotModelSend;
      String? slotChoosen;
      String? serviceFee;
      String? pet;
      String? complaint;
      String? custName;
      String? phone;
      String? consultDate;
      String? orderDate;

      if (settings.arguments != null) {
        final dynamic args = settings.arguments;
        slotModelSend = args['slotModelSend'] as slotModel.Data;
        slotChoosen = args['slotChoosen'];
        serviceFee = args['serviceFee'];
        pet = args['pet'];
        complaint = args['complaint'];
        custName = args['custName'];
        phone = args['phone'];
        consultDate = args['consultDate'];
        orderDate = args['orderDate'];
      }

      return SlideRightRoute(
          settings: settings,
          widget: ReservationDetailAgreementPage(
            slotData: slotModelSend,
            slotChoosen: slotChoosen!,
            serviceFee: serviceFee!,
            pet: pet!,
            complaint: complaint!,
            custName: custName!,
            phone: phone!,
            consultDate: consultDate!,
            orderDate: orderDate!,
          ));
    case CommonConstants.routeReservationSuccess:
      String? admissionId;

      if (settings.arguments != null) {
        final dynamic args = settings.arguments;
        admissionId = args['admissionId'];
      }

      return SlideRightRoute(
          settings: settings,
          widget: ReservationDetailSuccessPage(
            admissionId: admissionId!,
          ));

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
