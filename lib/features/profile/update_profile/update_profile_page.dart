// import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/widget/custom_button.dart';
import 'package:hivet/core/widget/date_time_text_field.dart';
import 'package:hivet/core/widget/loading_spin_kit_widget.dart';
import 'package:hivet/core/widget/normal_text_field.dart';
import 'package:hivet/core/widget/phone_text_field.dart';
import 'package:hivet/core/widget/custom_toast.dart';
import 'package:hivet/features/profile/model/profile_model.dart';
import 'package:hivet/features/profile/update_profile/bloc/update_profile_bloc.dart';

TextEditingController namaController = TextEditingController();
TextEditingController nikController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController alamatController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController countryCodeController = TextEditingController();

TextEditingController descriptionController = TextEditingController();

//toko controller
TextEditingController domainController = TextEditingController();
TextEditingController sloganController = TextEditingController();

//doctor controller
TextEditingController expController = TextEditingController();
TextEditingController specializationController = TextEditingController();
TextEditingController feeController = TextEditingController();
final RoutingService _routingService = g<RoutingService>();

String dateOfBirth = '', dateServer = '';
String? phoneCountryCode, scopes;
String? titleName,
    titleEmail,
    titleNik,
    titlePhone,
    titleAddress,
    titleDate,
    titleDomain,
    titleSlogan,
    titleDesc,
    titleExp,
    titleSpecialization,
    titleFee;
TextEditingController dateController = TextEditingController();
late UpdateProfileBloc updateProfileBloc;

class UpdateProfilePage extends StatefulWidget {
  UpdateProfilePage({Key? key, this.profileModel}) : super(key: key);
  final Data? profileModel;

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  bool isLoading = false;

  @override
  void dispose() {
    _clearController();
    super.dispose();
  }

  @override
  void initState() {
    titleName = allTranslations.text('profile.name_u');
    titleEmail = allTranslations.text('profile.email_address_u');
    titleNik = allTranslations.text('profile.nik_u');
    titlePhone = allTranslations.text('profile.phone_address_u');
    titleAddress = allTranslations.text('profile.address_u');
    titleDate = allTranslations.text('profile.birth_date_u');
    titleDesc = allTranslations.text('profile.desc_d');

    namaController.text = widget.profileModel?.user?.fullName ?? '';
    emailController.text = widget.profileModel?.user?.email ?? '';
    nikController.text = widget.profileModel?.user?.nik ?? '';
    phoneController.text = widget.profileModel?.user?.phone ?? '';
    alamatController.text = widget.profileModel?.address?.address ?? '';
    phoneCountryCode = widget.profileModel?.user?.countryCode ?? '+62';
    scopes = widget.profileModel?.scopes ?? '';
    updateProfileBloc = BlocProvider.of<UpdateProfileBloc>(context);

    // String dateServer = widget.profileModel?.user?.dob ?? '';

    if (scopes == CommonConstants.toko) {
      titleName = allTranslations.text('profile.name_t');
      titleEmail = allTranslations.text('profile.email_t');
      titleAddress = allTranslations.text('profile.adress_t');
      titleDate = allTranslations.text('profile.birth_date_t');
      titleDomain = allTranslations.text('profile.domain_t');
      titleSlogan = allTranslations.text('profile.slogan_t');
      titleDesc = allTranslations.text('profile.desc_t');

      dateServer = widget.profileModel?.store?.since ?? '';
      domainController.text = widget.profileModel?.store?.domain ?? '';
      sloganController.text = widget.profileModel?.store?.slogan ?? '';
      descriptionController.text =
          widget.profileModel?.store?.description ?? '';
    } else if (scopes == CommonConstants.doctor) {
      titleExp = allTranslations.text('profile.experience');
      titleSpecialization = allTranslations.text('profile.specialization');
      titleFee = allTranslations.text('profile.fee');

      dateServer = widget.profileModel?.user?.dob ?? '';
      expController.text = widget.profileModel?.doctor?.experience ?? '';
      specializationController.text =
          widget.profileModel?.doctor?.specialization ?? '';
      feeController.text = widget.profileModel?.doctor?.fee ?? '';
      descriptionController.text =
          widget.profileModel?.doctor?.description ?? '';
    } else {
      dateServer = widget.profileModel?.user?.dob ?? '';
    }

    if (dateServer != '') {
      var dateSplit = dateServer.split('-');
      dateServer = dateSplit[2] + '-' + dateSplit[1] + '-' + dateSplit[0];
    }

    dateController.text = dateServer;
    super.initState();
  }

