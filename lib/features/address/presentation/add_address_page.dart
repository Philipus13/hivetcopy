// import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/widget/custom_button.dart';
import 'package:hivet/core/widget/loading_spin_kit_widget.dart';
import 'package:hivet/core/widget/normal_text_field.dart';
import 'package:hivet/core/widget/phone_text_field.dart';
import 'package:hivet/core/widget/custom_toast.dart';
import 'package:hivet/features/address/presentation/bloc/address_bloc.dart';
import 'package:hivet/features/address/presentation/bloc/address_event.dart';
import 'package:hivet/features/address/presentation/bloc/address_state.dart';
import 'package:hivet/features/address/model/address_model.dart';
import 'package:hivet/features/address/model/post_address_model.dart'
    as postAddressModel;

import 'bloc/address_bloc.dart';

TextEditingController addressAsController = TextEditingController();
TextEditingController recipientController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController countryCodeController = TextEditingController();
TextEditingController postalController = TextEditingController();
TextEditingController addressController = TextEditingController();

final RoutingService _routingService = g<RoutingService>();

String? phoneCountryCode, scopes;
String titleAddressAs = allTranslations.text('address.address_as'),
    titleRecipient = allTranslations.text('address.recipient_name'),
    titlePhone = allTranslations.text('address.phone'),
    titlePostal = allTranslations.text('address.postal_code'),
    titleAddress = allTranslations.text('address.address');
TextEditingController dateController = TextEditingController();

class AddAddressPage extends StatefulWidget {
  AddAddressPage({Key? key, this.addressModel}) : super(key: key);
  final Data? addressModel;

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  bool isLoading = false;
  AddressBloc? addressBloc;

  @override
  void initState() {
    // String dateServer = widget.profileModel?.user?.dob ?? '';
    if (widget.addressModel != null) {
      addressAsController.text = widget.addressModel?.type ?? '';
      recipientController.text = widget.addressModel?.name ?? '';
      phoneController.text = widget.addressModel?.phone ?? '';
      countryCodeController.text = widget.addressModel?.countryCode ?? '+62';
      postalController.text = widget.addressModel?.postalCode ?? '';
      addressController.text = widget.addressModel?.address ?? '';
    }
    addressBloc = AddressBloc();

    super.initState();
  }

  Widget buildInitialLoading(ThemeData themeData) {
    return LoadingSpinKit(
      color: themeData.colorScheme.background,
      ukuran: 15,
    );
  }

  Widget buildInitialView(BuildContext context, AddressState state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
              child: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                NormalTextField(
                  textEditingController: addressAsController,
                  title: titleAddressAs,
                  hint: allTranslations.text('address.address_as_hint'),
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: 10,
                ),
                NormalTextField(
                  textEditingController: recipientController,
                  title: titleRecipient,
                  hint: allTranslations.text('address.name_hint'),
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: 10,
                ),
                PhoneTextField(
                  textEditingController: phoneController,
                  countryCodeController: countryCodeController,
                  title: titlePhone,
                  hint: allTranslations.text('address.phone_hint'),
                  textInputType: TextInputType.phone,
                  initialSelect: phoneCountryCode,
                ),
                SizedBox(
                  height: 10,
                ),
                NormalTextField(
                  textEditingController: addressController,
                  title: titleAddress,
                  hint: allTranslations.text('address.address_hint'),
                  textInputType: TextInputType.multiline,
                  maxLines: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                NormalTextField(
                  textEditingController: postalController,
                  title: titlePostal,
                  hint: allTranslations.text('address.post_hint'),
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.primary,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.of(context).pop();
            addressAsController.clear();
            recipientController.clear();
            phoneController.clear();
            countryCodeController.clear();
            postalController.clear();
            addressController.clear();
            _routingService.goBack();
          },
        ),
        title: Text(
          widget.addressModel != null
              ? allTranslations.text('address.patch_address')
              : allTranslations.text('address.post_address'),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
      ),
      body: BlocConsumer<AddressBloc, AddressState>(
          bloc: addressBloc,
          listener: (context, state) {
            if (state.isSuccess) {
              _routingService.goBackPopStack(true);

              addressAsController.clear();
              recipientController.clear();
              phoneController.clear();
              countryCodeController.clear();
              postalController.clear();
              addressController.clear();
              String? message;
              if (state.isFrom == FromAddress.post) {
                message = allTranslations.text('address.post_success_message');
              }
              if (state.isFrom == FromAddress.patch) {
                message = allTranslations.text('address.patch_success_message');
              }

              CustomToast.showToast(
                  msg: message ?? '',
                  statusToast: StatusToast.success,
                  context: context,
                  isAutoClosed: true);
            }
            if (state.isError) {
              String? message;
              if (state.isFrom == FromAddress.post) {
                message = allTranslations.text('address.post_fail_message');
              }
              if (state.isFrom == FromAddress.patch) {
                message = allTranslations.text('address.patch_fail_message');
              }

              CustomToast.showToast(
                  msg: message ?? '',
                  statusToast: StatusToast.fail,
                  context: context,
                  isAutoClosed: true);
            }
          },
          builder: (context, state) {
            return buildInitialView(context, state);
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
            isLoading: false,
            text: allTranslations.text('profile.save'),
            onPressed: () {
              postAddressModel.Data send = postAddressModel.Data(
                  id: widget.addressModel?.id,
                  type: addressAsController.text,
                  name: recipientController.text,
                  countryCode: countryCodeController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                  postalCode: postalController.text);

              if (widget.addressModel != null) {
                addressBloc!.add(PatchAddressEvent(send));
              } else {
                addressBloc!.add(PostAddressEvent(send));
              }
            }),
      ),
    );
  }
}
