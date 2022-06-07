import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/style/size_config.dart';
import 'package:hivet/core/widget/custom_bottom_sheet.dart';
import 'package:hivet/core/widget/custom_button.dart';
import 'package:hivet/features/auth/register/presentation/register_view.dart';
import 'package:hivet/features/auth/session/session_bloc.dart';
import 'package:hivet/features/auth/session/session_event.dart';

import 'bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

String email = '';
String countryCode = '+62';
String phone = '';
String password = '';
String username = '';
String fullname = '';
RegisterBloc? _bloc;

class _RegisterPageState extends State<RegisterPage> {
  bool autoval = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool obsecurePass = true;
  bool buttonEnable = false;
  var emailController = TextEditingController();
  var fullnameController = TextEditingController();
  var usernameController = TextEditingController();
  var countryCodeController = TextEditingController();
  var phoneController = TextEditingController();
  late SessionBloc _sessionBloc;

  @override
  void initState() {
    super.initState();
    _bloc = RegisterBloc();
    _sessionBloc = BlocProvider.of<SessionBloc>(context);
  }

  @override
  void dispose() {
    _bloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);

    return BlocListener(
      bloc: _bloc,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, RegisterState state) {
          return RegisterView(
            autoval: autoval,
            buttonEnable: buttonEnable,
            email: email,
            emailController: emailController,
            formKey: globalKey,
            obsecurePass: obsecurePass,
            onChangeEmail: onChangeEmail,
            onChangePassword: onChangePassword,
            onRegister: _registerButtonPressed,
            onTapShowed: onTapShowed,
            password: password,
            onTapExit: onTapExit,
            onchagePhone: onChangePhone,
            onChangeCountry: onChangeCountry,
            isLoading: (state is RegisterLoading),
            fullnameController: fullnameController,
            phoneController: phoneController,
            onChangeFullname: onChangeFullname,
            onChangeUsername: onChangeUsername,
            usernameController: usernameController,
            countryCodeController: countryCodeController,
            errorMessage: (state is RegisterFailed) ? state.errorMessage : '',
          );
        },
      ),
      listener: (BuildContext context, RegisterState state) async {
        if (state is RegisterSuccess) {
          CustomBottomSheet.showBottomSheet(
              context: context,
              height: 30,
              widget:
                  BodyBottomSheet(themeData: themeData, username: username));
        }
        if (state is RegisterVerified) {
          _sessionBloc.add(SessionLoggedInEvent(state.scopes!));

          dynamic send = {
            'countryCode': state.countryCode,
            'phone': state.phone
          };
          await _routingService.navigateTo(CommonConstants.routeOTP,
              arguments: send);
        }
      },
    );
  }

  onTapExit() {
    Navigator.pop(context);
  }

  onChangeEmail(String value) {
    setState(() {
      email = value;
    });
  }

  onChangeCountry(CountryCode value) {
    setState(() {
      countryCode = value.dialCode ?? "+62";
    });
  }

  onChangePhone(String value) {
    setState(() {
      phone = value;
    });
  }

  onChangeUsername(String value) {
    setState(() {
      username = value;
    });
  }

  onChangeFullname(String value) {
    setState(() {
      fullname = value;
    });
  }

  onChangePassword(String value) {
    setState(() {
      password = value;
    });
  }

  onTapShowed() {
    setState(() {
      obsecurePass = !obsecurePass;
    });
  }

  void _registerButtonPressed() {
    if (!globalKey.currentState!.validate()) {
      setState(() {
        autoval = true;
      });
    } else {
      // print('ini dia:  ' + countryCode + ' ' + phone);

      _bloc!.add(RegisterUserEvent(
          email: email,
          fullName: fullname,
          password: password,
          username: username,
          countryCode: countryCode,
          phone: phone));
    }
  }
}

final RoutingService _routingService = g<RoutingService>();

class BodyBottomSheet extends StatelessWidget {
  const BodyBottomSheet({
    Key? key,
    required this.themeData,
    required this.username,
  }) : super(key: key);

  final ThemeData themeData;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              allTranslations.text('auth.register_success'),
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
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  allTranslations.text('auth.register_success_verify_confirm'),
                  style: themeData.textTheme.headline5?.copyWith(
                      color: themeData.colorScheme.primary,
                      height: 1.2,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
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
                    text: allTranslations.text('auth.no'),
                    onPressed: () {
                      _routingService.goBack();
                      _routingService.goBackPopStack(username);
                      // Navigator.pop(context);
                      // Navigator.pop(context, username);
                    }),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomButton(
                    size: 40,
                    isLoading: false,
                    text: allTranslations.text('auth.yes'),
                    onPressed: () async {
                      print('berhasil');
                      // dynamic send = {
                      //   'countryCode': countryCode,
                      //   'phone': phone
                      // };
                      // await _routingService.navigateTo(CommonConstants.routeOTP,
                      //     arguments: send);
                      _bloc!.add(RegisterSuccessEvent(
                          password: password,
                          username: username,
                          countryCode: countryCode,
                          phone: phone));
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
    );
  }
}
