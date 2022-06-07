import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/widget/button_list_option.dart';
import 'package:hivet/core/widget/custom_bottom_sheet.dart';
import 'package:hivet/core/widget/custom_toast.dart';

import 'package:hivet/core/widget/loading_spin_kit_widget.dart';
import 'package:hivet/features/auth/session/session_bloc.dart';
import 'package:hivet/features/auth/session/session_event.dart';
import 'package:hivet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:hivet/features/profile/presentation/change_password_sheet.dart';

import '../model/profile_model.dart';

late ProfileBloc profileBloc;
late SessionBloc sessionBloc;

class ProfilePage extends StatelessWidget {
  final String scopes;

  const ProfilePage({Key? key, required this.scopes}) : super(key: key);

  Widget buildInitialLoading(ThemeData themeData) {
    return Container(
      color: themeData.colorScheme.primary,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: LoadingSpinKit(color: Colors.white, ukuran: 50),
          )
        ],
      )),
    );
  }

  Widget buildInitialView(BuildContext context, ProfileState state,
      RoutingService _routingService, ThemeData themeData) {
    String? name = allTranslations.text('tab.guest');
    String? countryCode = '';
    String? phone = '-';
    String? email = 'email@email.com';
    dynamic sendProfile;
    bool isVerified = false;
    if (state is ProfileLoadedState) {
      Data? profileModel = state.profileResponseModel;
      profileModel?.scopes = scopes;
      sendProfile = profileModel as dynamic;
      name = profileModel?.user!.fullName;
      email = profileModel?.user!.email;
      countryCode = profileModel?.user!.countryCode ?? '';
      phone = profileModel?.user!.phone ?? '';

      isVerified = state.isVerified!;
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(
                  color: themeData.colorScheme.primary,
                  width: 1,
                ),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: CommonConstants.gradientColors),
              ),
              child: Column(
                children: <Widget>[
                  scopes == CommonConstants.guest
                      ? Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 16,
                          ),
                          child: Text(
                              "Ayo masuk akun kamu untuk memenuhi kebutuhan binatang peliharaanmu",
                              style: themeData.textTheme.headline3?.copyWith(
                                  color: themeData.colorScheme.primary,
                                  height: 1.4,
                                  fontSize: 20)
                              // TextStyle(
                              //     height: 1.4,
                              //     fontWeight: FontWeight.bold,
                              //     color: Colors.white,
                              //     fontSize: 20),
                              ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 16,
                          ),
                          child: Row(
                            children: [
                              Center(
                                child:
                                    // Stack(
                                    //   children: <Widget>[
                                    Material(
                                  child: Material(
                                    child:
                                        // CachedNetworkImage(
                                        //   errorWidget: (context, url, error) =>
                                        //       CachedNetworkImage(
                                        //     errorWidget: (context, url, error) =>
                                        //         Container(),
                                        //     width: 90,
                                        //     height: 90,
                                        //     fit: BoxFit.cover,
                                        //     imageUrl: _imageString,
                                        //     httpHeaders: header,
                                        //   ),
                                        //   width: 90,
                                        //   height: 90,
                                        //   fit: BoxFit.cover,
                                        //   imageUrl: url,
                                        //   httpHeaders: header,
                                        // ),
                                        Image.asset(
                                      'assets/images/userprofile_default.png',
                                      width: 90.0,
                                      height: 90.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(45.0)),
                                    clipBehavior: Clip.hardEdge,
                                  ),
//
                                  // imageFile != null
                                  //     ? Image.file(
                                  //         imageFile,
                                  //         width: 90.0,
                                  //         height: 90.0,
                                  //         fit: BoxFit.cover,
                                  //       )
                                  //     : Image.asset(
                                  //         'assets/defaultphoto.png',
                                  //         width: 90.0,
                                  //         height: 90.0,
                                  //         fit: BoxFit.cover,
                                  //       ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(45.0)),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                // Positioned(
                                //     // right: 0,
                                //     right: 0,
                                //     bottom: 0,
                                //     child: Image.asset(
                                //       gender == 'M'
                                //           ? 'assets/gender_m.png'
                                //           : 'assets/gender_f.png',
                                //       width: 30.0,
                                //       height: 30.0,
                                //       fit: BoxFit.cover,
                                //     ))
                                // ],
                                // ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        child: Text(
                                      name!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18),
                                    )),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 8, bottom: 8),
                                      child: Text(email!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                    ),
                                    Text(countryCode + phone,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  GestureDetector(
                    onTap: () async {
                      if (scopes == CommonConstants.guest) {
                        await _routingService
                            .navigateTo(CommonConstants.routeSignIn);
                      } else {
                        final result = await _routingService.navigateTo(
                            CommonConstants.routeUpdateProfil,
                            arguments: sendProfile);
                        if (result) {
                          profileBloc.add(ProfileInitEvent());
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(right: 16, left: 16),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: themeData.colorScheme.primary,
                        ),
                        child: Text(
                          scopes == CommonConstants.guest
                              ? allTranslations.text('profile.login_button')
                              : allTranslations.text('profile.update_profile'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                      child: Container()),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 8,
          ),
          scopes == CommonConstants.guest
              ? Container()
              : ButtonListOption(
                  title: allTranslations.text('profile.update_pass'),
                  leftIcon: 'assets/images/ubah_password.png',
                  onPressed: () {
                    CustomBottomSheet.showBottomSheet(
                        height: 42,
                        context: context,
                        widget: ChangePassword(
                            // oldPasswordController: passwordController,
                            // newPasswordController: rePasswordController,
                            ));
                  }),

          scopes == CommonConstants.toko
              ? ButtonListOption(
                  title: allTranslations.text('profile.courier'),
                  leftIcon: 'assets/images/kurir.png')
              : Container(),
          scopes == CommonConstants.doctor || scopes == CommonConstants.toko
              ? ButtonListOption(
                  title: allTranslations.text('profile.wallet'),
                  leftIcon: 'assets/images/dompet.png')
              : Container(),
          ButtonListOption(
            title: allTranslations.text('profile.help'),
            leftIcon: 'assets/images/call.png',
            onPressed: () {
              CustomBottomSheet.showDialogAdminHelp(context: context);
              // _routingService.navigateTo(CommonConstants.routeOTP);
            },
          ),
          !isVerified && scopes != CommonConstants.guest
              ? ButtonListOption(
                  title: allTranslations.text('profile.verify_phone'),
                  leftIcon: 'assets/images/call.png',
                  onPressed: () {
                    // CustomBottomSheet.showDialogAdminHelp(context: context);
                    dynamic send = {'countryCode': countryCode, 'phone': phone};
                    _routingService.navigateTo(CommonConstants.routeOTP,
                        arguments: send);
                  },
                )
              : Container(),
          ButtonListOption(
            title: allTranslations.text('profile.tnc'),
            leftIcon: 'assets/images/document.png',
            onPressed: () async {
              await _routingService.navigateTo(CommonConstants.routetnc);
            },
          ),
          ButtonListOption(
              title: allTranslations.text('profile.faq'),
              leftIcon: 'assets/images/document.png'),
          ButtonListOption(
              title: allTranslations
                  .text('profile.version', values: {'version': '1.0.0'}),
              leftIcon: 'assets/images/document.png'),
          // scopes == CommonConstants.pengguna
          //     ? ButtonListOption(
          //         title: 'Pengguna', leftIcon: 'assets/images/call.png')
          // : Container(),
          scopes == CommonConstants.guest
              ? Container()
              : ButtonListOption(
                  title: allTranslations.text('profile.logout'),
                  leftIcon: 'assets/images/cross.png',
                  onPressed: () {
                    sessionBloc.add(SessionLoggedOutEvent());
                  },
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    sessionBloc = BlocProvider.of<SessionBloc>(context);

    profileBloc = BlocProvider.of<ProfileBloc>(context);

    profileBloc.add(ProfileInitEvent());
    final RoutingService _routingService = g<RoutingService>();
    ThemeData themeData = Theme.of(context);

    // profileBloc.add(InitProfile(_userRepository));

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.primary,
        centerTitle: false,
        title: Text(
          allTranslations.text('tab.profile'),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        // height: double.infinity,
        // width: double.infinity,
        // decoration: BoxDecoration(

        //   image: DecorationImage(
        //     image: AssetImage('assets/bg.jpg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //       Colors.black.withAlpha(0xBF),
        //       BlendMode.darken,
        //     ),
        //   ),
        // ),
        // child: buildInitialView(context)
        child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: ((context, state) {
              if (state is ChangePassSuccessState) {
                CustomToast.showToast(
                    msg: allTranslations
                        .text('profile.change_pass_success_message'),
                    statusToast: StatusToast.success,
                    context: context,
                    second: 2,
                    isAutoClosed: true);
                Navigator.pop(context);
              }
              if (state is ChangePassFailedState) {
                if (state.message == 'Invalid Password') {
                  CustomToast.showToast(
                      msg: allTranslations
                          .text('profile.change_pass_failed_mes_wrong_pass'),
                      statusToast: StatusToast.fail,
                      context: context,
                      second: 2,
                      isAutoClosed: true);
                } else {
                  CustomToast.showToast(
                      msg: state.message!,
                      statusToast: StatusToast.fail,
                      context: context,
                      second: 2,
                      isAutoClosed: true);
                }

                Navigator.pop(context);
              }
            }),
            bloc: profileBloc,
            builder: (BuildContext context, ProfileState state) {
              if (state is ProfileLoadingState) {
                return buildInitialLoading(themeData);
              }

              return buildInitialView(
                  context, state, _routingService, themeData);
            }),
      ),
    );
  }
}
