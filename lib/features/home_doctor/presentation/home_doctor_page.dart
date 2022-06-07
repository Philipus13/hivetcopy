import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/style/size_config.dart';
import 'package:hivet/features/home/presentation/bloc/home_bloc.dart';
import 'package:hivet/core/model/master_model.dart' as masterModel;
import 'package:hivet/features/profile/model/profile_model.dart'
    as profileModel;

class HomeDoctorPage extends StatefulWidget {
  final String scopes;

  HomeDoctorPage(this.scopes);
  @override
  createState() => _HomeDoctorPageState();
}

late HomeBloc homeBloc;

class _HomeDoctorPageState extends State<HomeDoctorPage> {
  _HomeDoctorPageState();

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);

    homeBloc.add(HomeInitEvent(widget.scopes));

    super.initState();
  }

  Widget buildCategoryList(
    ThemeData themeData,
    masterModel.Data? model,
  ) {
    return Column(
      children: [
        Container(
          height: SizeConfig.blockSizeVertical! * 10,
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: Color.fromRGBO(226, 245, 252, 1),
                width: 1,
              ),
              color: themeData.colorScheme.primary),
          child: Container(
              padding: EdgeInsets.all(15),
              height: SizeConfig.blockSizeVertical! * 10,
              width: SizeConfig.blockSizeHorizontal! * 20,
              child:
                  // SvgPicture.asset(
                  //   'assets/svg/vet.svg',
                  // ),
                  SvgPicture.network(
                'https://www.svgrepo.com/show/295886/veterinarian.svg',
                // semanticsLabel: 'A shark?!',
                // color: Colors.amber,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const CircularProgressIndicator()),
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            model?.modelName ?? '',
            textAlign: TextAlign.center,
            style: themeData.textTheme.bodyText1?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    final RoutingService _routingService = g<RoutingService>();
    String? name = allTranslations.text('home.title_guest');
    String? weatherText = 'home.weather_morning';
    profileModel.Data? pModel;
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: BlocConsumer<HomeBloc, HomeState>(listener: ((context, state) {
          if (state is HomeNotLoadedState) {
            print(state.message);
          }
        }), builder: (BuildContext context, HomeState state) {
          if (state is HomeLoadedState) {
            weatherText = state.weatherText ?? '';

            if (state.profileResponseModel != null) {
              pModel = state.profileResponseModel;
              name = pModel?.user?.fullName;
            }
          }
          if (state is HomeNotLoadedState) {
            weatherText = state.weatherText;
            pModel = state.profileResponseModel;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 4,
              ),
              Text(
                allTranslations
                    .text("home.title_welcome", values: {'name': name}),
                textAlign: TextAlign.center,
                style: themeData.textTheme.headline2,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 0.5,
              ),
              Text(
                allTranslations.text(weatherText!),
                textAlign: TextAlign.center,
                style: themeData.textTheme.headline2
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical! * 3,
                          bottom: SizeConfig.blockSizeVertical! * 3),
                      height: SizeConfig.blockSizeVertical! * 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Saldo",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: themeData.colorScheme.background,
                                fontSize: 16),
                          ),
                          Text(
                            "Rp 12.250",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: themeData.colorScheme.background,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                            color: Color.fromRGBO(226, 245, 252, 1),
                            width: 1,
                          ),
                          color: themeData.colorScheme.primary),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical! * 3,
                          bottom: SizeConfig.blockSizeVertical! * 3),
                      height: SizeConfig.blockSizeVertical! * 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Pasien",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: themeData.colorScheme.background,
                                fontSize: 16),
                          ),
                          Text(
                            "12",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: themeData.colorScheme.background,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                            color: Color.fromRGBO(226, 245, 252, 1),
                            width: 1,
                          ),
                          color: themeData.colorScheme.primary),
                    ),
                  ),
                ],
              ),
              // Container(
              //   height: 100,
              //   width: 100,
              //   child:
              //       SvgPicture.asset(assetName, semanticsLabel: 'A red up arrow'),
              // ),

              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 1,
              ),
              Text(
                "Baru saja ditangani",
                textAlign: TextAlign.center,
                style: themeData.textTheme.headline3,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              GestureDetector(
                onTap: () {
                  _routingService.navigateTo(
                    CommonConstants.routeReservation,
                  );
                },
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Color.fromRGBO(226, 245, 252, 1),
                      width: 1,
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: CommonConstants.gradientColors),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeHorizontal! * 2.1,
                    horizontal: SizeConfig.blockSizeHorizontal! * 2.1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: SizeConfig.blockSizeHorizontal! * 15,
                        width: SizeConfig.blockSizeHorizontal! * 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff6DC9EE).withOpacity(0.1),
                          border: Border.all(
                            color: Color(0xff999999).withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/home_consult1.png',
                          height: SizeConfig.blockSizeHorizontal! * 8.5,
                          width: SizeConfig.blockSizeHorizontal! * 8.5,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal! * 2.1),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allTranslations.text('home.direct_consult'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff137BA4),
                                  fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Text(
                              allTranslations
                                  .text('home.direct_consult_subtitle'),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff666666),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Color.fromRGBO(226, 245, 252, 1),
                      width: 1,
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: CommonConstants.gradientColors),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeHorizontal! * 2.1,
                    horizontal: SizeConfig.blockSizeHorizontal! * 2.1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: SizeConfig.blockSizeHorizontal! * 15,
                        width: SizeConfig.blockSizeHorizontal! * 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff6DC9EE).withOpacity(0.1),
                          border: Border.all(
                            color: Color(0xff999999).withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/home_consult2.png',
                          height: SizeConfig.blockSizeHorizontal! * 8.5,
                          width: SizeConfig.blockSizeHorizontal! * 8.5,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal! * 2.1),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allTranslations.text('home.slot_consult'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff137BA4),
                                  fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Text(
                              allTranslations
                                  .text('home.slot_consult_subtitle'),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff666666),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),

              Text(
                "Butuh Konfirmasi",
                textAlign: TextAlign.center,
                style: themeData.textTheme.headline3,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              GestureDetector(
                onTap: () {
                  _routingService.navigateTo(
                    CommonConstants.routeReservation,
                  );
                },
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Color.fromRGBO(226, 245, 252, 1),
                      width: 1,
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: CommonConstants.gradientColors),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeHorizontal! * 2.1,
                    horizontal: SizeConfig.blockSizeHorizontal! * 2.1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: SizeConfig.blockSizeHorizontal! * 15,
                        width: SizeConfig.blockSizeHorizontal! * 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff6DC9EE).withOpacity(0.1),
                          border: Border.all(
                            color: Color(0xff999999).withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/home_consult1.png',
                          height: SizeConfig.blockSizeHorizontal! * 8.5,
                          width: SizeConfig.blockSizeHorizontal! * 8.5,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal! * 2.1),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allTranslations.text('home.direct_consult'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff137BA4),
                                  fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Text(
                              allTranslations
                                  .text('home.direct_consult_subtitle'),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff666666),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Color.fromRGBO(226, 245, 252, 1),
                      width: 1,
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: CommonConstants.gradientColors),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeHorizontal! * 2.1,
                    horizontal: SizeConfig.blockSizeHorizontal! * 2.1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: SizeConfig.blockSizeHorizontal! * 15,
                        width: SizeConfig.blockSizeHorizontal! * 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff6DC9EE).withOpacity(0.1),
                          border: Border.all(
                            color: Color(0xff999999).withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/home_consult2.png',
                          height: SizeConfig.blockSizeHorizontal! * 8.5,
                          width: SizeConfig.blockSizeHorizontal! * 8.5,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal! * 2.1),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allTranslations.text('home.slot_consult'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff137BA4),
                                  fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Text(
                              allTranslations
                                  .text('home.slot_consult_subtitle'),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff666666),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    ));
  }
}
