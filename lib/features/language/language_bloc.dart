import 'package:bloc/bloc.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/config/shared_pref_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

//this is the event for languange bloc
enum LanguageEvent { id, en }

class LanguageBloc extends Bloc<LanguageEvent, String> {
  LanguageBloc() : super('id') {
    on<LanguageEvent>(_onLoadLanguage);
  }

  void _onLoadLanguage(
    LanguageEvent event,
    Emitter<String> emit,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (event) {
      case LanguageEvent.id:
        SharedPrefUtil.setLanguage("id", prefs);
        // Notification the translations module about the new language
        await allTranslations.setNewLanguage("id");
        emit("id");
        break;
      case LanguageEvent.en:
        SharedPrefUtil.setLanguage("en", prefs);
        // Notification the translations module about the new language
        await allTranslations.setNewLanguage("en");
        emit("en");
        break;
    }
  }
}
