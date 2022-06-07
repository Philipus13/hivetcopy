import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/style/base_style.dart';
import 'package:hivet/core/style/size_config.dart';
import 'package:hivet/core/widget/custom_button.dart';
import 'package:hivet/core/widget/custom_toast.dart';
import 'package:hivet/core/widget/normal_text_field.dart';
import 'package:hivet/core/widget/phone_text_field.dart';
import 'package:hivet/features/forgot_pass/presentation/bloc/forgot_bloc.dart';
import 'package:hivet/features/forgot_pass/presentation/bloc/forgot_state.dart';
import 'package:hivet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:timer_count_down/timer_controller.dart';

class ForgotPage extends StatefulWidget {
  ForgotPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

late ProfileBloc profileBloc;
TextEditingController emailController = TextEditingController();
TextEditingController verivicationCodeController = TextEditingController();
TextEditingController newPasswordController = TextEditingController();

TextEditingController phoneController = TextEditingController();
TextEditingController countryCodeController = TextEditingController();
String phoneCountryCode = "+62";
final RegExp passRegexp = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$");

class _ForgotPageState extends State<ForgotPage> {
  TextEditingController otpCodeController = TextEditingController();
  final CountdownController countdownController =
      new CountdownController(autoStart: true);
  bool isClickable = false;
  late ForgotBloc forgotBloc;
  // final RoutingService _routingService = g<RoutingService>();

  @override
  void dispose() {
    _clearController();
    super.dispose();
  }

  @override
  void initState() {
    forgotBloc = BlocProvider.of<ForgotBloc>(context);

    super.initState();
  }

