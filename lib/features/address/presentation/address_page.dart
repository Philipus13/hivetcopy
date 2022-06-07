import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/core/widget/custom_button.dart';
import 'package:hivet/core/widget/icon_image_tab.dart';

import 'package:hivet/core/widget/loading_spin_kit_widget.dart';
import 'package:hivet/core/widget/custom_toast.dart';
import 'package:hivet/features/address/presentation/address_list_item.dart';
import 'package:hivet/features/address/presentation/bloc/address_bloc.dart';
import 'package:hivet/features/address/presentation/bloc/address_state.dart';
import 'package:hivet/features/address/model/address_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/address_event.dart';

// ScrollController _scrollController = ScrollController();
final ItemScrollController itemScrollController = ItemScrollController();
int? indexChoosen;
List<Data>? listAddress;

class AddressPage extends StatelessWidget {
  const AddressPage({
    Key? key,
  }) : super(key: key);

  Widget buildInitialLoading(ThemeData themeData) {
    return Container(
      color: themeData.colorScheme.primary,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: LoadingSpinKit(color: Colors.white, ukuran: 50),
          )
        ],
      )),
    );
  }

  Widget buildInitialView(BuildContext context, RoutingService _routingService,
      ThemeData themeData, AddressState state) {
    if (state.addressList != null) {
      listAddress = state.addressList!.reversed.toList();
    }

    return Container(
      width: double.infinity,
      // constraints: BoxConstraints(minWidth: 300, maxWidth: 600),
      child: listAddress == null || listAddress == []
          ? Center(
              child: Container(
              child: Text(allTranslations.text('address.no_message')),
            ))
          : ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              // reverse: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return AddressListItem(
                  addressModel: listAddress![index],
                  index: index,
                  state: state,
                );
              },
              itemCount: listAddress!.length,
            ),
    );
  }

  scrollToTop(int top) async {
    // await Future.delayed(const Duration(seconds: 2), () {
    //   final position = _scrollController.position.maxScrollExtent + 1;
    //   _scrollController.animateTo(
    //     position,
    //     duration: Duration(seconds: 1),
    //     curve: Curves.easeOut,
    //   );
    // });
    await Future.delayed(const Duration(seconds: 1), () {
      itemScrollController.scrollTo(
          index: top,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
      // itemScrollController.jumpTo(index: top);
    });
  }

  @override
  Widget build(BuildContext context) {
    AddressBloc addressBloc = BlocProvider.of<AddressBloc>(context);
    addressBloc.add(AddressInitEvent(null, FromAddress.init));

    final RoutingService _routingService = g<RoutingService>();
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.primary,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _routingService.goBack();
            addressBloc.add(GoBackEvent());
          },
        ),
        title: Text(
          allTranslations.text('address.choose_address'),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: IconImageTab(
                imageAsset: 'assets/images/add_icon.png',
                colors: themeData.colorScheme.background),
            onPressed: () async {
              final result = await _routingService
                  .navigateTo(CommonConstants.routeAddAdress);
              if (result != null && result) {
                addressBloc.add(AddressInitEvent(null, FromAddress.post));
              }
            },
          )
        ],
      ),
      body: BlocConsumer<AddressBloc, AddressState>(
          listener: (context, state) async {
        if (state.isSuccess) {
          switch (state.isFrom) {
            case FromAddress.init:
              await Future.delayed(const Duration(milliseconds: 1000), () {
                if (state.addressList != null) {
                  listAddress = state.addressList!.reversed.toList();
                }
                int? jumpto = listAddress
                    ?.indexWhere((element) => element.isActive == true);
                indexChoosen = jumpto;

                itemScrollController.scrollTo(
                    index: jumpto!,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOutCubic);
                // }
              });
              break;
            case FromAddress.choose:
              indexChoosen = state.indexChoosen;
              break;
            case FromAddress.post:
              if (state.addressList != null) {
                listAddress = state.addressList!.reversed.toList();
              }
              await Future.delayed(const Duration(seconds: 1), () {
                itemScrollController.scrollTo(
                    index: 0,
                    duration: Duration(seconds: 2),
                    curve: Curves.easeInOutCubic);
                // itemScrollController.jumpTo(index: top);
              });
              break;
            case FromAddress.patch:
              if (state.addressList != null) {
                listAddress = state.addressList!.reversed.toList();
              }
              await Future.delayed(const Duration(seconds: 1), () {
                //add
                itemScrollController.scrollTo(
                    index: state.patchIndex!,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOutCubic);
              });
              break;

            case FromAddress.delete:
              if (state.addressList != null) {
                listAddress = state.addressList!.reversed.toList();
              }

              CustomToast.showToast(
                  msg: allTranslations.text('address.delete_success_message'),
                  statusToast: StatusToast.success,
                  context: context,
                  isAutoClosed: true);
              break;
            case FromAddress.submit:
              addressBloc.add(GoBackEvent());
              String? address = listAddress![indexChoosen!].address;
              _routingService.goBackPopStack(address);

              // Toast.show('Submit success', StatusToast.success, context);
              // await Future.delayed(const Duration(seconds: 2), () {
              //   Toast.dismiss();
              // });
              CustomToast.showToast(
                  msg: allTranslations.text('address.submit_success_message'),
                  statusToast: StatusToast.success,
                  context: context,
                  isAutoClosed: true);

              break;
            default:
          }
        }

        if (state.isError) {
          switch (state.isFrom) {
            case FromAddress.init:
              CustomToast.showToast(
                  msg: allTranslations.text('address.load_list_fail_message'),
                  statusToast: StatusToast.fail,
                  context: context,
                  isAutoClosed: true);
              break;

            case FromAddress.delete:
              CustomToast.showToast(
                  msg: allTranslations.text('address.delete_fail_message'),
                  statusToast: StatusToast.fail,
                  context: context,
                  isAutoClosed: true);
              break;

            case FromAddress.submit:
              CustomToast.showToast(
                  msg: allTranslations.text('address.submit_fail_message'),
                  statusToast: StatusToast.fail,
                  context: context,
                  isAutoClosed: true);
              break;
            default:
          }
        }
      }, builder: (BuildContext context, AddressState state) {
        return buildInitialView(context, _routingService, themeData, state);
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
            isLoading: false,
            text: allTranslations.text('profile.save'),
            onPressed: () {
              if (indexChoosen != null) {
                String? addressId = listAddress![indexChoosen!].id;
                // String? type = listAddress![indexChoosen!].type;
                // print('pilih ini = ' +
                //     addressId! +
                //     ' index = ' +
                //     indexChoosen.toString() +
                //     ' type = ' +
                //     type!);
                addressBloc.add(SubmitAddressEvent(addressId));
                // CustomToast.showToast(
                //   msg: 'Delete success',
                //   statusToast: StatusToast.success,
                //   context: context,
                // );
              }
            }),
      ),
    );
  }
}
