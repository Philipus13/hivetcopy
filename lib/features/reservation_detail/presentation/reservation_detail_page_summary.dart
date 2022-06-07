import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/config/helper.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/style/custom_colors.dart';
import 'package:hivet/core/style/size_config.dart';

import 'package:hivet/features/reservation/model/slot_model.dart' as slotModel;
import 'package:hivet/core/model/master_model.dart' as masterModel;
import 'package:hivet/features/reservation_detail/model/list_schedule_time_model.dart';
import 'package:hivet/features/reservation_detail/presentation/bloc/reservation_detail_bloc.dart';

class ReservationDetailSummaryPage extends StatefulWidget {
  final slotModel.Data? slotData;
  final String slotChoosen;
  final String serviceFee;
  final String pet;
  final String complaint;
  final String custName;
  final String phone;
  final String consultDate;
  final String orderDate;

  ReservationDetailSummaryPage(
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
  createState() => _ReservationDetailSummaryPageState();
}

class _ReservationDetailSummaryPageState
    extends State<ReservationDetailSummaryPage> {
  _ReservationDetailSummaryPageState();
  // String? _selectedPet = "";
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
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.primary,
          centerTitle: false,
          title: Text(
            allTranslations.text("reservation.title_summary_detail"),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              _routingService.goBack();
              // reservationDetailBloc?.add(GoBackEvent());
            },
          ),
          elevation: 0.0,
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            height: SizeConfig.blockSizeVertical! * 10,
            decoration: new BoxDecoration(
                border: Border.all(
                  color: themeData.colorScheme.primary,
                  width: 1,
                ),
                color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Total Bayar",
                          textAlign: TextAlign.center,
                          style: themeData.textTheme.headline6?.copyWith(
                              color: themeData.colorScheme.primary,
                              fontWeight: FontWeight.normal)),
                      Row(
                        children: [
                          Text(Helper.convertToRupiah(totalFee!),
                              textAlign: TextAlign.center,
                              style: themeData.textTheme.headline3?.copyWith(
                                  color: ApplicationColors.statusGreen,
                                  fontWeight: FontWeight.bold)),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                            color: themeData.colorScheme.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    primary: themeData.colorScheme.primary,
                    // onPrimary: Colors.white,
                    // onSurface: Colors.grey,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: SizeConfig.safeBlockHorizontal! * 35,
                    height: 50,
                    child: Text(
                      'Lanjutkan',
                      textAlign: TextAlign.center,
                      style: themeData.textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    dynamic send = {
                      'slotModelSend': widget.slotData,
                      'slotChoosen': "10.00",
                      'serviceFee': widget.serviceFee,
                      'pet': widget.pet,
                      'complaint': widget.complaint,
                      'custName': "Test",
                      'phone': "081212919312",
                      'consultDate': "11-12-2022 10:00",
                      'orderDate': "10-12-2022 09:00",
                    };

                    await _routingService.navigateTo(
                        CommonConstants.routeReservationDetailAgreement,
                        arguments: send);
                  },
                ),
              ],
            )),
        body: BlocConsumer<ReservationDetailBloc, ReservationDetailState>(
          listener: (context, states) {},
          builder: (context, states) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        // height: SizeConfig.blockSizeVertical! * 20,
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: themeData.colorScheme.primary,
                              width: 1,
                            ),
                            color: Colors.white),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allTranslations.text('reservation.consult_to') +
                                  " " +
                                  allTranslations.text('reservation.dr_title') +
                                  " " +
                                  fullName!,
                              textAlign: TextAlign.center,
                              style: themeData.textTheme.headline3,
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical! * 1,
                            ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      border: Border.all(
                                        color: Color.fromRGBO(226, 245, 252, 1),
                                        width: 1,
                                      ),
                                      color: themeData.colorScheme.primary),
                                  width: SizeConfig.safeBlockHorizontal! * 16,
                                  child: Image.asset(
                                    "assets/images/doctordefault.png",
                                    height: SizeConfig.safeBlockVertical! * 9,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 5,
                                      left: 5,
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      height:
                                          SizeConfig.safeBlockVertical! * 10,
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                allTranslations
                                                    .text('reservation.pet'),
                                                textAlign: TextAlign.center,
                                                style: themeData
                                                    .textTheme.headline6
                                                    ?.copyWith(
                                                        color: themeData
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                              Text(
                                                widget.pet,
                                                textAlign: TextAlign.center,
                                                style: themeData
                                                    .textTheme.headline5
                                                    ?.copyWith(
                                                        color: themeData
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                allTranslations.text(
                                                    'reservation.consult_date_summary'),
                                                textAlign: TextAlign.center,
                                                style: themeData
                                                    .textTheme.headline6
                                                    ?.copyWith(
                                                        color: themeData
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                              Text(
                                                widget.consultDate,
                                                textAlign: TextAlign.center,
                                                style: themeData
                                                    .textTheme.headline5
                                                    ?.copyWith(
                                                        color: themeData
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                allTranslations.text(
                                                    'reservation.order_date_summary'),
                                                textAlign: TextAlign.center,
                                                style: themeData
                                                    .textTheme.headline6
                                                    ?.copyWith(
                                                        color: themeData
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                              Text(
                                                widget.orderDate,
                                                textAlign: TextAlign.center,
                                                style: themeData
                                                    .textTheme.headline5
                                                    ?.copyWith(
                                                        color: themeData
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical! * 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Keluhan: ",
                                        textAlign: TextAlign.start,
                                        style: themeData.textTheme.headline6
                                            ?.copyWith(
                                                color: themeData
                                                    .colorScheme.primary,
                                                fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.blockSizeVertical! * 0.5,
                                      ),
                                      Text(
                                        widget.complaint,
                                        textAlign: TextAlign.start,
                                        style: themeData.textTheme.headline6
                                            ?.copyWith(
                                                color: themeData
                                                    .colorScheme.primary,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Batal Otomatis: ",
                                        textAlign: TextAlign.start,
                                        style: themeData.textTheme.headline6
                                            ?.copyWith(
                                                color: themeData
                                                    .colorScheme.primary,
                                                fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.blockSizeVertical! * 1,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            border: Border.all(
                                              color:
                                                  themeData.colorScheme.primary,
                                              width: 1,
                                            ),
                                            color:
                                                themeData.colorScheme.primary),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.schedule_rounded,
                                                // size: 20,
                                                color: Colors.white),
                                            Text(
                                              "2 Jam",
                                              textAlign: TextAlign.start,
                                              style: themeData
                                                  .textTheme.headline6
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2,
                    ),
                    Text(
                      allTranslations.text('reservation.patient'),
                      textAlign: TextAlign.start,
                      style: themeData.textTheme.headline4,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2,
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: themeData.colorScheme.primary,
                              width: 1,
                            ),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 5,
                            left: 5,
                          ),
                          child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            height: SizeConfig.safeBlockVertical! * 8,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      allTranslations
                                          .text('reservation.patient_name'),
                                      textAlign: TextAlign.center,
                                      style: themeData.textTheme.headline6
                                          ?.copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.custName,
                                      textAlign: TextAlign.center,
                                      style: themeData.textTheme.headline5
                                          ?.copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      allTranslations
                                          .text('reservation.phone_number'),
                                      textAlign: TextAlign.center,
                                      style: themeData.textTheme.headline6
                                          ?.copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.phone,
                                      textAlign: TextAlign.center,
                                      style: themeData.textTheme.headline5
                                          ?.copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2,
                    ),
                    Text(
                      allTranslations.text('reservation.detail_fee'),
                      textAlign: TextAlign.start,
                      style: themeData.textTheme.headline4,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2,
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        // height: SizeConfig.blockSizeVertical! * 20,
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: themeData.colorScheme.primary,
                              width: 1,
                            ),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 5,
                            left: 5,
                          ),
                          child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            height: SizeConfig.safeBlockVertical! * 10,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      allTranslations
                                          .text('reservation.consult_fee'),
                                      textAlign: TextAlign.center,
                                      style: themeData.textTheme.headline6
                                          ?.copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      Helper.convertToRupiah(
                                          double.parse(consultFee!)),
                                      textAlign: TextAlign.center,
                                      style: themeData.textTheme.headline5
                                          ?.copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      allTranslations
                                          .text('reservation.service_fee'),
                                      textAlign: TextAlign.center,
                                      style: themeData.textTheme.headline6
                                          ?.copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      Helper.convertToRupiah(
                                          double.parse(widget.serviceFee)),
                                      textAlign: TextAlign.center,
                                      style: themeData.textTheme.headline5
                                          ?.copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      allTranslations
                                          .text('reservation.total_fee'),
                                      textAlign: TextAlign.center,
                                      style: themeData.textTheme.headline6
                                          ?.copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      Helper.convertToRupiah(totalFee!),
                                      textAlign: TextAlign.center,
                                      style: themeData.textTheme.headline5
                                          ?.copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 4,
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: themeData.colorScheme.primary,
                              width: 1,
                            ),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 5,
                            left: 5,
                          ),
                          child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  allTranslations.text(
                                      'reservation.bottom_message_summary_detail'),
                                  textAlign: TextAlign.center,
                                  style: themeData.textTheme.headline6
                                      ?.copyWith(
                                          color: themeData.colorScheme.primary,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 4,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
