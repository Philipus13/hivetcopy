import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/style/size_config.dart';
import 'package:hivet/core/widget/custom_bottom_sheet.dart';
import 'package:hivet/core/widget/custom_button.dart';
import 'package:hivet/core/widget/custom_toast.dart';
import 'package:hivet/features/doctor_slot/presentation/bloc/doctor_slot_bloc.dart';
import 'package:hivet/features/reservation_detail/model/list_schedule_time_model.dart';

import 'package:hivet/features/doctor_slot/model/doctor_slot_model.dart'
    as doctorSlotModel;

class DoctorSlotWPage extends StatefulWidget {
  DoctorSlotWPage();
  @override
  createState() => _DoctorSlotWPageState();
}

class _DoctorSlotWPageState extends State<DoctorSlotWPage> {
  _DoctorSlotWPageState();
  String? fullName;
  String? specialization;
  DoctorSlotWBloc? doctorSlotWBloc;
  String dropdownValue = 'Sen';
  String dropdownValue1 = '09.00';
  String dropdownValue2 = '10.00';
  String addDay = 'senin';
  String startDay = '';
  String endDay = '';
  List<doctorSlotModel.Slot> doctorSlotList = [];

  String? duration = "0";

  @override
  void initState() {
    doctorSlotWBloc = BlocProvider.of<DoctorSlotWBloc>(context);
    doctorSlotWBloc!.add(DoctorSlotWInitEvent());

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

  void _addBottomSheet(ThemeData themeData) {
    CustomBottomSheet.showBottomSheet(
        height: 55,
        context: context,
        widget: BlocConsumer<DoctorSlotWBloc, DoctorSlotWState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      allTranslations.text('slot_doctor.add_slot'),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: themeData.textTheme.headline3?.copyWith(
                          color: themeData.colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allTranslations.text('slot_doctor.day'),
                        overflow: TextOverflow.ellipsis,
                        style: themeData.textTheme.headline5?.copyWith(
                            color: themeData.colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 1,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: themeData.colorScheme.primary,
                              width: 0,
                            ),
                            color: Colors.white),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: state.addDay ?? 'senin',
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                              color: themeData.colorScheme.primary,
                            ),
                            elevation: 12,
                            style:
                                TextStyle(color: themeData.colorScheme.primary),
                            onChanged: (String? newValue) {
                              doctorSlotWBloc
                                  ?.add(AddDayEvent(addDay: newValue));
                            },
                            items: <String>[
                              'senin',
                              'selasa',
                              'rabu',
                              'kamis',
                              'jumat',
                              'sabtu',
                              'minggu',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allTranslations.text('slot_doctor.start'),
                        overflow: TextOverflow.ellipsis,
                        style: themeData.textTheme.headline5?.copyWith(
                            color: themeData.colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 1,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (state.addDay != null) {
                            final TimeOfDay? result = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (result != null) {
                              doctorSlotWBloc?.add(AddStartEvent(
                                  addStart: result.format(context)));
                            }
                          } else {
                            CustomToast.showToast(
                                msg: allTranslations
                                    .text('slot_doctor.alert_choose_day'),
                                statusToast: StatusToast.fail,
                                context: context,
                                isAutoClosed: true);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 12, right: 12),
                          width: double.infinity,
                          decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: themeData.colorScheme.primary,
                                width: 0,
                              ),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.addStart ?? '-',
                                textAlign: TextAlign.start,
                                style: themeData.textTheme.headline5?.copyWith(
                                    color: themeData.colorScheme.primary,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 15,
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                color: themeData.colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allTranslations.text('slot_doctor.end'),
                        overflow: TextOverflow.ellipsis,
                        style: themeData.textTheme.headline5?.copyWith(
                            color: themeData.colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 1,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (state.addStart != null) {
                            final TimeOfDay? result = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (result != null) {
                              String time = result.format(context);
                              String addStart = state.addStart!;

                              String fulldateStart =
                                  '2019-11-20 ' + addStart + ':00';
                              DateTime? startDate =
                                  DateTime.parse(fulldateStart);

                              String fulldateEnd = '2019-11-20 ' + time + ':00';
                              DateTime? endDate = DateTime.parse(fulldateEnd);

                              if (endDate.isBefore(startDate)) {
                                CustomToast.showToast(
                                    msg: allTranslations
                                        .text('slot_doctor.alert_choose_hour'),
                                    statusToast: StatusToast.fail,
                                    context: context,
                                    isAutoClosed: true);
                              } else {
                                doctorSlotWBloc?.add(AddEndEvent(addEnd: time));
                              }
                            }
                          } else {
                            CustomToast.showToast(
                                msg: allTranslations
                                    .text('slot_doctor.alert_choose_start'),
                                statusToast: StatusToast.fail,
                                context: context,
                                isAutoClosed: true);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 12, right: 12),
                          width: double.infinity,
                          decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: themeData.colorScheme.primary,
                                width: 0,
                              ),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.addEnd ?? '-',
                                textAlign: TextAlign.start,
                                style: themeData.textTheme.headline5?.copyWith(
                                    color: themeData.colorScheme.primary,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 15,
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                color: themeData.colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 3,
                  ),
                  CustomButton(
                      size: 45,
                      isLoading: false,
                      text: allTranslations.text('slot_doctor.add'),
                      onPressed: state.addEnd == null
                          ? null
                          : () {
                              doctorSlotWBloc?.add(AddSlotEvent(
                                  day: state.addDay ?? "senin",
                                  start: state.addStart ?? "00.00",
                                  end: state.addEnd ?? "00.00",
                                  duration:
                                      state.profileData?.doctor?.duration));
                              Navigator.pop(context);
                            }),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2,
                  ),
                ],
              ),
            );
          },
        ));
  }

  void _deleteBottomSheet(ThemeData themeData, int index) {
    CustomBottomSheet.showBottomSheet(
        height: 20,
        context: context,
        widget: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  allTranslations.text('slot_doctor.delete_slot'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.headline3?.copyWith(
                      color: themeData.colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton(
                        backgroundColor: themeData.colorScheme.background,
                        textColor: themeData.colorScheme.primary,
                        size: 40,
                        isLoading: false,
                        text: allTranslations.text('address.cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton(
                        size: 40,
                        isLoading: false,
                        text: allTranslations.text('address.delete'),
                        onPressed: () {
                          doctorSlotWBloc!.add(DeleteSlotEvent(index: index));
                          Navigator.pop(context);
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.primary,
          centerTitle: false,
          title: Text(
            allTranslations.text("slot_doctor.title"),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: (() {
                _addBottomSheet(themeData);
              }),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
                  child: Image.asset(
                    "assets/images/icon_add.png",
                    height: SizeConfig.safeBlockVertical! * 4,
                    width: SizeConfig.safeBlockHorizontal! * 8,
                  ),
                ),
              ),
            ),
          ],
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.white),
          //   onPressed: () {
          //     _routingService.goBack();
          //     doctorSlotWBloc?.add(GoBackEvent());
          //   },
          // ),
          elevation: 0.0,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
              isLoading: false,
              text: allTranslations.text('profile.save'),
              onPressed: () {
                doctorSlotWBloc?.add(SubmitSlotEvent());
              }),
        ),
        body: BlocConsumer<DoctorSlotWBloc, DoctorSlotWState>(
          listener: (context, states) {
            if (states.isSuccess && states.from == From.submit) {
              CustomToast.showToast(
                  msg: allTranslations.text("slot_doctor.add_slot_success_msg"),
                  statusToast: StatusToast.success,
                  context: context,
                  isAutoClosed: true);
            }
            if (states.isError && states.from == From.addSlot) {
              CustomToast.showToast(
                  second: 3,
                  msg: states.message!,
                  statusToast: StatusToast.fail,
                  context: context,
                  isAutoClosed: true);
            }
          },
          builder: (context, states) {
            doctorSlotList = states.doctorSlotList ?? [];
            duration = states.profileData?.doctor?.duration;

            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        allTranslations.text('slot_doctor.subtitle'),
                        textAlign: TextAlign.start,
                        style: themeData.textTheme.headline4?.copyWith(
                            color: themeData.colorScheme.primary,
                            fontWeight: FontWeight.normal),
                      ),
                      CupertinoSwitch(
                        // activeColor: themeData.colorScheme.primary,
                        value: states.isActivated,
                        onChanged: (bool value) {
                          doctorSlotWBloc!
                              .add(ActivatingEvent(isActive: value));
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 5);
                      },
                      padding: EdgeInsets.zero,
                      itemCount: doctorSlotList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 12, right: 12),
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: themeData.colorScheme.primary,
                                        width: 1,
                                      ),
                                      color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // DropdownButtonHideUnderline(
                                      //   child: DropdownButton<String>(
                                      //     value: doctorSlotList[index].hari!,
                                      //     icon: Icon(
                                      //       Icons.arrow_drop_down_sharp,
                                      //       color:
                                      //           themeData.colorScheme.primary,
                                      //     ),
                                      //     elevation: 16,
                                      //     style: TextStyle(
                                      //         color: themeData
                                      //             .colorScheme.primary),
                                      //     underline: Container(
                                      //       height: 2,
                                      //       color:
                                      //           themeData.colorScheme.primary,
                                      //     ),
                                      //     onChanged: (String? newValue) {
                                      //       setState(() {
                                      //         dropdownValue = newValue!;
                                      //       });
                                      //     },
                                      //     items: <String>[
                                      //       'senin',
                                      //       'selasa',
                                      //       'rabu',
                                      //       'kamis',
                                      //       'jumat',
                                      //       'sabtu',
                                      //       'minggu',
                                      //     ].map<DropdownMenuItem<String>>(
                                      //         (String value) {
                                      //       return DropdownMenuItem<String>(
                                      //         value: value,
                                      //         child: Text(value),
                                      //       );
                                      //     }).toList(),
                                      //   ),
                                      // ),
                                      // GestureDetector(
                                      //     onTap: () async {
                                      //       final TimeOfDay? result =
                                      //           await showTimePicker(
                                      //               context: context,
                                      //               initialTime:
                                      //                   TimeOfDay.now());
                                      //       if (result != null) {
                                      //         setState(() {
                                      //           dropdownValue2 =
                                      //               result.format(context);
                                      //         });
                                      //       }
                                      //     },
                                      //     child: Row(
                                      //       children: [
                                      //         Text(
                                      //           doctorSlotList[index].start!,
                                      //           textAlign: TextAlign.start,
                                      //           style: themeData
                                      //               .textTheme.headline5
                                      //               ?.copyWith(
                                      //                   color: themeData
                                      //                       .colorScheme
                                      //                       .primary,
                                      //                   fontWeight:
                                      //                       FontWeight.normal),
                                      //         ),
                                      //         Icon(
                                      //           Icons.arrow_drop_down_sharp,
                                      //           color: themeData
                                      //               .colorScheme.primary,
                                      //         ),
                                      //       ],
                                      //     )),
                                      // GestureDetector(
                                      //     onTap: () async {
                                      //       final TimeOfDay? result =
                                      //           await showTimePicker(
                                      //               context: context,
                                      //               initialTime:
                                      //                   TimeOfDay.now());
                                      //       if (result != null) {
                                      //         setState(() {
                                      //           dropdownValue2 =
                                      //               result.format(context);
                                      //         });
                                      //       }
                                      //     },
                                      //     child: Row(
                                      //       children: [
                                      //         Text(
                                      //           doctorSlotList[index].end!,
                                      //           textAlign: TextAlign.start,
                                      //           style: themeData
                                      //               .textTheme.headline5
                                      //               ?.copyWith(
                                      //                   color: themeData
                                      //                       .colorScheme
                                      //                       .primary,
                                      //                   fontWeight:
                                      //                       FontWeight.normal),
                                      //         ),
                                      //         Icon(
                                      //           Icons.arrow_drop_down_sharp,
                                      //           color: themeData
                                      //               .colorScheme.primary,
                                      //         ),
                                      //       ],
                                      //     )),
                                      Text(
                                        doctorSlotList[index].hari!,
                                        textAlign: TextAlign.start,
                                        style: themeData.textTheme.headline5
                                            ?.copyWith(
                                                color: themeData
                                                    .colorScheme.primary,
                                                fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        doctorSlotList[index].start!,
                                        textAlign: TextAlign.start,
                                        style: themeData.textTheme.headline5
                                            ?.copyWith(
                                                color: themeData
                                                    .colorScheme.primary,
                                                fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        doctorSlotList[index].end!,
                                        textAlign: TextAlign.start,
                                        style: themeData.textTheme.headline5
                                            ?.copyWith(
                                                color: themeData
                                                    .colorScheme.primary,
                                                fontWeight: FontWeight.normal),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _deleteBottomSheet(themeData, index);
                                          // doctorSlotWBloc!.add(
                                          //     DeleteSlotEvent(index: index));
                                        },
                                        child: Image.asset(
                                          "assets/images/icon_trash.png",
                                          height:
                                              SizeConfig.safeBlockVertical! * 4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical! * 1,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 15, bottom: 15, left: 12, right: 12),
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: themeData.colorScheme.primary,
                                        width: 1,
                                      ),
                                      color: Colors.white),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        allTranslations.text(
                                            "slot_doctor.time_per_patient"),
                                        textAlign: TextAlign.start,
                                        style: themeData.textTheme.headline5
                                            ?.copyWith(
                                                color: themeData
                                                    .colorScheme.primary,
                                                fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal! *
                                            15,
                                      ),
                                      Text(
                                        allTranslations
                                            .text('slot_doctor.mnt', values: {
                                          'minute': duration!,
                                        }),
                                        textAlign: TextAlign.start,
                                        style: themeData.textTheme.headline5
                                            ?.copyWith(
                                                color: themeData
                                                    .colorScheme.primary,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // To make list locis dynamic
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
