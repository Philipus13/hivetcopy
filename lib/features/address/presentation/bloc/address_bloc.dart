import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/features/address/model/address_model.dart';
import 'package:hivet/features/address/model/post_address_model.dart';
import 'package:hivet/features/address/service/address_service.dart';

import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final instance = g<AddressService>();

  AddressBloc() : super(AddressState.initialData()) {
    on<AddressInitEvent>(_initAddress);
    on<ChooseAddressEvent>(_chooseAddress);
    on<PostAddressEvent>(_postAddress);
    on<GoBackEvent>(_goBack);
    on<PatchAddressEvent>(_patchAddress);
    on<DeleteAddressEvent>(_deleteAddress);
    on<SubmitAddressEvent>(_submitAddressEvent);
  }

  void _initAddress(
    AddressInitEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.update(isLoading: true, isSuccess: false, isError: false));

    try {
      final getAddress = await instance
          .getAddress()
          .then((value) => addressModelFromJson(json.encode(value)));

      switch (event.isFrom) {
        case FromAddress.init:
          emit(state.update(
              addressList: getAddress.data,
              isFrom: event.isFrom,
              isLoading: false,
              isSuccess: true,
              isError: false));
          break;
        case FromAddress.post:
          emit(state.update(
              addressList: getAddress.data,
              isFrom: event.isFrom,
              isLoading: false,
              isSuccess: true,
              isError: false));
          break;
        case FromAddress.patch:
          emit(state.update(
              addressList: getAddress.data,
              isFrom: event.isFrom,
              patchIndex: event.index,
              isLoading: false,
              isSuccess: true,
              isError: false));
          break;
        case FromAddress.delete:
          final getAddress = await instance
              .getAddress()
              .then((value) => addressModelFromJson(json.encode(value)));

          emit(state.update(
              addressList: getAddress.data,
              isFrom: event.isFrom,
              isLoading: false,
              isSuccess: true,
              isError: false));
          break;
        default:
      }
    } on RemoteDataSourceException catch (e) {
      emit(state.update(isError: true, message: e.message));
    }
  }

  void _chooseAddress(
    ChooseAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.update(
      isSuccess: false,
    ));

    emit(state.update(
      indexChoosen: event.index,
      isSuccess: true,
      isFrom: FromAddress.choose,
      isLoading: false,
      patchIndex: null,
    ));
  }

  void _postAddress(
    PostAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.update(isLoading: true));
    try {
      final postAddress = await instance
          .postAddress(event.data)
          .then((value) => postAddressModelFromJson(json.encode(value)));

      if (postAddress.success!) {
        emit(state.update(isSuccess: true, isFrom: FromAddress.post));
      } else {
        emit(state.update(
            isLoading: false, isError: true, isFrom: FromAddress.post));
      }
    } on RemoteDataSourceException catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          message: e.message,
          isFrom: FromAddress.post));
    } catch (e) {
      emit(state.update(
          isLoading: false,
          isFrom: FromAddress.post,
          isError: true,
          message: e.toString()));
    }
  }

  void _patchAddress(
    PatchAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.update(isLoading: true));
    try {
      final patchAddress = await instance
          .patchAddress(event.data!)
          .then((value) => postAddressModelFromJson(json.encode(value)));

      if (patchAddress.success!) {
        emit(state.update(isSuccess: true, isFrom: FromAddress.post));
      } else {
        emit(state.update(
            isLoading: false, isError: true, isFrom: FromAddress.post));
      }
    } on RemoteDataSourceException catch (e) {
      emit(state.update(
          isLoading: false,
          isFrom: FromAddress.patch,
          isError: true,
          message: e.message));
    } catch (e) {
      emit(state.update(
          isLoading: false,
          isFrom: FromAddress.patch,
          isError: true,
          message: e.toString()));
    }
  }

  void _deleteAddress(
    DeleteAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.update(isLoading: true, isSuccess: false, isError: false));
    try {
      final deleteAddress = await instance
          .deleteAddress(event.addressId)
          .then((value) => postAddressModelFromJson(json.encode(value)));

      if (deleteAddress.success!) {
        this.add(AddressInitEvent(null, FromAddress.delete));
      } else {
        emit(state.update(
            isLoading: false, isError: true, message: deleteAddress.message));
      }
    } on RemoteDataSourceException catch (e) {
      emit(state.update(isLoading: false, isError: true, message: e.message));
    }
  }

  void _submitAddressEvent(
    SubmitAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.update(isLoading: true, isSuccess: false, isError: false));
    try {
      final activatingAddress = await instance
          .activatingAdress(event.addressId)
          .then((value) => postAddressModelFromJson(json.encode(value)));

      if (activatingAddress.success!) {
        emit(state.update(
          isSuccess: true,
          isFrom: FromAddress.submit,
          message: state.message,
          isLoading: false,
        ));
      } else {
        emit(state.update(
            isLoading: false,
            isError: true,
            message: activatingAddress.message));
      }
    } on RemoteDataSourceException catch (e) {
      emit(state.update(isLoading: false, isError: true, message: e.message));
    }
  }

  void _goBack(
    GoBackEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.delete());
  }
}