  Widget buildInitialLoading(ThemeData themeData) {
    return LoadingSpinKit(
      color: themeData.colorScheme.background,
      ukuran: 15,
    );
  }

  Widget buildInitialView(BuildContext context, UpdateProfileState state) {
    if (state is UpdatedProfileState) {
      namaController.text = state.profileResponseModel!.user?.fullName ?? '';
      emailController.text = state.profileResponseModel!.user?.email ?? '';
      nikController.text = state.profileResponseModel!.user?.nik ?? '';
      phoneController.text = state.profileResponseModel!.address?.phone ?? '';
      alamatController.text =
          state.profileResponseModel!.address?.address ?? '';
      phoneCountryCode =
          state.profileResponseModel!.address?.countryCode ?? '+62';

      if (scopes == CommonConstants.toko) {
        dateServer = state.profileResponseModel!.store?.since ?? '';
        domainController.text = state.profileResponseModel!.store?.domain ?? '';
        sloganController.text = state.profileResponseModel!.store?.slogan ?? '';
        descriptionController.text =
            state.profileResponseModel!.store?.description ?? '';
      } else if (scopes == CommonConstants.doctor) {
        dateServer = state.profileResponseModel!.user?.dob ?? '';
        expController.text =
            state.profileResponseModel!.doctor?.experience ?? '';
        specializationController.text =
            state.profileResponseModel!.doctor?.specialization ?? '';
        feeController.text = state.profileResponseModel!.doctor?.fee ?? '';
      } else {
        dateServer = widget.profileModel?.user?.dob ?? '';
      }

      if (dateServer != '') {
        var dateSplit = dateServer.split('-');
        dateServer = dateSplit[2] + '-' + dateSplit[1] + '-' + dateSplit[0];
      }

      dateController.text = dateServer;

      if (scopes == CommonConstants.toko) {
        dateServer = state.profileResponseModel!.store?.since ?? '';
      } else {
        dateServer = state.profileResponseModel!.user?.dob ?? '';
      }

      if (dateServer != '') {
        var dateSplit = dateServer.split('-');
        dateServer = dateSplit[2] + '-' + dateSplit[1] + '-' + dateSplit[0];
      }

      dateController.text = dateServer;
    }
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
              child: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              children: [
                // GestureDetector(
                //   // onTap: _buttonTapped,
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 18),
                //     child: Container(
                //       width: 200,
                //       margin: EdgeInsets.only(right: 16, left: 16),
                //       padding: EdgeInsets.all(10),
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Theme.of(context).colorScheme.primary,
                //           width: 1.5,
                //         ),
                //         borderRadius: BorderRadius.circular(8),
                //         color: Theme.of(context).colorScheme.background,
                //       ),
                //       child: Text(
                //         allTranslations.text('profile.update_photo'),
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 14,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                SizedBox(
                  height: 25,
                ),
                NormalTextField(
                  textEditingController: namaController,
                  title: titleName!,
                  hint: allTranslations.text('profile.name_hint'),
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: 10,
                ),
                NormalTextField(
                  textEditingController: emailController,
                  title: titleEmail!,
                  hint: allTranslations.text('profile.email_hint'),
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 10,
                ),
                scopes != CommonConstants.toko
                    ? NormalTextField(
                        textEditingController: nikController,
                        title: titleNik!,
                        hint: allTranslations.text('profile.nik_hint'),
                        textInputType: TextInputType.name,
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                PhoneTextField(
                  textEditingController: phoneController,
                  countryCodeController: countryCodeController,
                  title: titlePhone!,
                  hint: allTranslations.text('profile.phone_hint'),
                  textInputType: TextInputType.phone,
                  initialSelect: phoneCountryCode,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await _routingService.navigateTo(
                      CommonConstants.routeAdress,
                    );
                    if (result != null) {
                      String res = result.toString();
                      setState(() {
                        alamatController.text = res;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: NormalTextField(
                      textEditingController: alamatController,
                      title: titleAddress!,
                      hint: allTranslations.text('profile.address_hint'),
                      textInputType: TextInputType.multiline,
                      maxLines: 5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DateTimeTextField(
                  dateController: dateController,
                  title: titleDate!,
                ),
                SizedBox(
                  height: 10,
                ),
                scopes == CommonConstants.doctor
                    ? Column(
                        children: [
                          NormalTextField(
                            textEditingController: expController,
                            title: titleExp!,
                            hint: '',
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NormalTextField(
                            textEditingController: specializationController,
                            title: titleSpecialization!,
                            hint: '',
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NormalTextField(
                            textEditingController: feeController,
                            title: titleFee!,
                            hint: '',
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NormalTextField(
                            textEditingController: descriptionController,
                            title: titleDesc!,
                            hint: '',
                            textInputType: TextInputType.multiline,
                            maxLines: 5,
                          ),
                        ],
                      )
                    : Container(),
                scopes == CommonConstants.toko
                    ? Column(
                        children: [
                          NormalTextField(
                            textEditingController: domainController,
                            title: titleDomain!,
                            hint: '',
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NormalTextField(
                            textEditingController: sloganController,
                            title: titleSlogan!,
                            hint: '',
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NormalTextField(
                            textEditingController: descriptionController,
                            title: titleDesc!,
                            hint: '',
                            textInputType: TextInputType.text,
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
          )),
        ),
      ],
    );
  }

  void _clearController() {
    namaController.clear();
    nikController.clear();
    emailController.clear();
    alamatController.clear();
    phoneController.clear();
    countryCodeController.clear();
    descriptionController.clear();
    domainController.clear();
    sloganController.clear();
    expController.clear();
    specializationController.clear();
    feeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.primary,
        centerTitle: false,
        title: Text(
          allTranslations.text('profile.title_update_profile'),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _routingService.goBackPopStack(true);
            _clearController();
          },
        ),
        elevation: 0.0,
      ),
      body: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
          // bloc: updateProfileBloc,
          listener: (context, state) {
        if (state is UpdatedProfileState) {
          CustomToast.showToast(
            msg: allTranslations.text('profile.update_success_message'),
            statusToast: StatusToast.success,
            context: context,
          );
        }
        if (state is UpdatedProfileFailedState) {
          CustomToast.showToast(
            msg: allTranslations.text('profile.update_fail_message'),
            statusToast: StatusToast.fail,
            context: context,
          );
        }
      }, builder: (context, state) {
        if (state is UpdateProfileLoadingState) {
          return buildInitialLoading(themeData);
        }

        return buildInitialView(context, state);
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
            isLoading: false,
            text: allTranslations.text('profile.save'),
            onPressed: () {
              String? dateSend;
              if (dateController.text != '') {
                var dateSplit = dateController.text.split('-');
                dateSend =
                    dateSplit[2] + '-' + dateSplit[1] + '-' + dateSplit[0];
              }
              Data? profileData;

              User user = User(
                  fullName: namaController.text,
                  email: emailController.text,
                  nik: nikController.text,
                  dob: dateSend,
                  phone: phoneController.text,
                  countryCode: countryCodeController.text);
              Address address = Address(
                  countryCode: countryCodeController.text,
                  phone: phoneController.text,
                  address: alamatController.text);

              if (scopes == CommonConstants.toko) {
                Store store = Store(
                    domain: domainController.text,
                    slogan: sloganController.text,
                    description: descriptionController.text,
                    since: dateSend);

                profileData = Data(
                  user: user,
                  store: store,
                  address: address,
                );
              } else if (scopes == CommonConstants.doctor) {
                Doctor doctor = Doctor(
                    experience: expController.text,
                    specialization: specializationController.text,
                    description: descriptionController.text,
                    fee: feeController.text);
                profileData = Data(
                  user: user,
                  doctor: doctor,
                  address: address,
                );
              } else {
                profileData = Data(
                  user: user,
                  address: address,
                );
              }

              updateProfileBloc.add(UpdatingProfileEvent(profileData));
              // Toast.show(
              //     'Profil berhasil dirubah', StatusToast.success, context);
            }),
      ),
    );
  }
}
