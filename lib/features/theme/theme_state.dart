
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}



class ThemeLoaded extends ThemeState {
  final ThemeData themeData;

  ThemeLoaded({required this.themeData});

  @override
  List<Object> get props => [themeData];
}
