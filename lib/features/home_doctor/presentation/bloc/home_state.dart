part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final profileModel.Data? profileResponseModel;
  final List<masterModel.Data>? mModel;
  final String? weatherText;

  HomeLoadedState({this.profileResponseModel, this.mModel, this.weatherText});

  @override
  List<Object?> get props =>
      [this.profileResponseModel, this.mModel, this.weatherText];
}

class HomeNotLoadedState extends HomeState {
  final String? message;
  final profileModel.Data? profileResponseModel;
  final List<masterModel.Data>? mModel;
  final String? weatherText;

  HomeNotLoadedState(
      {this.message, this.profileResponseModel, this.mModel, this.weatherText});

  @override
  List<Object?> get props =>
      [this.message, this.profileResponseModel, this.mModel, this.weatherText];
}
