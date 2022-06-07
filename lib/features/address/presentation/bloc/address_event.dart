import 'package:hivet/features/address/model/post_address_model.dart'
    as postAddressModel;

import 'package:equatable/equatable.dart';

import 'address_state.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class AddressInitEvent extends AddressEvent {
  final int? index;
  final FromAddress? isFrom;

  const AddressInitEvent(this.index, this.isFrom);

  @override
  List<Object?> get props => [index, isFrom];
}

class GoBackEvent extends AddressEvent {
  const GoBackEvent();
}

class PostAddressEvent extends AddressEvent {
  final postAddressModel.Data data;

  const PostAddressEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class ChooseAddressEvent extends AddressEvent {
  final int? index;

  const ChooseAddressEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class DeleteAddressEvent extends AddressEvent {
  final String? addressId;

  const DeleteAddressEvent(this.addressId);

  @override
  List<Object?> get props => [addressId];
}

class SubmitAddressEvent extends AddressEvent {
  final String? addressId;

  const SubmitAddressEvent(this.addressId);

  @override
  List<Object?> get props => [addressId];
}

class PatchAddressEvent extends AddressEvent {
  final postAddressModel.Data? data;

  const PatchAddressEvent(this.data);

  @override
  List<Object?> get props => [data];
}
