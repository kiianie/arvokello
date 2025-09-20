import 'finnish.dart';
import 'english.dart';
import 'german.dart';

enum AppLanguage { finnish, english, german }

final Map<AppLanguage, Map<String, String>> languagePacks = {
	AppLanguage.finnish: finnishPack,
	AppLanguage.english: englishPack,
  AppLanguage.german: germanPack,
};
