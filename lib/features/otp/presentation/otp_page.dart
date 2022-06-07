import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/style/size_config.dart';
import 'package:hivet/core/widget/custom_toast.dart';
import 'package:hivet/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:hivet/features/otp/presentation/bloc/otp_state.dart';
import 'package:hivet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpPage extends StatefulWidget {
  final String countryCode;
  final String phoneNum;
  OtpPage({Key? key, required this.phoneNum, required this.countryCode})
      : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

late ProfileBloc profileBloc;

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpCodeController = TextEditingController();
  final CountdownController countdownController =
      new CountdownController(autoStart: true);
  bool isClickable = false;
  late OtpBloc otpBloc;
  // final RoutingService _routingService = g<RoutingService>();

  @override
  void initState() {
    otpBloc = BlocProvider.of<OtpBloc>(context);
    otpBloc.add(OtpInitEvent(widget.phoneNum, widget.countryCode));
    profileBloc = BlocProvider.of<ProfileBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    final pinTextFields = PinCodeTextField(
      appContext: context,
      pastedTextStyle: TextStyle(
        color: Colors.green.shade600,
        fontWeight: FontWeight.bold,
      ),
      length: 6,
      obscureText: false,
      // obscuringCharacter: '*',
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      // validator: (v) {
      //   if (v!.length < 3) {
      //     return "I'm from validator";
      //   } else {
      //     return null;
      //   }
      // },
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          disabledColor: Colors.white,
          inactiveFillColor: Colors.white,
          selectedColor: Colors.white),
      cursorColor: Colors.black,
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: themeData.colorScheme.background,
      enableActiveFill: true,
      // errorAnimationController: errorController,
      controller: otpCodeController,

      keyboardType: TextInputType.number,
      boxShadows: [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black12,
          blurRadius: 10,
        )
      ],
      onCompleted: (v) {
        print("Completed");
      },
      // onTap: () {
      //   print("Pressed");
      // },
      onChanged: (value) {
        // print(value);
        // setState(() {
        // currentText = value;
        // });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );

    return Scaffold(
        backgroundColor: themeData.colorScheme.background,
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.primary,
          centerTitle: false,
          title: Text(
            allTranslations.text('otp.verify'),
            style: TextStyle(
              color: themeData.colorScheme.background,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.white),
          //   onPressed: () {
          //     // _clearController();
          //   },
          // ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                right: SizeConfig.blockSizeHorizontal! * 8,
                left: SizeConfig.blockSizeHorizontal! * 8),
            child: BlocConsumer<OtpBloc, OtpState>(
                listener: (context, state) async {
              if (state.isSuccess!) {
                CustomToast.showToast(
                    msg: allTranslations.text('otp.success_title'),
                    statusToast: StatusToast.success,
                    context: context,
                    isAutoClosed: false);
                profileBloc.add(ProfileInitEvent());
                // _sessionBloc!.add(SessionLoggedInEvent(state.scopes!));

                Navigator.popUntil(
                  context,
                  (Route<dynamic> predicate) => predicate.isFirst,
                );
              } else if (state.isError!) {
                if (state.message == 'You cannot verify a verified user!') {
                  CustomToast.showToast(
                      msg: allTranslations.text('otp.user_verified'),
                      statusToast: StatusToast.fail,
                      context: context,
                      isAutoClosed: true);
                } else {
                  CustomToast.showToast(
                      msg: state.message!,
                      statusToast: StatusToast.fail,
                      context: context,
                      isAutoClosed: true);
                }
              }
            }, builder: (BuildContext context, OtpState state) {
              return Column(
                children: [
                  Container(
                    height: SizeConfig.blockSizeVertical! * 5,
                  ),
                  Container(
                    // color: Colors.yellow,
                    child: Image.asset(
                      "assets/images/lockotp.png",
                      height: SizeConfig.blockSizeVertical! * 25,
                      width: SizeConfig.blockSizeHorizontal! * 30,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          allTranslations.text('otp.otp_title'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: themeData.colorScheme.primary,
                              fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          allTranslations.text('otp.otp_subtitle'),
                          style: TextStyle(

                              // fontWeight: FontWeight.bold,
                              color: themeData.colorScheme.primary,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: SizeConfig.safeBlockVertical! * 4,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal! * 2,
                        left: SizeConfig.blockSizeHorizontal! * 2),
                    child: pinTextFields,
                  ),
                  Column(
                    children: <Widget>[
                      // isVerified ? pinTextFields : phoneTextField,
                      // _otpBloc.isPhoneChecked ? pinTextFields : phoneTextField,
                      SizedBox(height: SizeConfig.safeBlockHorizontal! * 2),
                      Container(
                        height: SizeConfig.safeBlockHorizontal! * 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 48,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              side: BorderSide.none),
                          onPressed: () async {
                            // if (isVerified) {
                            otpBloc.add(OtpSubmitEvent(
                                state.verificationId!,
                                otpCodeController.text,
                                widget.countryCode,
                                widget.phoneNum));
                          },
                          elevation: 2,
                          color: Color(0xffFFFE66),
                          disabledColor: Color(0xffFFFE66).withOpacity(0.5),
                          child: Text(
                            allTranslations.text('otp.verify'),
                            style: TextStyle(
                              color: themeData.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal! * 4,
                            ),
                          ),
                          splashColor: themeData.colorScheme.background,
                        ),
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical! * 5,
                      ),
                    ],
                  ),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(right: 12, left: 12),
                        // child: isVerified
                        child: GestureDetector(
                          onTap: () {
                            if (isClickable) {
                              setState(() {
                                isClickable = false;
                                // phoneSignIn(
                                //   phoneNumbers: _phoneController.text,
                                //   forceResendingToken: this.forceResendingToken,
                                // );
                                otpBloc.add(OtpResetCodeEvent(
                                    widget.phoneNum,
                                    widget.countryCode,
                                    state.forceResendingToken!));
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                allTranslations.text('otp.otp_resend_1'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: isClickable
                                        ? themeData.colorScheme.primary
                                        : Colors.grey[300],
                                    fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                              isClickable
                                  ? Container()
                                  : Countdown(
                                      controller: countdownController,
                                      seconds: 30,
                                      build:
                                          (BuildContext context, double time) {
                                        return Text(
                                          allTranslations
                                                  .text('otp.otp_resend_2') +
                                              time.toInt().toString() +
                                              allTranslations
                                                  .text('otp.otp_resend_3'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: isClickable
                                                  ? themeData
                                                      .colorScheme.background
                                                  : Colors.grey[300],
                                              fontSize: 14),
                                        );
                                      },
                                      interval: Duration(milliseconds: 100),
                                      onFinished: () {
                                        // print('Timer is done!');
                                        setState(() {
                                          isClickable = true;
                                        });
                                      },
                                    ),
                            ],
                          ),
                        )
                        // : Text(
                        //     allTranslations.text('otp.sms_sent'),
                        //     style: TextStyle(

                        //         color: themeData.colorScheme.background,
                        //         fontSize: 14),
                        //     textAlign: TextAlign.center,
                        //   ),
                        ),
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
