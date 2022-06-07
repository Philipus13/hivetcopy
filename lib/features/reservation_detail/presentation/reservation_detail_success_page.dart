import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/style/size_config.dart';

import 'package:hivet/features/reservation_detail/presentation/bloc/reservation_detail_bloc.dart';

class ReservationDetailSuccessPage extends StatefulWidget {
  final String admissionId;

  ReservationDetailSuccessPage({
    required this.admissionId,
  });
  @override
  createState() => _ReservationDetailSuccessPageState();
}

class _ReservationDetailSuccessPageState
    extends State<ReservationDetailSuccessPage> {
  _ReservationDetailSuccessPageState();

  ReservationDetailBloc? reservationDetailBloc;

  //date things

  @override
  void initState() {
    reservationDetailBloc = BlocProvider.of<ReservationDetailBloc>(context);
    // reservationDetailBloc!.add(ReservationDetailInitEvent(widget.slotData));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    final RoutingService _routingService = g<RoutingService>();

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      // appBar: AppBar(
      //   backgroundColor: themeData.colorScheme.background,
      //   centerTitle: false,
      //   title: Text(allTranslations.text('profile.tnc'),
      //       style: themeData.textTheme.headline3
      //       // TextStyle(
      //       //   color: Color(0xff4B4B4B),
      //       //   fontWeight: FontWeight.bold,
      //       // ),
      //       ),
      //   elevation: 0.0,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.close,
      //       color: themeData.colorScheme.primary,
      //       size: 28,
      //     ),
      //     onPressed: () => Navigator.pop(context, false),
      //   ),
      // ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical! * 10,
                      left: 20,
                      right: 20,
                      bottom: 10),
                  child: Image.asset(
                    "assets/images/booking_success.png",
                    height: SizeConfig.blockSizeVertical! * 40,
                    width: SizeConfig.blockSizeHorizontal! * 100,
                  ),
                ),
                Text(
                  allTranslations.text('reservation.order_success'),
                  style: themeData.textTheme.headline3?.copyWith(
                    color: themeData.colorScheme.primary,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal! * 5,
                    right: SizeConfig.safeBlockHorizontal! * 5,
                  ),
                  child: Text(
                    allTranslations.text('reservation.order_success_sub'),
                    textAlign: TextAlign.center,
                    style: themeData.textTheme.headline5?.copyWith(
                        color: themeData.colorScheme.primary,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 2,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal! * 80,
            child: MaterialButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
              onPressed: () {
                _routingService.navigatePopUntil(
                  CommonConstants.routeReservation,
                );
              },
              color: themeData.colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  allTranslations.text('reservation.view_ticket').toUpperCase(),
                  style: TextStyle(
                    color: themeData.colorScheme.background,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.safeBlockHorizontal! * 4,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: SizeConfig.safeBlockVertical! * 1,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal! * 80,
            child: MaterialButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(
                  color: Color(0xff4B4B4B),
                  width: 1,
                ),
              ),
              onPressed: () {
                _routingService.navigatePopUntil(
                  CommonConstants.routeReservation,
                );
              },
              color: themeData.colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  allTranslations
                      .text('reservation.back_reservation')
                      .toUpperCase(),
                  style: TextStyle(
                    color: Color(0xff4B4B4B),
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.safeBlockHorizontal! * 4,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: SizeConfig.safeBlockVertical! * 2,
          ),
        ],
      ),
    );
  }
}
