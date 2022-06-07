import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hivet/core/config/common_constant.dart';
// import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/model/master_model.dart' as masterModel;
import 'package:hivet/features/home/service/home_service.dart';
import 'package:hivet/features/profile/model/profile_model.dart'
    as profileModel;
import 'package:hivet/features/profile/service/profile_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final profileService = g<ProfileService>();
  final homeService = g<HomeService>();

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitEvent>(_getInitHome);
  }

  void _getInitHome(
    HomeInitEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    int nowHour = TimeOfDay.now().hour;
    String weatherText = "";
    if (nowHour > 05 && nowHour < 10) {
      weatherText = 'home.weather_morning';
    } else if (nowHour > 09 && nowHour < 18) {
      weatherText = 'home.weather_afternoon';
    } else {
      weatherText = 'home.weather_night';
    }
    List<masterModel.Data>? mModel;
    profileModel.Data? pModel;
    try {
      final getMaster = await homeService
          .getMasterShopCategory()
          .then((value) => masterModel.masterModelFromJson(json.encode(value)));

      if (getMaster.success!) {
        mModel = getMaster.data;
      }

      if (event.scopes != CommonConstants.guest) {
        final getProfile = await profileService.getProfile().then(
            (value) => profileModel.profileModelFromJson(json.encode(value)));

        if (getProfile.success!) {
          pModel = getProfile.data;
        }
        // else {}
      }

      emit(HomeLoadedState(
          profileResponseModel: pModel,
          mModel: mModel,
          weatherText: weatherText));
    } on RemoteDataSourceException catch (e) {
      emit(HomeNotLoadedState(
          message: e.message,
          mModel: mModel,
          profileResponseModel: pModel,
          weatherText: weatherText));
    }
  }
}