  void _clearController() {
    emailController.clear();
    verivicationCodeController.clear();
    newPasswordController.clear();
    phoneController.clear();
    countryCodeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: themeData.colorScheme.background,
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.primary,
          centerTitle: false,
          title: Text(
            allTranslations.text('forgot.forgot_title'),
            style: TextStyle(
              color: themeData.colorScheme.background,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              forgotBloc.add(ForgotDeleteEvent());
              _clearController();
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                right: SizeConfig.blockSizeHorizontal! * 8,
                left: SizeConfig.blockSizeHorizontal! * 8),
            child: BlocConsumer<ForgotBloc, ForgotState>(
                listener: (context, state) async {
              if (state.isSuccess!) {
                CustomToast.showToast(
                    msg: state.message!,
                    statusToast: StatusToast.success,
                    context: context,
                    isAutoClosed: false);
                // profileBloc.add(ProfileInitEvent());
                // _sessionBloc!.add(SessionLoggedInEvent(state.scopes!));
                forgotBloc.add(ForgotDeleteEvent());
                _clearController();
                Navigator.popUntil(
                  context,
                  (Route<dynamic> predicate) => predicate.isFirst,
                );
              } else if (state.isError!) {
                CustomToast.showToast(
                    msg: state.message!,
                    statusToast: StatusToast.fail,
                    context: context,
                    isAutoClosed: false);
              }
            }, builder: (BuildContext context, ForgotState state) {
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
                  state.status == 0 ? state0(themeData, state) : Container(),
                  state.status == 1 ? state1(themeData, state) : Container(),
                  state.status == 2 ? state2(themeData, state) : Container(),
                  state.status == 3 ? state3(themeData, state) : Container()
                ],
              );
            }),
          ),
        ));
  }

  bool obsecurePass = true;

  onTapShowed() {
    setState(() {
      obsecurePass = !obsecurePass;
    });
  }

  Widget state3(ThemeData themeData, ForgotState state) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            allTranslations.text('forgot.phone_success_subtitle'),
            style: TextStyle(

                // fontWeight: FontWeight.bold,
                color: themeData.colorScheme.primary,
                fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 4,
        ),
        NormalTextField(
          textEditingController: verivicationCodeController,
          title: allTranslations.text('forgot.verify_textfield'),
          hint: allTranslations.text('forgot.verify_textfield_hint'),
          textInputType: TextInputType.number,
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 1.5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(allTranslations.text('profile.new_pass_hint'),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16)),
            ),
            TextFormField(
              controller: newPasswordController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  fillColor: BaseStyle.hintBgTextfieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: BaseStyle.darkBlue),
                  ),
                  hintText: allTranslations.text('profile.new_pass_hint'),
                  suffixIcon: TextButton(
                    onPressed: () {
                      onTapShowed();
                    },
                    child: Text(
                      obsecurePass
                          ? allTranslations.text('profile.show')
                          : allTranslations.text('profile.hide'),
                      style: BaseStyle.ts14ExplicitBlackBold,
                    ),
                  )),
              obscureText: obsecurePass,
              keyboardType: TextInputType.visiblePassword,
              style: BaseStyle.ts14ExplicitBlack,
              validator: (String? textin) {
                if (textin!.isEmpty) {
                  return allTranslations.text('profile.new_pass_err_empty');
                } else if (!passRegexp.hasMatch(textin.toString())) {
                  return allTranslations.text('profile.new_pass_err_format');
                } else if (textin.length < 8) {
                  return allTranslations.text('profile.new_pass_err_length');
                }

                return null;
              },
              onChanged: (value) {},
              autovalidateMode: AutovalidateMode.always,
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 4,
        ),
        CustomButton(
            isLoading: state.isLoading!,
            text: allTranslations.text('forgot.verify_button'),
            onPressed: () {
              forgotBloc.add(ForgotChangePassEvent(
                  state.verificationId!,
                  verivicationCodeController.text,
                  state.token!,
                  newPasswordController.text));
            }),
        SizedBox(
          height: 10,
        ),
        Container(
          height: SizeConfig.blockSizeVertical! * 5,
        ),
      ],
    );
  }

  Widget state2(ThemeData themeData, ForgotState state) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            allTranslations.text('forgot.subtitle_phone'),
            style: TextStyle(

                // fontWeight: FontWeight.bold,
                color: themeData.colorScheme.primary,
                fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 4,
        ),
        PhoneTextField(
          textEditingController: phoneController,
          countryCodeController: countryCodeController,
          title: allTranslations.text('profile.phone_address_u'),
          hint: allTranslations.text('profile.phone_hint'),
          textInputType: TextInputType.phone,
          initialSelect: phoneCountryCode,
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 3,
        ),
        CustomButton(
            isLoading: state.isLoading!,
            text: allTranslations.text('forgot.verify_button'),
            onPressed: () {
              if (countryCodeController.text != ''
                  // ||
                  //     countryCodeController.text != null
                  ) {
                phoneCountryCode = countryCodeController.text;
              }
              forgotBloc.add(ForgotVerifyPhoneEvent(
                  phoneController.text, phoneCountryCode));
            }),
        SizedBox(
          height: 10,
        ),
        Container(
          height: SizeConfig.blockSizeVertical! * 5,
        ),
      ],
    );
  }

  Widget state1(ThemeData themeData, ForgotState state) {
    return Column(
      children: <Widget>[
        // isVerified ? pinTextFields : phoneTextField,
        // _otpBloc.isPhoneChecked ? pinTextFields : phoneTextField,
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            allTranslations.text('forgot.subtitle_email'),
            style: TextStyle(

                // fontWeight: FontWeight.bold,
                color: themeData.colorScheme.primary,
                fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 4,
        ),
        NormalTextField(
          textEditingController: emailController,
          title: allTranslations.text('forgot.email'),
          hint: allTranslations.text('profile.email_hint'),
          textInputType: TextInputType.emailAddress,
          prefixIcon: 'assets/images/emailicon.png',
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 3,
        ),

        CustomButton(
            isLoading: state.isLoading!,
            text: allTranslations.text('forgot.verify_button'),
            onPressed: () {
              forgotBloc.add(ForgotVerifyEmailEvent(emailController.text));
            }),
        SizedBox(
          height: 10,
        ),

        Container(
          height: SizeConfig.blockSizeVertical! * 5,
        ),
      ],
    );
  }

  Widget state0(ThemeData themeData, ForgotState state) {
    return Column(
      children: <Widget>[
        // isVerified ? pinTextFields : phoneTextField,
        // _otpBloc.isPhoneChecked ? pinTextFields : phoneTextField,
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            allTranslations.text('forgot.choose_method_message'),
            style: TextStyle(

                // fontWeight: FontWeight.bold,
                color: themeData.colorScheme.primary,
                fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 4,
        ),
        CustomButton(
            isLoading: false,
            text: allTranslations.text('forgot.phone'),
            onPressed: () {
              forgotBloc.add(ForgotGoToPhoneEvent());
            }),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 1,
        ),
        CustomButton(
            isLoading: state.isLoading!,
            text: allTranslations.text('forgot.email'),
            onPressed: () {
              forgotBloc.add(ForgotGoToEmailEvent());
            }),
        Container(
          height: SizeConfig.blockSizeVertical! * 5,
        ),
      ],
    );
  }
}
