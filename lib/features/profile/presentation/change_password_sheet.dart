import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/style/base_style.dart';
import 'package:hivet/features/profile/presentation/bloc/profile_bloc.dart';

import '../../../core/config/global_translations.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

TextEditingController? newPasswordController;
TextEditingController? oldPasswordController;

GlobalKey<FormState> formKey = GlobalKey<FormState>();
late ProfileBloc profileBloc;

bool obsecurePass = true;
final RegExp passRegexp = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$");

class _ChangePasswordState extends State<ChangePassword> {
  onTapShowed() {
    setState(() {
      obsecurePass = !obsecurePass;
    });
  }

  onChangePass() {
    profileBloc.add(changePasswordEvent(
        oldPasswordController!.text, newPasswordController!.text));
  }

  bool? isValid = false;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    oldPasswordController = TextEditingController();
    profileBloc = BlocProvider.of<ProfileBloc>(context);

    oldPasswordController?.addListener(() {
      setState(() {
        isValid = formKey.currentState?.validate() ?? false;
      });
    });

    newPasswordController?.addListener(() {
      setState(() {
        isValid = formKey.currentState?.validate() ?? false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    newPasswordController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              allTranslations.text('profile.change_pass'),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: themeData.textTheme.headline3?.copyWith(
                  color: themeData.colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: oldPasswordController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  fillColor: BaseStyle.hintBgTextfieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: BaseStyle.darkBlue),
                  ),
                  hintText: allTranslations.text('profile.old_pass_hint'),
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
              autovalidateMode: AutovalidateMode.always,
              onChanged: (value) {
                if (value.length > 2) {
                  isValid = formKey.currentState?.validate() ?? false;
                }
              },
            ),
            SizedBox(
              height: 15,
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
                } else if (textin == oldPasswordController?.text) {
                  return allTranslations.text('profile.new_pass_err_match');
                } else if (textin.length < 8) {
                  return allTranslations.text('profile.new_pass_err_length');
                }

                return null;
              },
              onChanged: (value) {
                if (value.length > 2) {
                  isValid = formKey.currentState?.validate() ?? false;
                }
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            SizedBox(
              height: 15,
            ),
            isValid!
                ? SizedBox(
                    height: 15,
                  )
                : Container(),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: !isValid!
                        ? null
                        : () {
                            onChangePass();
                          },
                    child:
                        // isLoading!
                        //     ? CircularProgressIndicator()
                        //     :
                        Text(
                      allTranslations.text('profile.change_pass'),
                      style: BaseStyle.ts14WhiteBold,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(6.0),
                      ),
                      padding: EdgeInsets.all(16),
                    ))),
          ],
        ),
      ),
    );
  }
}
