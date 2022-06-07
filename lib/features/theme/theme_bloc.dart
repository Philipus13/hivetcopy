import 'package:bloc/bloc.dart';
import 'package:hivet/core/style/theme.dart';
import 'package:hivet/features/theme/theme_event.dart';
import 'package:hivet/features/theme/theme_state.dart';

//this is the event for languange bloc

class ThemesBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemesBloc() : super(ThemeLoaded(themeData: appThemeData[AppTheme.Dark]!)) {
    on<ThemeChanged>(_onLoadTheme);
  }

  void _onLoadTheme(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeLoaded(themeData: appThemeData[event.theme]!));
  }
}
