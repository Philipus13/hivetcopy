import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/local/user_secure_storage.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/features/auth/session/session_bloc.dart';
import 'package:hivet/features/auth/session/session_event.dart';
import 'package:hivet/features/auth/sign_in/presentation/sign_in_view.dart';

import 'bloc/sign_in_bloc.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool autoval = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool obsecurePass = true;
  bool buttonEnable = false;
  var usernameController = TextEditingController();
  var loginSuccess = true;
  SignInBloc? _bloc;
  SessionBloc? _sessionBloc;
  final RoutingService _routingService = g<RoutingService>();

  @override
  void initState() {
    super.initState();
    _bloc = SignInBloc();
    _sessionBloc = BlocProvider.of<SessionBloc>(context);
  }

  @override
  void dispose() {
    _bloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, SignInState state) {
          return SignInView(
            autoval: autoval,
            buttonEnable: buttonEnable,
            username: username,
            usernameController: usernameController,
            formKey: globalKey,
            obsecurePass: obsecurePass,
            onChangeUsername: onChangeUsername,
            onChangePassword: onChangePassword,
            onLogin: _signInButtonPressed,
            onTapShowed: onTapShowed,
            password: password,
            toRegisterPage: toRegisterPage,
            onTapExit: onTapExit,
            isLoading: (state is SignInLoading),
            toForgot: toForgot,
          );
        },
      ),
      listener: (BuildContext context, SignInState state) async {
        if (state is SaveTokenSuccess) {
          String token = await UserSecureStorage.getToken() ?? '';
          print(token);
          Navigator.pop(context);

          _sessionBloc!.add(SessionLoggedInEvent(state.scopes!));
        }
        if (state is SignInSuccess) {
          _bloc!.add(SaveTokenToLocalEvent(
              signInResponseModel: state.signInResponseModel));
        }
        if (state is SignInError) {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(state.errMessage!),
              ),
            ),
          );
        }
      },
    );
  }

  toRegisterPage() async {
    final result =
        await _routingService.navigateTo(CommonConstants.routeRegister);
    if (result != null) {
      setState(() {
        username = result.toString();
        usernameController.text = result.toString();
      });
    }
  }

  toForgot() async {
    await _routingService.navigateTo(CommonConstants.routeForgot);
  }

  onTapExit() {
    Navigator.pop(context);
  }

  onChangeUsername(String value) {
    setState(() {
      username = value;
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

  void _signInButtonPressed() {
    if (!globalKey.currentState!.validate()) {
      setState(() {
        autoval = true;
      });
    } else {
      _bloc!.add(SignInAccountEvent(username: username, password: password));
    }
  }
}
