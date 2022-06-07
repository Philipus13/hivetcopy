import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/config/helper.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/style/size_config.dart';
import 'package:hivet/core/widget/custom_button.dart';
import 'package:hivet/core/widget/normal_text_field.dart';
import 'package:hivet/features/reservation/model/slot_model.dart' as slotModel;
import 'package:hivet/core/model/master_model.dart' as masterModel;
import 'package:hivet/features/reservation_detail/model/list_schedule_time_model.dart';
import 'package:hivet/features/reservation_detail/presentation/bloc/reservation_detail_bloc.dart';

class ReservationDetailPage extends StatefulWidget {
  final slotModel.Data? slotData;

  ReservationDetailPage({this.slotData});
  @override
  createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  _ReservationDetailPageState();
  String? _selectedPet = "Kucing";
  String? fullName;
  String? specialization;
  ReservationDetailBloc? reservationDetailBloc;

  //date things
  String? dateScheduleStart;

  String? dateScheduleEnd;

  String? experience;
  String? description;
  String? consultFee;
  String? serviceFee;
  double? totalFee;
  double? a;
  double? b;
  int? duration;
  DateTime? startDate;
  DateTime? endDate;
  List<ListScheduleTimeModel> listScheduleTime = [];
  List<masterModel.Data>? masterListPet = [];
  TextEditingController complainController = TextEditingController();

  @override
  void initState() {
    fullName = widget.slotData?.fullName;
    specialization = widget.slotData?.specialization;
    experience = widget.slotData?.experience;
    description = widget.slotData?.descritpion;
    consultFee = widget.slotData?.fee;
    reservationDetailBloc = BlocProvider.of<ReservationDetailBloc>(context);
    reservationDetailBloc!.add(ReservationDetailInitEvent(widget.slotData));

    super.initState();
  }

  Widget consultSchedule(
      ThemeData themeData, List<ListScheduleTimeModel> listScheduleTimes) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: listScheduleTimes.length,
      itemBuilder: (BuildContext context, int index) => Container(
        // height: SizeConfig.blockSizeVertical! * 6,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color: themeData.colorScheme.primary,
              width: 1,
            ),
            color: themeData.colorScheme.primary),
        child: Center(
          child: Text(
            listScheduleTimes[index].time,
            style: themeData.textTheme.headline5
                ?.copyWith(color: themeData.colorScheme.background),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 2,
        crossAxisSpacing: SizeConfig.countHorizontalSize(8),
        mainAxisSpacing: SizeConfig.countHorizontalSize(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    final RoutingService _routingService = g<RoutingService>();

    // final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.primary,
          centerTitle: false,
          title: Text(
            allTranslations.text("reservation.title_detail"),
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
              reservationDetailBloc?.add(GoBackEvent());
            },
          ),
          elevation: 0.0,
        ),
        body: BlocConsumer<ReservationDetailBloc, ReservationDetailState>(
          listener: (context, states) {},
          builder: (context, states) {
            listScheduleTime = states.listScheduleTime ?? [];
            dateScheduleStart = states.dateScheduleStart ?? '';
            dateScheduleEnd = states.dateScheduleEnd ?? '';
            // _selectedPet = states.masterListPet != null
            //     ? states.masterListPet![0].modelName
            //     : '';
            serviceFee = states.masterListFee?[0].modelName ?? '0';
            a = double.parse(consultFee!);
            b = double.parse(serviceFee!);
            masterListPet = states.masterListPet;

            totalFee = a! + b!;

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
                                  width: SizeConfig.safeBlockHorizontal! * 20,
                                  child: Image.asset(
                                    "assets/images/doctordefault.png",
                                    height: SizeConfig.safeBlockVertical! * 10,
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
                                                allTranslations.text(
                                                    'profile.specialization'),
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
                                                specialization!,
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
                                                allTranslations
                                                    .text('profile.experience'),
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
                                                experience! +
                                                    ' ' +
                                                    allTranslations.text(
                                                        'reservation.year'),
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
                                                dateScheduleStart! +
                                                    " - " +
                                                    dateScheduleEnd!,
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
                            Text(
                              // 'drh. Christine merupakan drh sejak 2010 dan berpraktik di klinik hewan summarecon gading serpong, telah menangani ratusan hewan kecil.',
                              description!,
                              textAlign: TextAlign.start,
                              style: themeData.textTheme.headline6?.copyWith(
                                  color: themeData.colorScheme.primary,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2,
                    ),
                    Text(
                      allTranslations.text('reservation.consult_schedule'),
                      textAlign: TextAlign.start,
                      style: themeData.textTheme.headline4,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1,
                    ),
                    // To make list locis dynamic
                    listScheduleTime.length > 15
                        ? Container(
                            height: SizeConfig.blockSizeVertical! * 15,
                            child: consultSchedule(themeData, listScheduleTime))
                        : Container(
                            child:
                                consultSchedule(themeData, listScheduleTime)),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2,
                    ),
                    Text(
                      allTranslations.text('reservation.detail_fee'),
                      textAlign: TextAlign.start,
                      style: themeData.textTheme.headline4,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1,
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
                                          double.parse(serviceFee!)),
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
                      height: SizeConfig.blockSizeVertical! * 2,
                    ),
                    Text(
                      allTranslations.text('reservation.pet'),
                      textAlign: TextAlign.start,
                      style: themeData.textTheme.headline4,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1,
                    ),
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              labelStyle: themeData.textTheme.bodyText1
                                  ?.copyWith(
                                      color: themeData.colorScheme.primary),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 16.0),
                              hintText: allTranslations
                                  .text('reservation.hint_choose_pet'),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeData.colorScheme.primary,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(15.0))),
                          // isEmpty: _currentSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedPet,
                              isDense: true,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPet = value;
                                });
                              },
                              items: masterListPet?.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.modelName,
                                  child: Text(value.modelName!),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2,
                    ),
                    NormalTextField(
                      textEditingController: complainController,
                      title: allTranslations.text('reservation.complain'),
                      hint: allTranslations.text('reservation.hint_complain'),
                      textInputType: TextInputType.multiline,
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 4,
                    ),
                    CustomButton(
                        isLoading: false,
                        text: allTranslations.text('reservation.reservation'),
                        onPressed: () async {
                          dynamic send = {
                            'slotModelSend': widget.slotData,
                            'slotChoosen': "10.00",
                            'serviceFee': serviceFee,
                            'pet': _selectedPet,
                            'complaint': complainController.text,
                            'custName': "Test",
                            'phone': "081212919312",
                            'consultDate': "11-12-2022 10:00",
                            'orderDate': "10-12-2022 09:00",
                          };

                          await _routingService.navigateTo(
                              CommonConstants.routeReservationDetailSummary,
                              arguments: send);
                        }),
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
