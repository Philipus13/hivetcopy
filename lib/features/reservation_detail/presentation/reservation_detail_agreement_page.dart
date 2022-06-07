import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
// import 'package:hivet/core/config/helper.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
// import 'package:hivet/core/style/custom_colors.dart';
import 'package:hivet/core/style/size_config.dart';
// import 'package:hivet/core/widget/custom_button.dart';
// import 'package:hivet/core/widget/loading_spin_kit_widget.dart';
// import 'package:hivet/core/widget/normal_text_field.dart';
import 'package:hivet/features/reservation/model/slot_model.dart' as slotModel;
import 'package:hivet/core/model/master_model.dart' as masterModel;
import 'package:hivet/features/reservation_detail/model/list_schedule_time_model.dart';
import 'package:hivet/features/reservation_detail/presentation/bloc/reservation_detail_bloc.dart';

class ReservationDetailAgreementPage extends StatefulWidget {
  final slotModel.Data? slotData;
  final String slotChoosen;
  final String serviceFee;
  final String pet;
  final String complaint;
  final String custName;
  final String phone;
  final String consultDate;
  final String orderDate;

  ReservationDetailAgreementPage(
      {this.slotData,
      required this.slotChoosen,
      required this.serviceFee,
      required this.pet,
      required this.complaint,
      required this.custName,
      required this.phone,
      required this.consultDate,
      required this.orderDate});
  @override
  createState() => _ReservationDetailAgreementPageState();
}

class _ReservationDetailAgreementPageState
    extends State<ReservationDetailAgreementPage> {
  _ReservationDetailAgreementPageState();
  String? fullName;
  String? specialization;
  ReservationDetailBloc? reservationDetailBloc;

  //date things
  String? dateScheduleStart;

  String? dateScheduleEnd;

  String? experience;
  String? description;
  String? consultFee;
  double? totalFee;
  double? a;
  double? b;
  int? duration;
  DateTime? startDate;
  DateTime? endDate;
  List<ListScheduleTimeModel> listScheduleTime = [];
  List<masterModel.Data>? masterListPet = [];

  @override
  void initState() {
    fullName = widget.slotData?.fullName;
    specialization = widget.slotData?.specialization;
    experience = widget.slotData?.experience;
    description = widget.slotData?.descritpion;
    consultFee = widget.slotData?.fee;

    a = double.parse(consultFee!);
    b = double.parse(widget.serviceFee);
    totalFee = a! + b!;

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
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        centerTitle: false,
        title: Text(allTranslations.text('profile.tnc'),
            style: themeData.textTheme.headline3
            // TextStyle(
            //   color: Color(0xff4B4B4B),
            //   fontWeight: FontWeight.bold,
            // ),
            ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: themeData.colorScheme.primary,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              // child: WebView(
              //   initialUrl: widget.url,
              //   javascriptMode: JavascriptMode.unrestricted,
              //   onWebViewCreated: (WebViewController webViewController) {
              //     _controller.complete(webViewController);
              //   },

              //   javascriptChannels: <JavascriptChannel>[
              //     _toasterJavascriptChannel(context),
              //   ].toSet(),
              //   navigationDelegate: (NavigationRequest request) {
              //     if (request.url.startsWith('https://www.youtube.com/')) {
              //       return NavigationDecision.prevent;
              //     }
              //     return NavigationDecision.navigate;
              //   },
              //   onPageFinished: (String url) {
              //     setState(() {
              //       loadingPage = false;
              //     });
              //   },
              // ),
            ),
          ),
          Container(
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
                // Navigator.pop(context, true);
                // _routingService.navigatePopUntil(
                //     CommonConstants.routeReservation,
                //     arguments: true);
                dynamic send = {
                  'admissionId': 'tes',
                };
                _routingService.navigateTo(
                    CommonConstants.routeReservationSuccess,
                    arguments: send);
              },
              color: themeData.colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  allTranslations.text('reservation.agree').toUpperCase(),
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
                Navigator.pop(context, false);
              },
              color: themeData.colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  allTranslations.text('reservation.cancel').toUpperCase(),
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
