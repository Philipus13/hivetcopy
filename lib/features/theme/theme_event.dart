import 'package:equatable/equatable.dart';
import 'package:hivet/core/style/theme.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  const ThemeChanged(this.theme);

  @override
  List<Object> get props => [theme];
}
