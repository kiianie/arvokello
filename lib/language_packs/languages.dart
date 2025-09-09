import 'finnish.dart';
import 'english.dart';

enum AppLanguage { finnish, english }

final Map<AppLanguage, Map<String, String>> languagePacks = {
	AppLanguage.finnish: finnishPack,
	AppLanguage.english: englishPack,
};
