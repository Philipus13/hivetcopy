import 'package:flutter/material.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/style/base_style.dart';
import 'package:hivet/core/style/size_config.dart';
import 'package:hivet/core/widget/custom_button.dart';

class SignInView extends StatelessWidget {
  final RegExp passRegexp = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$");
  final bool? autoval;
  final GlobalKey<FormState>? formKey;
  final String? username;
  final String? password;
  final bool? obsecurePass;
  final bool? buttonEnable;
  final TextEditingController? usernameController;
  final Function(String)? onChangeUsername;
  final Function(String)? onChangePassword;
  final Function? onLogin;
  final Function? onTapShowed;
  final Function? onTapExit;
  final Function? toRegisterPage;
  final bool? isLoading;
  final Function? toForgot;

  SignInView({
    Key? key,
    this.autoval,
    this.formKey,
    this.username,
    this.password,
    this.obsecurePass,
    this.buttonEnable,
    this.usernameController,
    this.onChangeUsername,
    this.onChangePassword,
    this.onLogin,
    this.onTapShowed,
    this.onTapExit,
    this.isLoading,
    this.toRegisterPage,
    this.toForgot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.primary,
        centerTitle: false,
        title: Text(
          allTranslations.text('auth.title_login'),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 5,
              ),
              Image.asset(
                'assets/images/logo_background_blue_h.png',
                height: SizeConfig.blockSizeVertical! * 20,
                width: double.infinity,
              ),
              // Divider(),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 5,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      allTranslations.text('auth.username'),
                      style: BaseStyle.ts14ExplicitBlackBold,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        fillColor: BaseStyle.hintBgTextfieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: BaseStyle.darkBlue),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(13),
                          child: Image.asset(
                            'assets/images/emailicon.png',
                            height: 1,
                            width: 1,
                          ),
                        ),
                        hintText: allTranslations.text('auth.username_hint'),
                      ),
                      keyboardType: TextInputType.text,
                      style: BaseStyle.ts14ExplicitBlack,
                      validator: (String? textin) {
                        if (textin!.isEmpty) {
                          return allTranslations
                              .text('auth.username_error_empty');
                        } else if (textin.length <= 6) {
                          return allTranslations
                              .text('auth.username_error_length');
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: onChangeUsername,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      allTranslations.text('profile.password'),
                      style: BaseStyle.ts14ExplicitBlackBold,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          fillColor: BaseStyle.hintBgTextfieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: BaseStyle.darkBlue),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/images/password_prefix_ic.png',
                              height: 1,
                              width: 1,
                            ),
                          ),
                          hintText: allTranslations.text('auth.pass_hint'),
                          suffixIcon: TextButton(
                            onPressed: () {
                              onTapShowed!();
                            },
                            child: Text(
                              obsecurePass!
                                  ? allTranslations.text('profile.show')
                                  : allTranslations.text('profile.hide'),
                              style: BaseStyle.ts14ExplicitBlackBold,
                            ),
                          )),
                      obscureText: obsecurePass!,
                      keyboardType: TextInputType.visiblePassword,
                      style: BaseStyle.ts14ExplicitBlack,
                      validator: (String? textin) {
                        if (textin!.isEmpty) {
                          return allTranslations
                              .text('profile.new_pass_err_empty');
                        } else if (!passRegexp.hasMatch(textin.toString())) {
                          return allTranslations
                              .text('profile.new_pass_err_format');
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: onChangePassword,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (() {
                      toForgot!();
                    }),
                    child: Text(
                      allTranslations.text('auth.forgot_pass'),
                      textAlign: TextAlign.end,
                      style: BaseStyle.ts14PrimaryBlack
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 24,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    allTranslations.text('auth.go_to_register1') + " ",
                    style: BaseStyle.ts14PrimaryBlack,
                  ),
                  InkWell(
                    onTap: () {
                      toRegisterPage!();
                    },
                    child: Text(
                      allTranslations.text('auth.go_to_register2'),
                      style: BaseStyle.ts14DarkBlue,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
        child: SizedBox(
          width: double.infinity,
          child: CustomButton(
            isLoading: false,
            text: allTranslations.text('auth.title_login'),
            onPressed: !passRegexp.hasMatch(password!) || isLoading!
                ? null
                : () {
                    onLogin!();
                  },
          ),
        ),
      ),
    );
  }
}
