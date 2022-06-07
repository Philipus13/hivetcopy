import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/style/base_style.dart';
import 'package:hivet/core/style/size_config.dart';

class RegisterView extends StatelessWidget {
  final RegExp emailRegExp = RegExp(r'@');
  final RegExp passRegexp = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$");
  final bool? autoval;
  final GlobalKey<FormState>? formKey;
  final String? email;
  final String? password;
  final bool? obsecurePass;
  final bool? buttonEnable;
  final TextEditingController? emailController;
  final TextEditingController? fullnameController;
  final TextEditingController? countryCodeController;
  final TextEditingController? phoneController;
  final TextEditingController? usernameController;
  final Function(String)? onChangeEmail;
  final Function(String)? onChangePassword;
  final Function(String)? onChangeFullname;
  final Function(String)? onChangeUsername;
  final Function(String)? onchagePhone;
  final Function(CountryCode)? onChangeCountry;
  final Function? onRegister;
  final Function? onTapShowed;
  final Function? onTapExit;
  final bool? isLoading;
  final String? errorMessage;

  RegisterView({
    Key? key,
    this.autoval,
    this.formKey,
    this.email,
    this.password,
    this.obsecurePass,
    this.buttonEnable,
    this.emailController,
    this.onChangeEmail,
    this.onChangePassword,
    this.onRegister,
    this.onTapShowed,
    this.onTapExit,
    this.isLoading,
    this.fullnameController,
    this.usernameController,
    this.onChangeFullname,
    this.onChangeUsername,
    this.errorMessage,
    this.phoneController,
    this.countryCodeController,
    this.onchagePhone,
    this.onChangeCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: themeData.colorScheme.primary,
            centerTitle: false,
            title: Text(
              allTranslations.text('auth.title_register'),
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
                    height: 24,
                  ),

                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          allTranslations.text('profile.name_u'),
                          style: BaseStyle.ts14ExplicitBlackBold,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: fullnameController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              fillColor: BaseStyle.hintBgTextfieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: BaseStyle.darkBlue),
                              ),
                              hintText:
                                  allTranslations.text('profile.name_hint')),
                          keyboardType: TextInputType.emailAddress,
                          style: BaseStyle.ts14ExplicitBlack,
                          validator: (String? textin) {
                            if (textin!.isEmpty) {
                              return allTranslations
                                  .text('auth.username_error_empty');
                            } else if (textin.length <= 2) {
                              return allTranslations
                                  .text('auth.fullname_error_length');
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: onChangeFullname,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Username',
                          style: BaseStyle.ts14ExplicitBlackBold,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              fillColor: BaseStyle.hintBgTextfieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: BaseStyle.darkBlue),
                              ),
                              hintText: 'Example : hafiz123'),
                          keyboardType: TextInputType.text,
                          style: BaseStyle.ts14ExplicitBlack,
                          validator: (String? textin) {
                            if (textin!.isEmpty) {
                              return allTranslations
                                  .text('auth.username_error_empty');
                            } else if (textin.length < 6) {
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
                          allTranslations.text('profile.phone_address_u'),
                          style: BaseStyle.ts14ExplicitBlackBold,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  border: Border.fromBorderSide(
                                      BorderSide(color: Colors.grey)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: CountryCodePicker(
                                onChanged: onChangeCountry,
                                showFlag: true,
                                showFlagDialog: true,
                                // showDropDownButton: true,
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: '+62',
                                favorite: ['+62', 'ID'],
                                // optional. Shows only country name and flag
                                showCountryOnly: true,
                                flagWidth: 15,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 15),
                                padding: const EdgeInsets.all(0),

                                showDropDownButton: true,

                                // optional. Shows only country name and flag when popup is closed.
                                // showOnlyCountryWhenClosed: true,
                                // optional. aligns the flag and the Text left
                                // alignLeft: true,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(16),
                                    fillColor: BaseStyle.hintBgTextfieldColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide:
                                          BorderSide(color: BaseStyle.darkBlue),
                                    ),
                                    hintText: allTranslations
                                        .text('profile.phone_hint')),
                                keyboardType: TextInputType.phone,
                                style: BaseStyle.ts14ExplicitBlack,
                                validator: (String? textin) {
                                  if (textin!.isEmpty) {
                                    return allTranslations
                                        .text('auth.username_error_empty');
                                  } else if (textin.length < 6) {
                                    return allTranslations
                                        .text('auth.username_error_length');
                                  }
                                  return null;
                                },
                                autovalidateMode: AutovalidateMode.always,
                                onChanged: onchagePhone,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          allTranslations.text('profile.email_address_u'),
                          style: BaseStyle.ts14ExplicitBlackBold,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              fillColor: BaseStyle.hintBgTextfieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: BaseStyle.darkBlue),
                              ),
                              hintText:
                                  allTranslations.text('profile.email_hint')),
                          keyboardType: TextInputType.emailAddress,
                          style: BaseStyle.ts14ExplicitBlack,
                          validator: (String? textin) {
                            if (textin!.isEmpty) {
                              return allTranslations
                                  .text('auth.username_error_empty');
                            } else if (!emailRegExp
                                .hasMatch(textin.toString())) {
                              return allTranslations
                                  .text('auth.register_not_valid_email');
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: onChangeEmail,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          allTranslations.text('profile.password'),
                          style: BaseStyle.ts14ExplicitBlackBold,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              fillColor: BaseStyle.hintBgTextfieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: BaseStyle.darkBlue),
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
                            } else if (!passRegexp
                                .hasMatch(textin.toString())) {
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
                    height: 83,
                  ),
                  // loginSuccess
                  //     ? Align(
                  //         alignment: Alignment.center,
                  //         child: Text(''),
                  //       )
                  //     : Align(
                  //         alignment: Alignment.center,
                  //         child: Text(
                  //           'Your email or password is incorrect',
                  //           style: BaseStyle.ts14RedBold,
                  //         ),
                  //       ),
                  errorMessage!.isNotEmpty
                      ? Text(
                          '$errorMessage',
                          style: BaseStyle.ts12RedBold,
                        )
                      : Container(),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: !emailRegExp.hasMatch(email!) ||
                                  !passRegexp.hasMatch(password!) ||
                                  isLoading!
                              ? null
                              : () {
                                  onRegister!();
                                },
                          child: isLoading!
                              ? CircularProgressIndicator()
                              : Text(
                                  allTranslations.text('auth.title_register'),
                                  style: BaseStyle.ts14WhiteBold,
                                ),
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            padding: EdgeInsets.all(16),
                          ))),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
