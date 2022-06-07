import 'package:equatable/equatable.dart';
import 'package:hivet/features/address/model/address_model.dart';

enum FromAddress { init, choose, post, patch, delete, submit }

class AddressState extends Equatable {
  final List<Data>? addressList;
  final int? indexChoosen;
  final bool isLoading;
  final String? message;
  final bool isError;
  final bool isSuccess;
  final FromAddress isFrom;
  final int? patchIndex;

  const AddressState({
    this.addressList,
    this.indexChoosen,
    this.isLoading = false,
    this.message,
    this.isError = false,
    this.isSuccess = false,
    this.isFrom = FromAddress.init,
    this.patchIndex,
  });

  factory AddressState.initialData() {
    return AddressState(
      addressList: null,
      indexChoosen: null,
      isLoading: false,
      message: null,
      isError: false,
      isSuccess: false,
      isFrom: FromAddress.init,
      patchIndex: null,
    );
  }
  AddressState update({
    List<Data>? addressList,
    int? indexChoosen,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    FromAddress? isFrom,
    int? patchIndex,
  }) =>
      AddressState(
        addressList: addressList ?? this.addressList,
        indexChoosen: indexChoosen ?? this.indexChoosen,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        isFrom: isFrom ?? this.isFrom,
        patchIndex: patchIndex,
      );
  AddressState delete({
    List<Data>? addressList,
    int? indexChoosen,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    FromAddress? isFrom,
    int? patchIndex,
  }) =>
      AddressState(
        addressList: null,
        indexChoosen: null,
        isLoading: false,
        message: null,
        isError: false,
        isSuccess: false,
        isFrom: FromAddress.init,
        patchIndex: null,
      );

  @override
  List<Object?> get props => [
        addressList,
        indexChoosen,
        isLoading,
        message,
        isError,
        isSuccess,
        isFrom,
        patchIndex,
      ];
}
