import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/config/helper.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/style/size_config.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hivet/core/model/master_model.dart' as masterModel;
// import 'package:hivet/features/reservation/model/slot_model.dart' as slotModel;

import 'bloc/reservation_bloc.dart';

class ReservationPage extends StatefulWidget {
  ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  int _selectedIndex = 0;
  bool isFilterSelected = false;
  final ScrollController _scrollController = ScrollController();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ReservationBloc? reservationBloc;
  String? specialization;
  String? day;
  int initSkip = 0;
  int limit = 5;
  final RoutingService _routingService = g<RoutingService>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    reservationBloc = BlocProvider.of<ReservationBloc>(context);
    reservationBloc!.add(ReservationInitEvent());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);

    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    bool? hasReachedMax = reservationBloc?.hasReachedMax;

    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        !hasReachedMax!) {
      reservationBloc?.add(ScrollListEvent(
          specialization: specialization,
          day: day,
          skip: reservationBloc?.page,
          limit: limit));
    }
  }

  _onSelectedPoli(int index, masterModel.Data? masterModel) {
    setState(() {
      _selectedIndex = index;
      isFilterSelected = false;
    });

    specialization = masterModel?.modelName;
    if (specialization == 'Semua') {
      specialization = null;
    }
    reservationBloc!.add(LoadListEvent(
      specialization: specialization,
      day: day ?? Helper.convertToDay(_selectedDay!),
      skip: initSkip,
      limit: limit,
    ));
  }

  // _onSelectFilter() {
  //   setState(() {
  //     _selectedIndex = 0;
  //     isFilterSelected = true;
  //   });
  // }

  Widget buildPoliBody(BuildContext ctxt, int index, ThemeData themeData,
      masterModel.Data? masterData) {
    return GestureDetector(
        onTap: () {
          // if (index == 0) {
          //   _onSelectFilter();
          // } else {
          _onSelectedPoli(index, masterData);
          // }
        },
        child: Card(
          // color: ApplicationColors.mainBackGround,
          color: _selectedIndex == index
              ? themeData.colorScheme.background
              : (isFilterSelected && index == 0)
                  ? themeData.colorScheme.background
                  : themeData.colorScheme.primary,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(
                width: 1,
                color: _selectedIndex == index
                    ? themeData.colorScheme.background
                    : themeData.colorScheme.background,
              )),
          elevation: 0,
          child: Center(
            child: Container(
              padding: EdgeInsetsDirectional.only(start: 10, end: 10),
              child:
                  // index == 0
                  //     ?
                  //     Row(
                  //         children: [
                  //           (isFilterSelected)
                  //               ? Image.asset(
                  //                   'assets/images/filter_ic.png',
                  //                   height: SizeConfig.countHorizontalSize(16),
                  //                   width: SizeConfig.countHorizontalSize(16),
                  //                 )
                  //               : Image.asset(
                  //                   'assets/images/filter_light_ic.png',
                  //                   height: SizeConfig.countHorizontalSize(16),
                  //                   width: SizeConfig.countHorizontalSize(16),
                  //                 ),
                  //           SizedBox(width: SizeConfig.countHorizontalSize(4)),
                  //           Text(
                  //             'Filter',
                  //             style: TextStyle(
                  //               color: (isFilterSelected && index == 0)
                  //                   ? themeData.colorScheme.primary
                  //                   : themeData.colorScheme.background,
                  //             ),
                  //           ),
                  //         ],
                  //       )
                  //     :
                  Text(
                masterData?.modelName ?? '',
                style: TextStyle(
                  color: _selectedIndex == index
                      ? themeData.colorScheme.primary
                      : themeData.colorScheme.background,
                ),
              ),
            ),
          ),
        ));

    // new Text(result[index].poliName, style: TextStyle(color: Colors.blue),));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);

    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

    return Scaffold(
        backgroundColor: themeData.colorScheme.background,
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.primary,
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              _routingService.goBack();
              reservationBloc?.add(GoBackEvent());
            },
          ),
          title: Text(
            allTranslations.text('reservation.title'),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(
                height: 0.5,
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                decoration: new BoxDecoration(
                  color: themeData.colorScheme.primary,
                  border: new Border.all(
                      color: themeData.colorScheme.primary,
                      width: 0.0,
                      style: BorderStyle.none),
                  borderRadius: new BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    Container(
                      child: TableCalendar(
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        availableGestures: AvailableGestures.horizontalSwipe,
                        availableCalendarFormats: {
                          CalendarFormat.month: 'Expand',
                          CalendarFormat.week: 'Shorten',
                        },
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle().copyWith(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          weekendStyle: TextStyle().copyWith(
                              color: themeData.colorScheme.tertiary,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: true,
                          weekendTextStyle: TextStyle().copyWith(
                              color: themeData.colorScheme.tertiary,
                              fontSize: 12),
                          holidayTextStyle: TextStyle().copyWith(
                              color: themeData.colorScheme.tertiary,
                              fontSize: 12),
                          outsideTextStyle: TextStyle().copyWith(
                              color: themeData.colorScheme.background,
                              fontSize: 12),
                          disabledTextStyle: TextStyle().copyWith(
                              color: themeData.colorScheme.background),
                          defaultTextStyle: TextStyle().copyWith(
                              color: themeData.colorScheme.background),

                          // holidayStyle:
                          //     TextStyle().copyWith(color: ApplicationColors.mainYellowColor),
                        ),
                        headerStyle: HeaderStyle(
                          titleTextFormatter: (date, locale) =>
                              DateFormat("dd MMMM yyyy").format(date),
                          titleTextStyle: TextStyle(
                              color: themeData.colorScheme.background,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          formatButtonShowsNext: true,
                          formatButtonTextStyle: TextStyle().copyWith(
                              color: themeData.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          formatButtonDecoration: BoxDecoration(
                            color: themeData.colorScheme.background,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          leftChevronIcon: Icon(Icons.chevron_left,
                              color: themeData.colorScheme.background),
                          rightChevronIcon: Icon(Icons.chevron_right,
                              color: themeData.colorScheme.background),
                        ),
                        selectedDayPredicate: (day) {
                          // Use `selectedDayPredicate` to determine which day is currently selected.
                          // If this returns true, then `day` will be marked as selected.

                          // Using `isSameDay` is recommended to disregard
                          // the time-part of compared DateTime objects.
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            // Call `setState()` when updating the selected day

                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });

                            day = Helper.convertToDay(selectedDay);

                            reservationBloc!.add(LoadListEvent(
                              specialization: specialization,
                              day: day,
                              skip: initSkip,
                              limit: limit,
                            ));
                          }
                        },
                        calendarBuilders: CalendarBuilders(
                            selectedBuilder: (context, date, _) {
                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                            width: 100,
                            height: 100,
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style: TextStyle().copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: themeData.colorScheme.primary),
                              ),
                            ),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: new Border.all(
                                  color: themeData.colorScheme.primary,
                                  width: 0.0,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          );
                        }, todayBuilder: (context, date, _) {
                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            width: 100,
                            height: 100,
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style: TextStyle().copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    color: Colors.white),
                              ),
                            ),
                            decoration: new BoxDecoration(
                              color: themeData.colorScheme.primary,
                              border: new Border.all(
                                  color: themeData.colorScheme.background,
                                  width: 0.0,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          );
                        }),
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            // Call `setState()` when updating calendar format
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          // No need to call `setState()` here
                          _focusedDay = focusedDay;
                        },
                      ),
                    ),
                    // Divider(
                    //   height: 0.5,
                    //   color: Colors.white,
                    // ),
                    // SizedBox(
                    //   height: 12,
                    // ),
                    BlocConsumer<ReservationBloc, ReservationState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        List<masterModel.Data>? masterList =
                            state.masterListSpecialization;

                        return Container(
                          // margin: EdgeInsets.only(top: 10),

                          padding:
                              EdgeInsets.only(left: 5, right: 5, bottom: 5),

                          // color: Colors.white,
                          height: SizeConfig.blockSizeVertical! * 6,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: masterList?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) =>
                                buildPoliBody(context, index, themeData,
                                    masterList?[index]),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              BlocConsumer<ReservationBloc, ReservationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  // List<masterModel.Data>? masterList = state.masterList;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal! * 3,
                        right: SizeConfig.safeBlockHorizontal! * 3,
                        top: SizeConfig.safeBlockHorizontal! * 3,
                        bottom: SizeConfig.safeBlockHorizontal! * 3,
                      ),
                      child: _buildListDoctor(themeData, state),
                    ),
                  );
                },
              )
            ],
          ),
        )
        // ),
        );
  }

  Future<void> _refresh() async {
    // reservationBloc!.add(ReservationInitEvent());
    reservationBloc!.add(LoadListEvent(
      specialization: specialization,
      day: day ?? Helper.convertToDay(_selectedDay!),
      skip: initSkip,
      limit: limit,
    ));
  }

  Widget _buildListDoctor(ThemeData themeData, ReservationState state) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: state.slotList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              dynamic send = {
                'slotList': state.slotList![index],
              };

              await _routingService.navigateTo(
                  CommonConstants.routeReservationDetail,
                  arguments: send);

              // state.slotList![index];
            },
            child: Card(
              color: Colors.white,
              elevation: 0,
              child: Container(
                // height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                    ),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 60,
                          child: Text(
                            allTranslations.text('reservation.dr_title') +
                                " " +
                                state.slotList![index].fullName!,
                            style: themeData.textTheme.headline5?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          state.slotList![index].specialization!,
                          style: themeData.textTheme.bodyText1
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/mini_calendar.png",
                              height: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              state.slotList![index].experience! +
                                  ' ' +
                                  allTranslations.text('reservation.year'),
                              style: themeData.textTheme.bodyText1?.copyWith(
                                  color: themeData.colorScheme.primary),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/dollar.png",
                              height: 20,
                            ),
                            SizedBox(width: 12),
                            Text(
                              Helper.convertToRupiah(
                                  double.parse(state.slotList![index].fee!)),
                              style: themeData.textTheme.bodyText1?.copyWith(
                                  color: themeData.colorScheme.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    color: Color.fromRGBO(226, 245, 252, 1),
                    width: 1,
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: CommonConstants.gradientColors),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),
    );
  }
}
