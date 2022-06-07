import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:flutter/material.dart';
import 'package:hivet/core/style/size_config.dart';
import 'package:hivet/core/widget/custom_bottom_sheet.dart';
import 'package:hivet/core/widget/custom_button.dart';
import 'package:hivet/features/address/presentation/bloc/address_bloc.dart';
import 'package:hivet/features/address/presentation/bloc/address_event.dart';
import 'package:hivet/features/address/presentation/bloc/address_state.dart';
import 'package:hivet/features/address/model/address_model.dart';

class AddressListItem extends StatelessWidget {
  final Data addressModel;
  final int index;
  final AddressState state;

  const AddressListItem(
      {Key? key,
      required this.addressModel,
      required this.index,
      required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddressBloc addressBloc = BlocProvider.of<AddressBloc>(context);

    final RoutingService _routingService = g<RoutingService>();
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    bool isActive = false;

    if (state.indexChoosen == null) {
      isActive = addressModel.isActive ?? false;
    } else {
      if (state.indexChoosen == index) {
        isActive = true;
      }
    }

    Color primaryColor = isActive
        ? themeData.colorScheme.background
        : themeData.colorScheme.primary;
    Color backgroundColor = isActive
        ? themeData.colorScheme.primary
        : themeData.colorScheme.background;

    // dynamic test = {'value': 'as', 'value2': 'bes'};
    String type = addressModel.type ?? '-';
    String name = addressModel.name ?? '';
    String address = addressModel.address ?? '';
    String countryCode = addressModel.countryCode ?? '';
    String phone = addressModel.phone ?? '';
    // String postalCode = addressModel.postalCode ?? '';

    return GestureDetector(
      onTap: () async {
        addressBloc..add(ChooseAddressEvent(index));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: themeData.colorScheme.primary),
            borderRadius: new BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  type.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: themeData.textTheme.headline3?.copyWith(
                      color: primaryColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 2,
                ),
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: themeData.textTheme.headline4?.copyWith(
                    color: primaryColor,
                  ),
                ),
                Text(
                  address,
                  overflow: TextOverflow.ellipsis,
                  style: themeData.textTheme.headline4?.copyWith(
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 2,
                ),
                Text(
                  countryCode + ' ' + phone,
                  overflow: TextOverflow.ellipsis,
                  style: themeData.textTheme.headline5?.copyWith(
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 3,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: SizeConfig.blockSizeHorizontal! * 40,
                      child: CustomButton(
                          isLoading: false,
                          text: allTranslations.text('address.update'),
                          backgroundColor: primaryColor,
                          textColor: backgroundColor,
                          size: 35,
                          onPressed: () async {
                            final result = await _routingService.navigateTo(
                                CommonConstants.routeAddAdress,
                                arguments: addressModel);
                            if (result != null && result) {
                              addressBloc.add(
                                  AddressInitEvent(index, FromAddress.patch));
                            }
                          }),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        CustomBottomSheet.showBottomSheet(
                            context: context,
                            height: 30,
                            widget: BottomSheetDeleteAddress(
                                themeData: themeData,
                                type: type,
                                name: name,
                                countryCode: countryCode,
                                phone: phone,
                                address: address,
                                addressBloc: addressBloc,
                                addressModel: addressModel));

                        // addressBloc.add(DeleteAddressEvent(addressModel.id));
                      },
                      child: Icon(
                        CupertinoIcons.trash,
                        size: 35,
                        color: primaryColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetDeleteAddress extends StatelessWidget {
  const BottomSheetDeleteAddress({
    Key? key,
    required this.themeData,
    required this.type,
    required this.name,
    required this.countryCode,
    required this.phone,
    required this.address,
    required this.addressBloc,
    required this.addressModel,
  }) : super(key: key);

  final ThemeData themeData;
  final String type;
  final String name;
  final String countryCode;
  final String phone;
  final String address;
  final AddressBloc addressBloc;
  final Data addressModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              allTranslations.text('address.delete_address'),
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
                  type.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: themeData.textTheme.headline5?.copyWith(
                      color: themeData.colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  name + ' (' + countryCode + ' ' + phone + ')',
                  overflow: TextOverflow.ellipsis,
                  style: themeData.textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: themeData.colorScheme.primary,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  address,
                  overflow: TextOverflow.ellipsis,
                  style: themeData.textTheme.headline6?.copyWith(
                    color: themeData.colorScheme.primary,
                  ),
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
                    text: allTranslations.text('address.cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomButton(
                    size: 40,
                    isLoading: false,
                    text: allTranslations.text('address.delete'),
                    onPressed: () {
                      addressBloc.add(DeleteAddressEvent(addressModel.id));
                      Navigator.pop(context);
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
